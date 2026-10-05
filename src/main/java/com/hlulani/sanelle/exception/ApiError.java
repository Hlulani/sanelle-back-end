package com.hlulani.sanelle.exception;

import org.springframework.http.HttpStatus;

import java.time.OffsetDateTime;
import java.util.Map;

public record ApiError(
        OffsetDateTime timestamp,
        int status,
        String error,
        String message,
        String path,
        Map<String, String> fieldErrors
) {
    public static ApiError of(HttpStatus status, String message, String path, Map<String, String> fieldErrors) {
        return new ApiError(OffsetDateTime.now(), status.value(), status.getReasonPhrase(), message, path, fieldErrors);
    }
}
