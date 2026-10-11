package com.hlulani.sanelle.ai;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.hlulani.sanelle.exception.AiException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

/**
 * Claude through Anthropic's Messages API. The key comes from ANTHROPIC_API_KEY and never
 * leaves the server. Request and response bodies are never logged.
 */
@Component
public class AnthropicLanguageModel implements LanguageModel {

    private static final URI MESSAGES = URI.create("https://api.anthropic.com/v1/messages");

    private final String apiKey;
    private final String model;
    private final ObjectMapper json;
    private final HttpClient http = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(10)).build();

    public AnthropicLanguageModel(@Value("${app.ai.anthropic-api-key:}") String apiKey,
                                  @Value("${app.ai.model:claude-sonnet-5-5}") String model,
                                  ObjectMapper json) {
        this.apiKey = apiKey == null ? "" : apiKey.trim().replaceAll("^[\"']+|[\"']+$", "").trim();
        this.model = model;
        this.json = json;
    }

    @Override
    public boolean available() {
        return apiKey.startsWith("sk-ant-api");
    }

    @Override
    public String unavailableReason() {
        if (available()) return null;
        if (apiKey.isEmpty()) return "no-key";
        // Only the token's public type label (e.g. "sk-ant-usr"), never any of the secret part.
        var type = java.util.regex.Pattern.compile("^sk-ant-[a-z]{3}").matcher(apiKey);
        return "not-an-api-key (" + (type.find() ? type.group() : "unrecognised format") + ")";
    }

    @Override
    public JsonNode structured(String system, String user, String toolName, JsonNode toolSchema) {
        if (!available()) throw AiException.unavailable();
        ObjectNode body = json.createObjectNode()
                .put("model", model)
                .put("max_tokens", 1500)
                .put("system", system);
        body.putArray("messages").addObject().put("role", "user").put("content", user);
        body.putArray("tools").addObject()
                .put("name", toolName)
                .put("description", "Return the drafts for the person to review.")
                .set("input_schema", toolSchema);
        body.putObject("tool_choice").put("type", "tool").put("name", toolName);
        try {
            HttpRequest request = HttpRequest.newBuilder(MESSAGES)
                    .timeout(Duration.ofSeconds(45))
                    .header("x-api-key", apiKey)
                    .header("anthropic-version", "2023-06-01")
                    .header("content-type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(json.writeValueAsString(body)))
                    .build();
            HttpResponse<String> response = http.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() == 429) throw AiException.rateLimited();
            if (response.statusCode() / 100 != 2) throw AiException.failed();
            for (JsonNode block : json.readTree(response.body()).path("content")) {
                if ("tool_use".equals(block.path("type").asText()) && toolName.equals(block.path("name").asText()))
                    return block.path("input");
            }
            throw AiException.failed();
        } catch (AiException e) {
            throw e;
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw AiException.failed();
        } catch (Exception e) {
            throw AiException.failed();
        }
    }
}
