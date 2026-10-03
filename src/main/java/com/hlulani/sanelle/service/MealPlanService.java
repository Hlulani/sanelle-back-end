package com.hlulani.sanelle.service;

import com.hlulani.sanelle.domain.entity.MealType;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public interface MealPlanService {

    record GenerateMealPlanRequest(
            String duration,
            String fastingStyle,
            int firstMealHour,
            boolean fibroidFocus,
            boolean ironSupport,
            boolean fiberFocus,
            String proteinPreference
    ) {}

    record PlannedMeal(
            MealType mealType,
            java.util.UUID mealId,
            String name,
            String imageUrl,
            List<String> tags,
            int antiInflammatoryScore,
            int ironSupport,
            int fiberScore
    ) {}

    record DayPlan(LocalDate date, List<PlannedMeal> meals) {}

    record MealPlanResponse(int days, List<DayPlan> daysPlan) {}

    MealPlanResponse generate(GenerateMealPlanRequest req);
}
