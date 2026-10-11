package com.hlulani.sanelle.ai;

import java.util.List;

/** Drafts for her to edit. The app checks them again against its own counts before showing them. */
public record InsightsResponse(String brief, List<Question> questions, List<Match> matches) {

    public record Question(String text, String why) {}

    /** A published explanation that fits her own words, with the words quoted exactly. */
    public record Match(String claimId, String quote) {}
}
