package com.hlulani.sanelle.api.dto.request;

import com.hlulani.sanelle.domain.entity.MealType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.List;
import com.hlulani.sanelle.api.dto.request.IngredientRequest;


public record CreateMealRequest(
        @NotBlank String name,
        @NotNull MealType mealType,
        List<String> tags,
        List<IngredientRequest> ingredients,
        List<String> instructions,
        String whyItHelps,
        String vegetableSubstitutes,
        String freshOrFrozen,
        String colorPalette,
        Integer prepTimeMinutes,
        List<String> dietaryTags
) {}
