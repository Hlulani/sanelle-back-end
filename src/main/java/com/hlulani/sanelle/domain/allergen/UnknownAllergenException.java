package com.hlulani.sanelle.domain.allergen;

public class UnknownAllergenException extends RuntimeException {
    public UnknownAllergenException(String code) {
        super("Unknown allergen: " + code);
    }
}
