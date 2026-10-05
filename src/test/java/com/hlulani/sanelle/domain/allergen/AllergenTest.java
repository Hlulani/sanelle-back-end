package com.hlulani.sanelle.domain.allergen;

import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.entity.MealType;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

import java.util.List;
import java.util.Set;

import static com.hlulani.sanelle.support.MealFixtures.mealWithIngredients;
import static com.hlulani.sanelle.domain.allergen.Allergen.Presence.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

/** Ingredient names below are taken from the seeded recipes. */
class AllergenTest {

    @ParameterizedTest(name = "{0} -> {1}: {2}")
    @CsvSource({
            // aliases
            "'feta, crumbled', MILK, CONTAINS",
            "'goat cheese, crumbled', MILK, CONTAINS",
            "burrata, MILK, CONTAINS",
            "'brie, sliced', MILK, CONTAINS",
            "kefir, MILK, CONTAINS",
            "'eggs, hard-boiled', EGG, CONTAINS",
            "mayonnaise, EGG, CONTAINS",
            "'pistachios, toasted and chopped', TREE_NUT, CONTAINS",
            "'mixed nuts (almonds, walnuts, pistachios)', TREE_NUT, CONTAINS",
            "tahini, SESAME, CONTAINS",
            "hummus, SESAME, CONTAINS",
            "everything bagel seasoning, SESAME, CONTAINS",
            "tamari, SOY, CONTAINS",
            "miso paste, SOY, CONTAINS",
            "soy sauce, GLUTEN, CONTAINS",
            "'soba noodles, cooked', GLUTEN, CONTAINS",
            "'farro, cooked', GLUTEN, CONTAINS",
            "'anchovy fillet, mashed', FISH, CONTAINS",
            "'shrimp, peeled', SHELLFISH, CONTAINS",
            "whole grain mustard, MUSTARD, CONTAINS",
            "'celery, diced', CELERY, CONTAINS",
            // optional alternatives count: the recipe can be made with the allergen
            "'milk (or oat milk)', MILK, CONTAINS",
            "water or milk, MILK, CONTAINS",
            "'mayonnaise (or greek yogurt)', MILK, CONTAINS",
            // look-alikes
            "coconut milk, MILK, NONE",
            "'full-fat coconut milk, chilled overnight', MILK, NONE",
            "peanut butter, MILK, NONE",
            "almond butter, MILK, NONE",
            "'scallion, sliced', SHELLFISH, NONE",
            "buckwheat flour, GLUTEN, NONE",
            "zucchini noodles, GLUTEN, NONE",
            "zucchini noodles, EGG, NONE",
            "coconut flakes, TREE_NUT, NONE",
            "'butternut squash', TREE_NUT, NONE",
            // composite ingredients that may hide an allergen
            "chicken stock, CELERY, MAY_CONTAIN",
            "vegetable broth, GLUTEN, MAY_CONTAIN",
            "granola, TREE_NUT, MAY_CONTAIN",
            "granola, PEANUT, MAY_CONTAIN",
            "'dark chocolate (70%+ cacao)', MILK, MAY_CONTAIN",
            "curry powder, MUSTARD, MAY_CONTAIN",
            "'chicken sausage, sliced', GLUTEN, MAY_CONTAIN",
            "rolled oats, GLUTEN, MAY_CONTAIN",
            "plant milk, SOY, MAY_CONTAIN",
            "plant milk, TREE_NUT, MAY_CONTAIN",
            // unrelated
            "spinach, MILK, NONE",
            "olive oil, TREE_NUT, NONE",
    })
    void classifiesRealIngredients(String ingredient, Allergen allergen, Allergen.Presence expected) {
        assertThat(allergen.in(ingredient)).isEqualTo(expected);
    }

    @Test
    void aBlankIngredientNameIsTreatedAsPossiblyContainingAnything() {
        assertThat(Allergen.MILK.in("")).isEqualTo(MAY_CONTAIN);
        assertThat(Allergen.MILK.in(null)).isEqualTo(MAY_CONTAIN);
    }

    // --- FoodRestrictions ---

    private static Meal meal(String... ingredients) {
        return mealWithIngredients("Test", MealType.LUNCH, List.of(), ingredients);
    }

    @Test
    void allergiesExcludeMealsThatContainOrMayContainTheAllergen() {
        FoodRestrictions celery = new FoodRestrictions(Set.of(Allergen.CELERY), List.of());
        assertThat(celery.allows(meal("Lentils", "Chicken stock"))).isFalse();
        assertThat(celery.allows(meal("Lentils", "Celery, diced"))).isFalse();
        assertThat(celery.allows(meal("Lentils", "Tomato passata"))).isTrue();
    }

    @Test
    void aMealWithNoIngredientListIsNeverOfferedToSomeoneWithAllergies() {
        assertThat(new FoodRestrictions(Set.of(Allergen.EGG), List.of()).allows(meal())).isFalse();
        assertThat(FoodRestrictions.none().allows(meal())).isTrue();
    }

    @Test
    void dislikesMatchWholeWordsAndPluralsButNotMayContain() {
        FoodRestrictions noMushroom = new FoodRestrictions(Set.of(), List.of("Mushroom"));
        assertThat(noMushroom.allows(meal("Mushrooms, sliced"))).isFalse();
        assertThat(noMushroom.allows(meal("Spinach"))).isTrue();

        FoodRestrictions noPea = new FoodRestrictions(Set.of(), List.of("pea"));
        assertThat(noPea.allows(meal("Frozen peas"))).isFalse();
        assertThat(noPea.allows(meal("Peanut butter"))).isTrue();
        assertThat(noPea.allows(meal("Chickpeas"))).isTrue();
    }

    @Test
    void unknownAllergenCodesAreRejectedNotIgnored() {
        assertThatThrownBy(() -> FoodRestrictions.parse(List.of("MILK", "GLUTTEN"), List.of()))
                .isInstanceOf(UnknownAllergenException.class)
                .hasMessageContaining("GLUTTEN");
        assertThat(FoodRestrictions.parse(List.of("milk", " tree_nut "), null).allergies())
                .containsExactlyInAnyOrder(Allergen.MILK, Allergen.TREE_NUT);
    }
}
