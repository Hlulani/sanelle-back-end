package com.hlulani.sanelle.ai;

import java.util.List;

/**
 * What the app sends, only after she agrees: her recent check-ins in her own words, the counts
 * Sanelle already worked out from them, the published explanations she may be pointed to, and
 * questions she already saved. Nothing here is stored.
 */
public record InsightsRequest(
        List<CheckIn> checkins,
        List<String> facts,
        List<Explanation> explanations,
        List<String> savedQuestions) {

    public record CheckIn(String date, List<String> symptoms, String bleeding, String dailyImpact, String note) {}

    public record Explanation(String claimId, String title, String summary) {}
}
