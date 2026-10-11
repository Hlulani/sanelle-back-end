package com.hlulani.sanelle.ai;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hlulani.sanelle.exception.AiException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Clock;
import java.time.Instant;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * Drafts a visit brief, questions and matched explanations from her own check-ins. The model
 * only drafts; this class enforces the rules every draft must keep before it reaches her:
 * explanations come only from the published list, quotes are her exact words, nothing names a
 * cause, diagnosis or treatment, and lengths stay short. The app then checks the counts.
 */
@Service
public class InsightsService {

    static final int MAX_PER_HOUR = 20;
    static final int MAX_CHECKINS = 30;

    /** Wording that would interpret rather than describe. Any draft containing it is dropped. */
    static final Pattern NOT_ALLOWED = Pattern.compile(
            "\\b(diagnos\\w*|you have (?:anaemia|anemia)|you are (?:anaemic|anemic)|caused by|because of (?:your|the) fibroids?|"
                    + "should take|stop taking|start taking|prescri\\w*|cure\\w*|shrink\\w*|treatment for you|definitely)\\b",
            Pattern.CASE_INSENSITIVE);

    static final String SYSTEM = """
            You help a person with uterine fibroids prepare for a healthcare appointment, using only the check-ins \
            and counts she gives you. You draft; she edits and decides.

            Rules, all of them strict:
            - Use only the facts and her notes provided. Never add numbers that are not in the facts.
            - Never diagnose, never name a cause, never suggest or judge a treatment, never predict.
            - Questions are things she could ask her clinician, in her voice, plain UK English, under 25 words each.
            - Each question's "why" states the pattern it comes from, reusing the exact counts from the facts.
            - The brief is first person ("My main concern..."), at most 4 short sentences, and may quote her notes.
            - Matches: only explanation ids from the list provided. The quote must be copied exactly from one of her notes.
            - Match only when the explanation is directly about what the quote describes (for example flooding or \
            clots with heavy-bleeding wording; dizziness with anaemia; feeling dismissed with being heard). Never match \
            an explanation about how Sanelle counts or stores data. Use each quote at most once.
            - Do not repeat questions she already saved. Return fewer items rather than weak ones.
            """;

    private final LanguageModel model;
    private final ObjectMapper json;
    private final Clock clock;
    private final Map<UUID, Deque<Instant>> recent = new ConcurrentHashMap<>();

    @Autowired
    public InsightsService(LanguageModel model, ObjectMapper json) {
        this(model, json, Clock.systemUTC());
    }

    InsightsService(LanguageModel model, ObjectMapper json, Clock clock) {
        this.model = model;
        this.json = json;
        this.clock = clock;
    }

    public boolean available() {
        return model.available();
    }

    public String lastError() {
        return model.lastError();
    }

    public String pipeline() {
        return model.pipeline();
    }

    public String unavailableReason() {
        return model.unavailableReason();
    }

    public InsightsResponse draft(UUID userId, InsightsRequest request) {
        if (!model.available()) throw AiException.unavailable();
        allow(userId);
        List<InsightsRequest.CheckIn> checkins = request.checkins() == null ? List.of()
                : request.checkins().stream().limit(MAX_CHECKINS).toList();
        List<InsightsRequest.Explanation> explanations = request.explanations() == null ? List.of() : request.explanations();
        JsonNode out = model.structured(SYSTEM, prompt(checkins, request.facts(), explanations, request.savedQuestions()),
                "record_insights", schema());
        return checked(out, checkins, explanations);
    }

