package com.hlulani.sanelle.support;

import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.entity.MealType;
import com.hlulani.sanelle.domain.valueobject.Ingredient;

import java.util.List;

public final class MealFixtures {

    private MealFixtures() {}

    public static Meal mealWithIngredients(String name, MealType type, List<String> tags, String... ingredientNames) {
        Meal meal = new Meal(name, type, tags);
        for (String ingredientName : ingredientNames) {
            meal.getIngredients().add(new Ingredient(ingredientName, null));
        }
        return meal;
    }
}
