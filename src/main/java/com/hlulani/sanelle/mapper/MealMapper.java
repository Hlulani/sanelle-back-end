package com.hlulani.sanelle.mapper;

import com.hlulani.sanelle.api.dto.request.CreateMealRequest;
import com.hlulani.sanelle.api.dto.request.IngredientRequest;
import com.hlulani.sanelle.api.dto.response.IngredientResponse;
import com.hlulani.sanelle.api.dto.response.MealResponse;
import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.valueobject.Ingredient;

import java.util.List;

public final class MealMapper {

    private MealMapper() {}

    public static Meal toEntity(CreateMealRequest req) {
        Meal meal = new Meal(
                req.name(),
                req.mealType(),
                req.tags()
        );

        // Ingredients
        if (req.ingredients() != null) {
            List<Ingredient> mappedIngredients = req.ingredients().stream()
                    .map(i -> new Ingredient(i.name(), i.amount()))
                    .toList();
            meal.getIngredients().addAll(mappedIngredients);
        }

        // Instructions
        if (req.instructions() != null) {
            meal.getInstructions().addAll(req.instructions());
        }

        // Recipe-detail content
        meal.setWhyItHelps(req.whyItHelps());
        meal.setVegetableSubstitutes(req.vegetableSubstitutes());
        meal.setFreshOrFrozen(req.freshOrFrozen());
        meal.setColorPalette(req.colorPalette());
        meal.setPrepTimeMinutes(req.prepTimeMinutes());
        if (req.dietaryTags() != null) {
            meal.getDietaryTags().addAll(req.dietaryTags());
        }

        return meal;
    }

    public static MealResponse toResponse(Meal meal) {
        return new MealResponse(
                meal.getId(),
                meal.getName(),
                meal.getMealType(),
                meal.getTags(),
                meal.getIngredients().stream()
                        .map(i -> new IngredientResponse(i.getName(), i.getAmount()))
                        .toList(),
                meal.getInstructions(),
                meal.getCreatedAt(),
                meal.getImageUrl(),
                meal.getWhyItHelps(),
                meal.getVegetableSubstitutes(),
                meal.getFreshOrFrozen(),
                meal.getColorPalette(),
                meal.getPrepTimeMinutes(),
                meal.getDietaryTags()
        );
    }
}
