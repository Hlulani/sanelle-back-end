package com.hlulani.sanelle.domain.mealplan;

import com.hlulani.sanelle.domain.allergen.FoodRestrictions;
import com.hlulani.sanelle.domain.entity.Meal;

import java.util.ArrayList;
import java.util.List;

/**
 * Everything a person chose that decides which meals they're offered, applied the
 * same way to plans and swaps. A meal either meets every criterion or isn't offered.
 */
public record MealCriteria(ProteinPreference preference, Integer maxPrepMinutes, FoodRestrictions restrictions) {

    public MealCriteria {
        preference = preference == null ? ProteinPreference.ANY : preference;
        maxPrepMinutes = maxPrepMinutes != null && maxPrepMinutes > 0 ? maxPrepMinutes : null;
        restrictions = restrictions == null ? FoodRestrictions.none() : restrictions;
    }

    /** From request values; unknown allergen codes are rejected (see {@link FoodRestrictions#parse}). */
    public static MealCriteria of(String preference, Integer maxPrepMinutes, List<String> allergies, List<String> dislikes) {
        return new MealCriteria(ProteinPreference.from(preference), maxPrepMinutes, FoodRestrictions.parse(allergies, dislikes));
    }

    public boolean allows(Meal meal) {
        return preference.allows(DietClass.of(meal)) && fitsPrepTime(meal) && restrictions.allows(meal);
    }

    /** Only the person's own criteria. No health claims, and no promise of allergy safety. */
    public List<String> reasonsFor(Meal meal) {
        List<String> reasons = new ArrayList<>();
        preference.reason().ifPresent(reasons::add);
        Integer prep = meal.getPrepTimeMinutes();
        if (prep != null) {
            reasons.add(maxPrepMinutes != null
                    ? "Ready in " + prep + " min (your limit is " + maxPrepMinutes + ")"
                    : "Ready in " + prep + " min");
        }
        if (!restrictions.allergies().isEmpty()) reasons.add("Leaves out the allergens you listed");
        if (!restrictions.dislikes().isEmpty()) reasons.add("Leaves out foods you don't eat");
        return reasons;
    }

    private boolean fitsPrepTime(Meal meal) {
        return maxPrepMinutes == null || (meal.getPrepTimeMinutes() != null && meal.getPrepTimeMinutes() <= maxPrepMinutes);
    }
}
