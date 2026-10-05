package com.hlulani.sanelle.domain.allergen;

import com.hlulani.sanelle.exception.ApiException;

public class UnknownAllergenException extends ApiException {
    public UnknownAllergenException(String code) {
        super(Kind.BAD_REQUEST, "Unknown allergen: " + code);
    }
}
