package com.hlulani.sanelle.api.dto.response;

import com.hlulani.sanelle.domain.entity.MealType;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.Set;
import java.util.UUID;

public record MealResponse(
        UUID id,
        String name,
        MealType mealType,
        Set<String> tags,
        List<IngredientResponse> ingredients,
        List<String> instructions,
        OffsetDateTime createdAt,
        String imageUrl,
        String whyItHelps,
        String vegetableSubstitutes,
        String freshOrFrozen,
        String colorPalette,
        Integer prepTimeMinutes,
        Set<String> dietaryTags
) {}

