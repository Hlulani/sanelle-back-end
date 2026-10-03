package com.hlulani.sanelle.api.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record CreateCustomChallengeRequest(
        @NotBlank @Size(max = 100) String name,
        @Size(max = 280) String description,
        @NotBlank @Pattern(regexp = "meals-in-period|days-in-period|streak") String type,
        @Min(1) @Max(100) int targetCount,
        @Min(1) @Max(90) int durationDays
) {}