    /** Applies the rules to the model's draft; anything that breaks one is dropped, not repaired. */
    InsightsResponse checked(JsonNode out, List<InsightsRequest.CheckIn> checkins, List<InsightsRequest.Explanation> explanations) {
        String brief = out.path("brief").asText("").trim();
        if (brief.length() > 900 || NOT_ALLOWED.matcher(brief).find()) brief = "";

        List<InsightsResponse.Question> questions = new ArrayList<>();
        for (JsonNode q : out.path("questions")) {
            String text = q.path("text").asText("").trim();
            String why = q.path("why").asText("").trim();
            if (text.isEmpty() || text.length() > 200 || why.length() > 300) continue;
            if (NOT_ALLOWED.matcher(text).find() || NOT_ALLOWED.matcher(why).find()) continue;
            questions.add(new InsightsResponse.Question(text, why));
            if (questions.size() == 3) break;
        }

        Set<String> allowed = explanations.stream().map(InsightsRequest.Explanation::claimId).collect(Collectors.toSet());
        String notes = checkins.stream().map(InsightsRequest.CheckIn::note).filter(n -> n != null && !n.isBlank())
                .map(n -> n.toLowerCase(Locale.ROOT)).collect(Collectors.joining("\n"));
        List<InsightsResponse.Match> matches = new ArrayList<>();
        for (JsonNode m : out.path("matches")) {
            String id = m.path("claimId").asText("");
            String quote = m.path("quote").asText("").trim();
            if (!allowed.contains(id) || quote.isEmpty() || quote.length() > 200) continue;
            if (!notes.contains(quote.toLowerCase(Locale.ROOT))) continue;
            if (matches.stream().anyMatch(x -> x.claimId().equals(id) || x.quote().equalsIgnoreCase(quote))) continue;
            matches.add(new InsightsResponse.Match(id, quote));
            if (matches.size() == 3) break;
        }
        return new InsightsResponse(brief, questions, matches);
    }

    private void allow(UUID userId) {
        Instant now = clock.instant();
        Deque<Instant> times = recent.computeIfAbsent(userId, k -> new ArrayDeque<>());
        synchronized (times) {
            while (!times.isEmpty() && times.peekFirst().isBefore(now.minusSeconds(3600))) times.pollFirst();
            if (times.size() >= MAX_PER_HOUR) throw AiException.rateLimited();
            times.addLast(now);
        }
    }

    private String prompt(List<InsightsRequest.CheckIn> checkins, List<String> facts,
                          List<InsightsRequest.Explanation> explanations, List<String> saved) {
        StringBuilder b = new StringBuilder("Facts Sanelle counted from her check-ins:\n");
        (facts == null ? List.<String>of() : facts).forEach(f -> b.append("- ").append(f).append('\n'));
        b.append("\nHer check-ins (newest last):\n");
        for (InsightsRequest.CheckIn c : checkins) {
            b.append("- ").append(c.date()).append(": ")
                    .append(c.symptoms() == null || c.symptoms().isEmpty() ? "no symptoms selected" : String.join(", ", c.symptoms()));
            if (c.bleeding() != null) b.append("; bleeding ").append(c.bleeding());
            if (c.dailyImpact() != null) b.append("; effect on her day: ").append(c.dailyImpact());
            if (c.note() != null && !c.note().isBlank()) b.append("; her note: \"").append(c.note().trim()).append('"');
            b.append('\n');
        }
        b.append("\nPublished explanations you may match (id: title — summary):\n");
        explanations.forEach(e -> b.append("- ").append(e.claimId()).append(": ").append(e.title()).append(" — ").append(e.summary()).append('\n'));
        b.append("\nQuestions she already saved:\n");
        (saved == null ? List.<String>of() : saved).forEach(q -> b.append("- ").append(q).append('\n'));
        return b.toString();
    }

    private JsonNode schema() {
        try {
            return json.readTree("""
                    {"type":"object","required":["brief","questions","matches"],"properties":{
                      "brief":{"type":"string","description":"First-person draft of her main concern, at most 4 short sentences."},
                      "questions":{"type":"array","maxItems":3,"items":{"type":"object","required":["text","why"],"properties":{
                        "text":{"type":"string"},"why":{"type":"string"}}}},
                      "matches":{"type":"array","maxItems":3,"items":{"type":"object","required":["claimId","quote"],"properties":{
                        "claimId":{"type":"string"},"quote":{"type":"string","description":"Words copied exactly from one of her notes."}}}}}}
                    """);
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }
}
