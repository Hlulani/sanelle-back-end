package com.hlulani.sanelle.service;

import com.hlulani.sanelle.domain.entity.MealType;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public interface MealPlanService {

    /**
     * What a plan is built from. Every field is something the person chose, so
     * "why this meal" can state it truthfully.
     *
     * @param duration          DAYS_7, DAYS_14 or DAYS_30
     * @param fastingStyle      meal schedule: NO_FASTING_3_MEALS (breakfast, lunch, dinner)
     *                          or FASTING_16_8 / FASTING_18_6 (lunch and dinner). A preference,
     *                          not a health recommendation.
     * @param proteinPreference ANY, MEATY, VEGETARIAN or VEGAN
     * @param maxPrepMinutes    optional upper limit on preparation time
     * @param allergies         allergen codes (see Allergen); meals that contain or may
     *                          contain any of them are left out
     * @param dislikes          foods to leave out by name
     */
    record GenerateMealPlanRequest(
            String duration,
            String fastingStyle,
            String proteinPreference,
            Integer maxPrepMinutes,
            List<String> allergies,
            List<String> dislikes
    ) {
        public GenerateMealPlanRequest(String duration, String fastingStyle, String proteinPreference, Integer maxPrepMinutes) {
            this(duration, fastingStyle, proteinPreference, maxPrepMinutes, List.of(), List.of());
        }
    }

    /** Alternatives for one meal slot, filtered by the same rules as plan generation. */
    record SwapOptionsRequest(
            MealType mealType,
            UUID currentMealId,
            String proteinPreference,
            Integer maxPrepMinutes,
            List<String> allergies,
            List<String> dislikes
    ) {}

    record PlannedMeal(
            MealType mealType,
            UUID mealId,
            String name,
            String imageUrl,
            List<String> tags,
            Integer prepTimeMinutes,
            /** The person's own criteria this meal meets, e.g. "Vegetarian, as you chose". */
            List<String> reasons
    ) {}

    record DayPlan(LocalDate date, List<PlannedMeal> meals) {}

    /**
     * @param unfilled meal slots that no recipe could fill without breaking a preference,
     *                 e.g. "BREAKFAST". Slots are left empty rather than filled with a
     *                 recipe the person said they don't want.
     */
    record MealPlanResponse(int days, List<DayPlan> daysPlan, List<String> unfilled) {}

    MealPlanResponse generate(GenerateMealPlanRequest req);

    List<PlannedMeal> swapOptions(SwapOptionsRequest req);
}
