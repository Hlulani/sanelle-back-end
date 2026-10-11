package com.hlulani.sanelle.ai;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hlulani.sanelle.exception.AiException;
import com.hlulani.sanelle.exception.ErrorCode;
import org.junit.jupiter.api.Test;

import java.time.Clock;
import java.time.Instant;
import java.time.ZoneOffset;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class InsightsServiceTest {

    private final ObjectMapper json = new ObjectMapper();

    private static final InsightsRequest REQUEST = new InsightsRequest(
            List.of(new InsightsRequest.CheckIn("2026-10-09", List.of("Bleeding", "Pain"), "heavy", "Changed my plans",
                    "Flooding at night, had to change pads twice")),
            List.of("Heavy or very heavy bleeding on 1 of 1 check-ins with a bleeding answer."),
            List.of(new InsightsRequest.Explanation("C36", "Bleeding categories aren't millilitres", "Your own words.")),
            List.of());

    /** A model that returns a fixed draft, and records whether it was called. */
    private static final class FakeModel implements LanguageModel {
        final boolean available;
        final JsonNode answer;
        int calls;

        FakeModel(boolean available, JsonNode answer) {
            this.available = available;
            this.answer = answer;
        }

        public boolean available() {
            return available;
        }

        public JsonNode structured(String system, String user, String toolName, JsonNode toolSchema) {
            calls++;
            return answer;
        }
    }

    private JsonNode draft(String text) throws Exception {
        return json.readTree(text);
    }

    @Test
    void refusesWithoutAKeySoTheAppKeepsItsOwnSuggestions() {
        InsightsService service = new InsightsService(new FakeModel(false, null), json);
        assertThat(service.available()).isFalse();
        assertThatThrownBy(() -> service.draft(UUID.randomUUID(), REQUEST))
                .isInstanceOfSatisfying(AiException.class, e -> assertThat(e.code()).isEqualTo(ErrorCode.AI_UNAVAILABLE));
    }

    @Test
    void keepsDraftsThatFollowEveryRule() throws Exception {
        FakeModel model = new FakeModel(true, draft("""
                {"brief":"My main concern: heavy bleeding that changes my plans.",
                 "questions":[{"text":"What could help with heavy bleeding?","why":"Heavy bleeding on 1 of 1 check-ins."}],
                 "matches":[{"claimId":"C36","quote":"Flooding at night"}]}
                """));
        InsightsResponse out = new InsightsService(model, json).draft(UUID.randomUUID(), REQUEST);
        assertThat(out.brief()).isEqualTo("My main concern: heavy bleeding that changes my plans.");
        assertThat(out.questions()).extracting(InsightsResponse.Question::text).containsExactly("What could help with heavy bleeding?");
        assertThat(out.matches()).containsExactly(new InsightsResponse.Match("C36", "Flooding at night"));
    }

    @Test
    void dropsAnythingThatBreaksARuleInsteadOfRepairingIt() throws Exception {
        FakeModel model = new FakeModel(true, draft("""
                {"brief":"Your heavy bleeding is caused by the fibroid.",
                 "questions":[
                   {"text":"Should I start taking iron?","why":"Low energy."},
                   {"text":"Do I have a diagnosis of anaemia?","why":"Tired."},
                   {"text":"What could help with pain?","why":"Pain on 2 of 3 check-ins."}],
                 "matches":[
                   {"claimId":"C99","quote":"Flooding at night"},
                   {"claimId":"C36","quote":"I was bleeding through everything"}]}
                """));
        InsightsResponse out = new InsightsService(model, json).draft(UUID.randomUUID(), REQUEST);
        assertThat(out.brief()).isEmpty();
        assertThat(out.questions()).extracting(InsightsResponse.Question::text).containsExactly("What could help with pain?");
        // An explanation that isn't in the published list, or a "quote" she never wrote, is never passed on.
        assertThat(out.matches()).isEmpty();
    }

    @Test
    void limitsEachPersonToTwentyDraftsAnHour() throws Exception {
        FakeModel model = new FakeModel(true, draft("{\"brief\":\"\",\"questions\":[],\"matches\":[]}"));
        InsightsService service = new InsightsService(model, json,
                Clock.fixed(Instant.parse("2026-10-10T20:00:00Z"), ZoneOffset.UTC));
        UUID user = UUID.randomUUID();
        for (int i = 0; i < InsightsService.MAX_PER_HOUR; i++) service.draft(user, REQUEST);
        assertThatThrownBy(() -> service.draft(user, REQUEST))
                .isInstanceOfSatisfying(AiException.class, e -> assertThat(e.code()).isEqualTo(ErrorCode.AI_RATE_LIMITED));
        assertThat(model.calls).isEqualTo(InsightsService.MAX_PER_HOUR);
        service.draft(UUID.randomUUID(), REQUEST); // someone else isn't affected
    }

    @Test
    void anthropicModelIsOnlyAvailableWithAnApiKey() {
        assertThat(new AnthropicLanguageModel("", "m", json).available()).isFalse();
        assertThat(new AnthropicLanguageModel("sk-ant-usr-not-an-api-key", "m", json).available()).isFalse();
        assertThat(new AnthropicLanguageModel("sk-ant-api03-example", "m", json).available()).isTrue();
    }
}
