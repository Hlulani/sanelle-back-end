package com.hlulani.sanelle.domain.mealplan;

import com.hlulani.sanelle.domain.entity.Meal;
import com.hlulani.sanelle.domain.entity.MealType;
import org.junit.jupiter.api.Test;

import java.util.List;

import static com.hlulani.sanelle.support.MealFixtures.mealWithIngredients;
import static org.assertj.core.api.Assertions.assertThat;

class MealCriteriaTest {

    @Test
    void reasonsOnlyStateThePersonsOwnCriteria() {
        Meal meal = mealWithIngredients("Lentil Stew", MealType.DINNER, List.of(), "Lentils");
        meal.setPrepTimeMinutes(15);

        assertThat(MealCriteria.of("VEGETARIAN", 20, List.of(), List.of()).reasonsFor(meal))
                .containsExactly("Vegetarian, as you chose", "Ready in 15 min (your limit is 20)");
        assertThat(MealCriteria.of("ANY", null, List.of(), List.of()).reasonsFor(meal)).containsExactly("Ready in 15 min");
        assertThat(String.join(" ", MealCriteria.of("VEGAN", 30, List.of(), List.of()).reasonsFor(meal)).toLowerCase())
                .doesNotContain("inflamm", "fibroid", "hormone", "iron", "fibre", "fiber");
    }

    @Test
    void unknownOrMissingPreferenceFiltersNothing() {
        assertThat(ProteinPreference.from(null)).isEqualTo(ProteinPreference.ANY);
        assertThat(ProteinPreference.from("SOMETHING_ELSE")).isEqualTo(ProteinPreference.ANY);
        assertThat(ProteinPreference.ANY.reason()).isEmpty();
    }

    @Test
    void zeroOrNegativePrepLimitMeansNoLimit() {
        assertThat(MealCriteria.of("ANY", 0, List.of(), List.of()).maxPrepMinutes()).isNull();
        assertThat(MealCriteria.of("ANY", -5, List.of(), List.of()).maxPrepMinutes()).isNull();
    }
}
