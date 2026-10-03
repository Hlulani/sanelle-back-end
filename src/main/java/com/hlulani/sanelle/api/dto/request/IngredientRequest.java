package com.hlulani.sanelle.api.dto.request;

import jakarta.validation.constraints.NotBlank;

public record IngredientRequest(
        @NotBlank String name,
        String amount
) {}
