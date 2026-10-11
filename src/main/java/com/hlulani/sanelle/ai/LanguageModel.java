package com.hlulani.sanelle.ai;

import com.fasterxml.jackson.databind.JsonNode;

/** A language model that answers by filling in one structured tool call, so replies are data, never prose. */
public interface LanguageModel {

    boolean available();

    /** The tool input the model produced for {@code toolSchema}. */
    JsonNode structured(String system, String user, String toolName, JsonNode toolSchema);
}
