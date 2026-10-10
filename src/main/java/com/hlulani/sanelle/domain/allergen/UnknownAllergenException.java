package com.hlulani.sanelle.domain.allergen;

import com.hlulani.sanelle.exception.ApiException;
import com.hlulani.sanelle.exception.ErrorCode;

public class UnknownAllergenException extends ApiException {
    public UnknownAllergenException(String code) {
        super(Kind.BAD_REQUEST, ErrorCode.UNKNOWN_ALLERGEN, "Unknown allergen: " + code);
    }
}
