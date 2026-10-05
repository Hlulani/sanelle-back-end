package com.hlulani.sanelle.domain.mealplan;

import com.hlulani.sanelle.domain.allergen.Allergen;
import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.food.Terms;
import com.hlulani.sanelle.domain.valueobject.Ingredient;

import java.util.function.Predicate;

/**
 * What kind of protein a meal has, read from its ingredient names. Meat wins over fish:
 * a meal with both isn't pescatarian. Fish, dairy and egg come from the same word lists
 * as the allergens, so "coconut milk" is plant-based here exactly as it is for a milk allergy.
 */
public enum DietClass {
    MEAT, FISH, VEGETARIAN, VEGAN;

    private static final Terms MEAT_WORDS = Terms.of(
            "chicken", "beef", "turkey", "pork", "ham", "bacon", "sausage", "sausages", "lamb", "duck",
            "veal", "venison");
    private static final Terms OTHER_SEAFOOD = Terms.of("seafood");
    private static final Terms HONEY = Terms.of("honey");

    public static DietClass of(Meal meal) {
        if (anyIngredient(meal, MEAT_WORDS::foundIn)) return MEAT;
        if (anyIngredient(meal, DietClass::isFishOrShellfish)) return FISH;
        boolean taggedVegan = meal.getTags().stream().anyMatch("vegan"::equalsIgnoreCase);
        return taggedVegan || !anyIngredient(meal, DietClass::isAnimalProduct) ? VEGAN : VEGETARIAN;
    }

    private static boolean isFishOrShellfish(String name) {
        return Allergen.FISH.isNamedIn(name) || Allergen.SHELLFISH.isNamedIn(name) || OTHER_SEAFOOD.foundIn(name);
    }

    private static boolean isAnimalProduct(String name) {
        return Allergen.MILK.isNamedIn(name) || Allergen.EGG.isNamedIn(name) || HONEY.foundIn(name);
    }

    private static boolean anyIngredient(Meal meal, Predicate<String> test) {
        return meal.getIngredients().stream().map(Ingredient::getName).anyMatch(test);
    }
}
