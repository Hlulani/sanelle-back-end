package com.hlulani.sanelle.ai;

import com.fasterxml.jackson.databind.JsonNode;

/** A language model that answers by filling in one structured tool call, so replies are data, never prose. */
public interface LanguageModel {

    boolean available();

    /** Why drafting is off, without revealing anything about the key. Null when available. */
    default String unavailableReason() {
        return available() ? null : "unavailable";
    }

    /** The tool input the model produced for {@code toolSchema}. */
    JsonNode structured(String system, String user, String toolName, JsonNode toolSchema);
}
