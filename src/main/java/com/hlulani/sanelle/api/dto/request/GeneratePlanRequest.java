package com.hlulani.sanelle.api.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public record GeneratePlanRequest(
        @NotNull PlanDuration duration,
        @NotNull FastingStyle fastingStyle,
        @Min(0) @Max(23) int firstMealHour,
        boolean fibroidFocus,
        boolean ironSupport
) {
    public enum PlanDuration { DAYS_7, DAYS_14, DAYS_30 }
    public enum FastingStyle { NO_FASTING_3_MEALS, FASTING_16_8, FASTING_18_6 }
}
