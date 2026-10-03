package com.hlulani.sanelle.service.impl;

import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.entity.MealType;
import com.hlulani.sanelle.domain.valueobject.Ingredient;
import com.hlulani.sanelle.repository.MealRepository;
import com.hlulani.sanelle.service.MealPlanService.GenerateMealPlanRequest;
import com.hlulani.sanelle.service.MealPlanService.MealPlanResponse;
import com.hlulani.sanelle.service.MealPlanService.PlannedMeal;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class MealPlanServiceImplTest {

    private final MealRepository mealRepository = mock(MealRepository.class);
    private final MealPlanServiceImpl service = new MealPlanServiceImpl(mealRepository);

    private static Meal mealWithIngredients(String name, MealType type, List<String> tags, String... ingredientNames) {
        Meal meal = new Meal(name, type, tags);
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
    void cheesesNotNamedCheeseAreStillDairy() {
        // mirrors "Grilled Peach, Burrata, and Tomato Salad" and "Honey-Pecan Brie Sweet Potato Rounds"
        Meal burrata = mealWithIngredients("Grilled Peach, Burrata, and Tomato Salad", MealType.LUNCH,
                List.of("lunch"), "Peach", "Burrata", "Tomato", "Basil", "Pistachios");
        Meal brie = mealWithIngredients("Brie Rounds", MealType.SNACK, List.of(), "Sweet potato", "Brie", "Pecans");

        assertThat(service.classifyProtein(burrata)).isEqualTo(MealPlanServiceImpl.ProteinClass.VEGETARIAN);
        assertThat(service.classifyProtein(brie)).isEqualTo(MealPlanServiceImpl.ProteinClass.VEGETARIAN);
    }

    @Test
    void nutButterIsNotMisclassifiedAsDairy() {
        // mirrors "Apple with Almond Butter" — plant-based despite containing "butter"
        Meal meal = mealWithIngredients("Apple with Almond Butter", MealType.SNACK,
                List.of("snack", "no-cook"),
                "Apple", "Almond butter");

        assertThat(service.classifyProtein(meal)).isEqualTo(MealPlanServiceImpl.ProteinClass.VEGAN);
    }

    // --- generate(): preferences are never broken ---

    @Test
    void slotWithNoMatchingMealIsLeftEmptyAndReported() {
        Meal veganLunch = mealWithIngredients("Vegan Lentil Bowl", MealType.LUNCH,
                List.of("lunch"), "Cooked lentils", "Carrot", "Onion");
        Meal meatyBreakfast = mealWithIngredients("Bacon and Eggs", MealType.BREAKFAST,
                List.of("breakfast"), "Bacon", "Eggs");
        Meal dairyBreakfast = mealWithIngredients("Cheese Omelette", MealType.BREAKFAST,
                List.of("breakfast"), "Eggs", "Cheese");
        Meal meatyDinner = mealWithIngredients("Grilled Chicken", MealType.DINNER,
                List.of("dinner"), "Chicken breast");
        when(mealRepository.findAll()).thenReturn(List.of(veganLunch, meatyBreakfast, dairyBreakfast, meatyDinner));

        MealPlanResponse response = service.generate(
                new GenerateMealPlanRequest("DAYS_7", "NO_FASTING_3_MEALS", "VEGAN", null));

        for (var day : response.daysPlan()) {
            assertThat(day.meals()).extracting(PlannedMeal::name).containsExactly("Vegan Lentil Bowl");
        }
        assertThat(response.unfilled()).containsExactly("BREAKFAST", "DINNER");
    }

    @Test
    void maxPrepTimeExcludesSlowerAndUntimedMeals() {
        Meal quick = mealWithIngredients("Quick Salad", MealType.LUNCH, List.of(), "Lettuce");
        quick.setPrepTimeMinutes(10);
        Meal slow = mealWithIngredients("Slow Stew", MealType.LUNCH, List.of(), "Beans");
        slow.setPrepTimeMinutes(90);
        Meal untimed = mealWithIngredients("Mystery Bowl", MealType.LUNCH, List.of(), "Rice");
        when(mealRepository.findAll()).thenReturn(List.of(quick, slow, untimed));

        MealPlanResponse response = service.generate(
                new GenerateMealPlanRequest("DAYS_14", "FASTING_16_8", "ANY", 20));

        assertThat(response.daysPlan()).allSatisfy(day ->
                assertThat(day.meals()).extracting(PlannedMeal::name).containsOnly("Quick Salad"));
    }

    @Test
    void everyRecipeIsUsedOnceBeforeAnyRepeats() {
        List<Meal> lunches = List.of(
                mealWithIngredients("A", MealType.LUNCH, List.of(), "x"),
                mealWithIngredients("B", MealType.LUNCH, List.of(), "x"),
                mealWithIngredients("C", MealType.LUNCH, List.of(), "x"));
        when(mealRepository.findAll()).thenReturn(lunches);

        MealPlanResponse response = service.generate(
                new GenerateMealPlanRequest("DAYS_7", "FASTING_16_8", "ANY", null));

        List<String> firstThree = response.daysPlan().subList(0, 3).stream()
                .map(d -> mealOfType(d.meals(), MealType.LUNCH).name()).toList();
        assertThat(firstThree).containsExactlyInAnyOrder("A", "B", "C");
    }

    @Test
    void reasonsOnlyStateThePersonsOwnCriteria() {
        Meal meal = mealWithIngredients("Lentil Stew", MealType.DINNER, List.of(), "Lentils");
        meal.setPrepTimeMinutes(15);

        assertThat(service.reasonsFor(meal, "VEGETARIAN", 20))
                .containsExactly("Vegetarian, as you chose", "Ready in 15 min (your limit is 20)");
        assertThat(service.reasonsFor(meal, "ANY", null)).containsExactly("Ready in 15 min");
        assertThat(String.join(" ", service.reasonsFor(meal, "VEGAN", 30)).toLowerCase())
                .doesNotContain("inflamm", "fibroid", "hormone", "iron", "fibre", "fiber");
    }

    // --- allergies and swaps ---

    @Test
    void plansNeverIncludeAMealWithAListedAllergen() {
        Meal tahiniBowl = mealWithIngredients("Farro Bowl with Tahini", MealType.LUNCH, List.of(), "Farro, cooked", "Tahini");
        Meal lentilSoup = mealWithIngredients("Lentil Soup", MealType.LUNCH, List.of(), "Lentils", "Vegetable stock");
        Meal salad = mealWithIngredients("Bean Salad", MealType.LUNCH, List.of(), "White beans", "Olive oil");
        when(mealRepository.findAll()).thenReturn(List.of(tahiniBowl, lentilSoup, salad));

        MealPlanResponse response = service.generate(new GenerateMealPlanRequest(
                "DAYS_7", "FASTING_16_8", "ANY", null, List.of("SESAME", "CELERY"), List.of()));

        assertThat(response.daysPlan()).allSatisfy(day ->
                assertThat(day.meals()).extracting(PlannedMeal::name).containsOnly("Bean Salad"));
        assertThat(response.daysPlan().get(0).meals().get(0).reasons())
                .contains("Leaves out the allergens you listed")
                .noneMatch(r -> r.toLowerCase().contains("safe"));
    }

    @Test
    void swapOptionsApplyTheSameRulesAndNeverOfferTheCurrentMeal() {
        Meal current = mealWithIngredients("Current", MealType.DINNER, List.of(), "Beans");
        Meal withMilk = mealWithIngredients("Creamy Pasta", MealType.DINNER, List.of(), "Cooked pasta", "Milk (or oat milk)");
        Meal withMushroom = mealWithIngredients("Mushroom Rice", MealType.DINNER, List.of(), "Rice", "Mushrooms");
        Meal ok = mealWithIngredients("Lentil Stew", MealType.DINNER, List.of(), "Lentils", "Tomato passata");
        Meal lunch = mealWithIngredients("Other Lunch", MealType.LUNCH, List.of(), "Rice");
        for (Meal m : List.of(current, withMilk, withMushroom, ok, lunch)) {
            org.springframework.test.util.ReflectionTestUtils.setField(m, "id", java.util.UUID.randomUUID());
        }
        when(mealRepository.findAll()).thenReturn(List.of(current, withMilk, withMushroom, ok, lunch));

        List<PlannedMeal> options = service.swapOptions(new com.hlulani.sanelle.service.MealPlanService.SwapOptionsRequest(
                MealType.DINNER, current.getId(), "ANY", null, List.of("MILK"), List.of("mushroom")));

        assertThat(options).extracting(PlannedMeal::name).containsExactly("Lentil Stew");
    }

    @Test
    void unknownAllergenInARequestIsAnError() {
        when(mealRepository.findAll()).thenReturn(List.of());
        org.assertj.core.api.Assertions.assertThatThrownBy(() -> service.generate(new GenerateMealPlanRequest(
                        "DAYS_7", "FASTING_16_8", "ANY", null, List.of("NUTS"), List.of())))
                .isInstanceOf(com.hlulani.sanelle.domain.allergen.UnknownAllergenException.class);
    }

    private static PlannedMeal mealOfType(List<PlannedMeal> meals, MealType type) {
        return meals.stream().filter(m -> m.mealType() == type).findFirst().orElseThrow();
    }
}
