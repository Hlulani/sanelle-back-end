package com.hlulani.sanelle.ai;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Component;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.time.Instant;
import java.util.Set;

/**
 * Runs Sanelle AI as a Render Workflow (workflow/ in this repo): one task drafts, a second,
 * independent model call reviews the draft and can only remove items, and this API's own rule
 * checks run last. If the workflow isn't configured or fails, the direct call is used instead,
 * so drafting never depends on it.
 */
@Primary
@Component
public class RenderWorkflowLanguageModel implements LanguageModel {

    private static final Logger log = LoggerFactory.getLogger(RenderWorkflowLanguageModel.class);
    private static final Set<String> DONE = Set.of("completed", "succeeded");
    private static final Set<String> FAILED = Set.of("failed", "canceled");

    private final AnthropicLanguageModel direct;
    private final ObjectMapper json;
    private final String renderApiKey;
    private final String taskSlug;
    private final URI api;
    private final Duration wait;
    private final HttpClient http = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(10)).build();
    private volatile String lastPipeline = "none yet";
    private volatile String lastWorkflowError;

    public RenderWorkflowLanguageModel(AnthropicLanguageModel direct, ObjectMapper json,
                                       @Value("${app.ai.render-api-key:}") String renderApiKey,
                                       @Value("${app.ai.workflow-task:sanelle-ai/sanelle_insights}") String taskSlug,
                                       @Value("${app.ai.render-api-url:https://api.render.com/v1}") String api,
                                       @Value("${app.ai.workflow-wait-seconds:90}") long waitSeconds) {
        this.direct = direct;
        this.json = json;
        this.renderApiKey = renderApiKey == null ? "" : renderApiKey.trim();
        this.taskSlug = taskSlug;
        this.api = URI.create(api.endsWith("/") ? api : api + "/");
        this.wait = Duration.ofSeconds(waitSeconds);
    }

    boolean workflowConfigured() {
        return !renderApiKey.isEmpty() && !taskSlug.isBlank();
    }

    @Override
    public boolean available() {
        return direct.available();
    }

    @Override
    public String unavailableReason() {
        return direct.unavailableReason();
    }

    @Override
    public String lastError() {
        return lastWorkflowError != null ? "workflow: " + lastWorkflowError : direct.lastError();
    }

    @Override
    public String pipeline() {
        return (workflowConfigured() ? "render-workflow " + taskSlug : "direct (no workflow configured)")
                + "; last draft: " + lastPipeline;
    }

    @Override
    public JsonNode structured(String system, String user, String toolName, JsonNode toolSchema) {
        if (workflowConfigured()) {
            try {
                JsonNode out = runWorkflow(system, user, toolName, toolSchema);
                lastPipeline = "render-workflow (draft, review, checks)";
                lastWorkflowError = null;
                return out;
            } catch (Exception e) {
                lastWorkflowError = e.getMessage() == null ? e.getClass().getSimpleName() : e.getMessage();
                if (lastWorkflowError.length() > 300) lastWorkflowError = lastWorkflowError.substring(0, 300);
                log.warn("Sanelle AI workflow failed, using the direct call: {}", lastWorkflowError);
            }
        }
        JsonNode out = direct.structured(system, user, toolName, toolSchema);
        lastPipeline = "direct (draft, checks)";
        return out;
    }

    private JsonNode runWorkflow(String system, String user, String toolName, JsonNode schema) throws Exception {
        ObjectNode prompt = json.createObjectNode()
                .put("system", system).put("user", user).put("toolName", toolName);
        prompt.set("schema", schema);
        ObjectNode body = json.createObjectNode().put("task", taskSlug);
        body.putArray("input").add(prompt);

        HttpResponse<String> started = http.send(request(api.resolve("task-runs"))
                .POST(HttpRequest.BodyPublishers.ofString(json.writeValueAsString(body))).build(),
                HttpResponse.BodyHandlers.ofString());
        if (started.statusCode() / 100 != 2)
            throw new IllegalStateException("start " + started.statusCode() + " " + brief(started.body()));
        String id = json.readTree(started.body()).path("id").asText("");
        if (id.isEmpty()) throw new IllegalStateException("start returned no task run id");

        Instant deadline = Instant.now().plus(wait);
        while (Instant.now().isBefore(deadline)) {
            Thread.sleep(1000);
            HttpResponse<String> polled = http.send(request(api.resolve("task-runs/" + id)).GET().build(),
                    HttpResponse.BodyHandlers.ofString());
            if (polled.statusCode() / 100 != 2) continue;
            JsonNode run = json.readTree(polled.body());
            String status = run.path("status").asText("");
            if (DONE.contains(status)) {
                JsonNode results = run.path("results");
                JsonNode result = results.isArray() ? results.path(0) : results;
                if (result.isMissingNode() || result.isNull()) throw new IllegalStateException("no result");
                return result;
            }
            if (FAILED.contains(status)) throw new IllegalStateException("task run " + status + " " + brief(run.path("error").toString()));
        }
        throw new IllegalStateException("task run didn't finish within " + wait.toSeconds() + "s");
    }

    private HttpRequest.Builder request(URI uri) {
        return HttpRequest.newBuilder(uri)
                .timeout(Duration.ofSeconds(20))
                .header("Authorization", "Bearer " + renderApiKey)
                .header("Accept", "application/json")
                .header("Content-Type", "application/json");
    }

    private static String brief(String text) {
        return text == null ? "" : text.length() > 200 ? text.substring(0, 200) : text;
    }
}
