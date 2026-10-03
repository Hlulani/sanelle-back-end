package com.hlulani.sanelle.api.dto.response;

import java.time.LocalDate;
import java.util.List;

public record GeneratedPlanResponse(
        int days,
        List<DayPlan> daysPlan
) {
    public record DayPlan(
            LocalDate date,
            List<MealResponse> meals
    ) {}
}
