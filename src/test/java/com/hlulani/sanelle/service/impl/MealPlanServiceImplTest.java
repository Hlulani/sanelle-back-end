package com.hlulani.sanelle.service.impl;

import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.entity.MealType;
import com.hlulani.sanelle.domain.valueobject.Ingredient;
import com.hlulani.sanelle.repository.MealRepository;
import com.hlulani.sanelle.service.MealPlanService.GenerateMealPlanRequest;
import com.hlulani.sanelle.service.MealPlanService.MealPlanResponse;
import com.hlulani.sanelle.service.MealPlanService.PlannedMeal;
import org.junit.jupiter.api.Test;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class MealPlanServiceImplTest {

    private final MealRepository mealRepository = mock(MealRepository.class);
    private final MealPlanServiceImpl service = new MealPlanServiceImpl(mealRepository);

    private static Meal mealWithIngredients(String name, MealType type, List<String> tags, String... ingredientNames) {
        Meal meal = new Meal(name, type, 4, 4, 4, tags);
        for (String ingredientName : ingredientNames) {
            meal.getIngredients().add(new Ingredient(ingredientName, null));
        }
        return meal;
    }

    // --- classifier tests, mirroring real seeded meals from V4__seed_50_meals.sql ---

    @Test
    void chickenMealIsClassifiedAsMeaty() {
        // mirrors "Garlic Lemon Chicken with Broccoli"
        Meal meal = mealWithIngredients("Garlic Lemon Chicken with Broccoli", MealType.DINNER,
                List.of("dinner", "high-protein", "easy"),
                "Chicken breast", "Broccoli", "Garlic", "Lemon juice", "Olive oil");

        assertThat(service.classifyProtein(meal)).isEqualTo(MealPlanServiceImpl.ProteinClass.MEATY);
    }

    @Test
    void lentilStewWithNoMeatOrDairyIsClassifiedAsVegan() {
        // mirrors "Simple Tomato Lentil Stew" — no meat, no dairy/egg/honey, not tagged 'vegan'
        Meal meal = mealWithIngredients("Simple Tomato Lentil Stew", MealType.DINNER,
                List.of("dinner", "high-fiber"),
                "Cooked lentils", "Tomato passata", "Olive oil", "Garlic");

        assertThat(service.classifyProtein(meal)).isEqualTo(MealPlanServiceImpl.ProteinClass.VEGAN);
    }

    @Test
    void mealWithCheeseAndEggButNoMeatIsVegetarianNotVegan() {
        // mirrors "Spinach and Feta Scramble" — eggs + feta, no meat
        Meal meal = mealWithIngredients("Spinach and Feta Scramble", MealType.BREAKFAST,
                List.of("breakfast", "high-protein", "quick"),
                "Eggs", "Spinach", "Feta", "Olive oil", "Salt");

        assertThat(service.classifyProtein(meal)).isEqualTo(MealPlanServiceImpl.ProteinClass.VEGETARIAN);
    }

    @Test
    void nutButterIsNotMisclassifiedAsDairy() {
        // mirrors "Apple with Almond Butter" — plant-based despite containing "butter"
        Meal meal = mealWithIngredients("Apple with Almond Butter", MealType.SNACK,
                List.of("snack", "no-cook"),
                "Apple", "Almond butter");

        assertThat(service.classifyProtein(meal)).isEqualTo(MealPlanServiceImpl.ProteinClass.VEGAN);
    }

    // --- generate() filter-then-fallback behavior ---

    @SuppressWarnings("unchecked")
    @Test
    void generateFallsBackToUnfilteredPoolForASlotWithNoVeganMeals() {
        Meal veganLunch = mealWithIngredients("Vegan Lentil Bowl", MealType.LUNCH,
                List.of("lunch"), "Cooked lentils", "Carrot", "Onion");

        // Neither breakfast option is vegan-classified: one is meaty, one has egg/cheese.
        Meal meatyBreakfast = mealWithIngredients("Bacon and Eggs", MealType.BREAKFAST,
                List.of("breakfast"), "Bacon", "Eggs");
        Meal dairyBreakfast = mealWithIngredients("Cheese Omelette", MealType.BREAKFAST,
                List.of("breakfast"), "Eggs", "Cheese");

        Meal meatyDinner = mealWithIngredients("Grilled Chicken", MealType.DINNER,
                List.of("dinner"), "Chicken breast");

        List<Meal> allMeals = List.of(veganLunch, meatyBreakfast, dairyBreakfast, meatyDinner);

        when(mealRepository.findAll()).thenReturn(allMeals);
        when(mealRepository.findAll(any(Specification.class))).thenReturn(allMeals);

        GenerateMealPlanRequest req = new GenerateMealPlanRequest(
                "DAYS_7", "NO_FASTING_3_MEALS", 8, false, false, false, "VEGAN");

        MealPlanResponse response = service.generate(req);
        var day = response.daysPlan().get(0);

        PlannedMeal breakfast = mealOfType(day.meals(), MealType.BREAKFAST);
        PlannedMeal lunch = mealOfType(day.meals(), MealType.LUNCH);
        PlannedMeal dinner = mealOfType(day.meals(), MealType.DINNER);

        // Zero vegan-classified breakfasts exist -> falls back to the unfiltered breakfast pool
        // instead of silently returning no breakfast at all.
        assertThat(breakfast.name()).isIn("Bacon and Eggs", "Cheese Omelette");

        // A vegan lunch exists -> the protein filter is honored, not just the fallback.
        assertThat(lunch.name()).isEqualTo("Vegan Lentil Bowl");

        // Zero vegan-classified dinners exist -> falls back too.
        assertThat(dinner.name()).isEqualTo("Grilled Chicken");
    }

    private static PlannedMeal mealOfType(List<PlannedMeal> meals, MealType type) {
        return meals.stream().filter(m -> m.mealType() == type).findFirst().orElseThrow();
    }
}
