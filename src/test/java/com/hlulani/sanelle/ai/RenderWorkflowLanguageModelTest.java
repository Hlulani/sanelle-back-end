package com.hlulani.sanelle.ai;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hlulani.sanelle.exception.AiException;
import com.sun.net.httpserver.HttpServer;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

/** The API runs the Render Workflow, and falls back to the direct call when it can't. */
class RenderWorkflowLanguageModelTest {

    private final ObjectMapper json = new ObjectMapper();
    private final List<String> requests = new ArrayList<>();
    private HttpServer render;

    @AfterEach
    void stop() {
        if (render != null) render.stop(0);
    }

    private String fakeRender(String runStatus, String result) throws Exception {
        render = HttpServer.create(new InetSocketAddress("127.0.0.1", 0), 0);
        render.createContext("/v1/task-runs", ex -> {
            requests.add(ex.getRequestMethod() + " " + ex.getRequestURI() + " " + ex.getRequestHeaders().getFirst("Authorization")
                    + " " + new String(ex.getRequestBody().readAllBytes(), StandardCharsets.UTF_8));
            String body = ex.getRequestMethod().equals("POST")
                    ? "{\"id\":\"trn-1\",\"status\":\"pending\"}"
                    : "{\"id\":\"trn-1\",\"status\":\"" + runStatus + "\",\"results\":[" + result + "]}";
            byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
            ex.sendResponseHeaders(ex.getRequestMethod().equals("POST") ? 202 : 200, bytes.length);
            ex.getResponseBody().write(bytes);
            ex.close();
        });
        render.start();
        return "http://127.0.0.1:" + render.getAddress().getPort() + "/v1";
    }

    private RenderWorkflowLanguageModel model(String url, String renderKey, String anthropicKey) {
        return new RenderWorkflowLanguageModel(new AnthropicLanguageModel(anthropicKey, "m", json), json,
                renderKey, "sanelle-ai/sanelle_insights", url, 10);
    }

    @Test
    void runsTheWorkflowTaskAndReturnsItsReviewedDraft() throws Exception {
        String url = fakeRender("completed", "{\"brief\":\"Reviewed.\",\"questions\":[],\"matches\":[]}");
        RenderWorkflowLanguageModel m = model(url, "rnd_test", "sk-ant-x");
        JsonNode out = m.structured("sys", "user", "record_insights", json.readTree("{}"));
        assertThat(out.path("brief").asText()).isEqualTo("Reviewed.");
        assertThat(requests.get(0)).startsWith("POST /v1/task-runs Bearer rnd_test")
                .contains("\"task\":\"sanelle-ai/sanelle_insights\"").contains("\"toolName\":\"record_insights\"");
        assertThat(requests.get(1)).startsWith("GET /v1/task-runs/trn-1");
        assertThat(m.pipeline()).contains("render-workflow (draft, review, checks)");
    }

    @Test
    void fallsBackToTheDirectCallWhenTheWorkflowFails() throws Exception {
        String url = fakeRender("failed", "null");
        RenderWorkflowLanguageModel m = model(url, "rnd_test", "");
        // The direct call has no key here, so it reports unavailable; the workflow error is kept for diagnosis.
        assertThatThrownBy(() -> m.structured("sys", "user", "t", json.readTree("{}"))).isInstanceOf(AiException.class);
        assertThat(m.lastError()).startsWith("workflow: task run failed");
    }

    @Test
    void usesTheDirectCallWhenNoWorkflowIsConfigured() {
        RenderWorkflowLanguageModel m = model("http://127.0.0.1:1/v1", "", "sk-ant-x");
        assertThat(m.workflowConfigured()).isFalse();
        assertThat(m.pipeline()).startsWith("direct (no workflow configured)");
        assertThat(m.available()).isTrue();
    }
}
