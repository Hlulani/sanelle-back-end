package com.hlulani.sanelle.api.dto.request;

import com.hlulani.sanelle.domain.entity.MealType;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.List;
import com.hlulani.sanelle.api.dto.request.IngredientRequest;


public record CreateMealRequest(
        @NotBlank String name,
        @NotNull MealType mealType,
        @Min(0) @Max(5) int antiInflammatoryScore,
        @Min(0) @Max(5) int ironSupport,
        @Min(0) @Max(5) int fiberScore,
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
