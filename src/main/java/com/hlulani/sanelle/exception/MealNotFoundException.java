package com.hlulani.sanelle.exception;

import java.util.UUID;

public class MealNotFoundException extends ApiException {
    public MealNotFoundException(UUID id) {
        super(Kind.NOT_FOUND, ErrorCode.MEAL_NOT_FOUND, "Meal not found: " + id);
    }
}
