package com.hlulani.sanelle.domain.valueobject;

import java.util.List;

/** Editorial provenance and cooking context, not a clinical or kitchen-test endorsement. */
public record RecipeContent(
        String version,
        String reviewStatus,
        boolean kitchenTested,
        String methodBasis,
        String timingNote,
        List<String> ingredientNotes,
        List<String> cookingChecks,
        List<String> sourceUrls
) {}
