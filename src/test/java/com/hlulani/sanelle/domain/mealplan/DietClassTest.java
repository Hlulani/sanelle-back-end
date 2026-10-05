package com.hlulani.sanelle.domain.mealplan;

import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.entity.MealType;
import org.junit.jupiter.api.Test;

import java.util.List;

import static com.hlulani.sanelle.support.MealFixtures.mealWithIngredients;
import static org.assertj.core.api.Assertions.assertThat;

class DietClassTest {

    // Mirrors real seeded meals from V4__seed_50_meals.sql.

    @Test
    void chickenMealIsClassifiedAsMeat() {
        // mirrors "Garlic Lemon Chicken with Broccoli"
        Meal meal = mealWithIngredients("Garlic Lemon Chicken with Broccoli", MealType.DINNER,
                List.of("dinner", "high-protein", "easy"),
                "Chicken breast", "Broccoli", "Garlic", "Lemon juice", "Olive oil");

        assertThat(DietClass.of(meal)).isEqualTo(DietClass.MEAT);
    }

    @Test
    void fishMealIsClassifiedAsFishNotMeat() {
        Meal salmon = mealWithIngredients("Baked Salmon", MealType.DINNER, List.of(), "Salmon fillet", "Lemon");
        Meal surfAndTurf = mealWithIngredients("Chicken and Shrimp", MealType.DINNER, List.of(), "Chicken thighs", "Shrimp");

        assertThat(DietClass.of(salmon)).isEqualTo(DietClass.FISH);
        assertThat(DietClass.of(surfAndTurf)).isEqualTo(DietClass.MEAT);
    }

    @Test
    void pescatarianAllowsFishAndMeatFreeMealsButNoMeat() {
        Meal salmon = mealWithIngredients("Baked Salmon", MealType.DINNER, List.of(), "Salmon fillet");
        Meal lentils = mealWithIngredients("Lentil Stew", MealType.DINNER, List.of(), "Cooked lentils");
        Meal omelette = mealWithIngredients("Cheese Omelette", MealType.DINNER, List.of(), "Eggs", "Cheese");
        Meal chicken = mealWithIngredients("Grilled Chicken", MealType.DINNER, List.of(), "Chicken breast");

        assertThat(ProteinPreference.PESCATARIAN.allows(DietClass.of(salmon))).isTrue();
        assertThat(ProteinPreference.PESCATARIAN.allows(DietClass.of(lentils))).isTrue();
        assertThat(ProteinPreference.PESCATARIAN.allows(DietClass.of(omelette))).isTrue();
        assertThat(ProteinPreference.PESCATARIAN.allows(DietClass.of(chicken))).isFalse();
    }

    @Test
    void vegetarianExcludesFish() {
        Meal salmon = mealWithIngredients("Baked Salmon", MealType.DINNER, List.of(), "Salmon fillet");

        assertThat(ProteinPreference.VEGETARIAN.allows(DietClass.of(salmon))).isFalse();
    }

    @Test
    void lentilStewWithNoMeatOrDairyIsClassifiedAsVegan() {
        // mirrors "Simple Tomato Lentil Stew" — no meat, no dairy/egg/honey, not tagged 'vegan'
        Meal meal = mealWithIngredients("Simple Tomato Lentil Stew", MealType.DINNER,
                List.of("dinner", "high-fiber"),
                "Cooked lentils", "Tomato passata", "Olive oil", "Garlic");

        assertThat(DietClass.of(meal)).isEqualTo(DietClass.VEGAN);
    }

    @Test
    void mealWithCheeseAndEggButNoMeatIsVegetarianNotVegan() {
        // mirrors "Spinach and Feta Scramble" — eggs + feta, no meat
        Meal meal = mealWithIngredients("Spinach and Feta Scramble", MealType.BREAKFAST,
                List.of("breakfast", "high-protein", "quick"),
                "Eggs", "Spinach", "Feta", "Olive oil", "Salt");

        assertThat(DietClass.of(meal)).isEqualTo(DietClass.VEGETARIAN);
    }

    @Test
    void cheesesNotNamedCheeseAreStillDairy() {
        // mirrors "Grilled Peach, Burrata, and Tomato Salad" and "Honey-Pecan Brie Sweet Potato Rounds"
        Meal burrata = mealWithIngredients("Grilled Peach, Burrata, and Tomato Salad", MealType.LUNCH,
                List.of("lunch"), "Peach", "Burrata", "Tomato", "Basil", "Pistachios");
        Meal brie = mealWithIngredients("Brie Rounds", MealType.SNACK, List.of(), "Sweet potato", "Brie", "Pecans");

        assertThat(DietClass.of(burrata)).isEqualTo(DietClass.VEGETARIAN);
        assertThat(DietClass.of(brie)).isEqualTo(DietClass.VEGETARIAN);
    }

    @Test
    void nutButterIsNotMisclassifiedAsDairy() {
        // mirrors "Apple with Almond Butter" — plant-based despite containing "butter"
        Meal meal = mealWithIngredients("Apple with Almond Butter", MealType.SNACK,
                List.of("snack", "no-cook"),
                "Apple", "Almond butter");

        assertThat(DietClass.of(meal)).isEqualTo(DietClass.VEGAN);
    }

    // Look-alikes that a plain substring check used to read as animal products.

    @Test
    void plantMilksVeggiesAndEggplantAreVegan() {
        Meal curry = mealWithIngredients("Coconut Curry", MealType.DINNER, List.of(),
                "Full-fat coconut milk, chilled overnight", "Mixed veggies", "Eggplant", "Water or plant milk");

        assertThat(DietClass.of(curry)).isEqualTo(DietClass.VEGAN);
    }

    @Test
    void butternutSquashAndHazelnutButterArePlantBased() {
        Meal bowl = mealWithIngredients("Squash Bowl", MealType.LUNCH, List.of(),
                "Butternut squash", "Hazelnut butter");

        assertThat(DietClass.of(bowl)).isEqualTo(DietClass.VEGAN);
    }

    @Test
    void fishSauceIsFish() {
        Meal noodles = mealWithIngredients("Rice Noodles", MealType.DINNER, List.of(), "Rice noodles", "Fish sauce");

        assertThat(DietClass.of(noodles)).isEqualTo(DietClass.FISH);
        assertThat(ProteinPreference.VEGETARIAN.allows(DietClass.of(noodles))).isFalse();
        assertThat(ProteinPreference.PESCATARIAN.allows(DietClass.of(noodles))).isTrue();
    }

    @Test
    void honeyIsNotVegan() {
        Meal oats = mealWithIngredients("Oats", MealType.BREAKFAST, List.of(), "Rolled oats", "Honey or maple syrup");

        assertThat(DietClass.of(oats)).isEqualTo(DietClass.VEGETARIAN);
    }
}
