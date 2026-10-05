package com.hlulani.sanelle.exception;

/**
 * An error the API reports to the caller. Each subclass names its {@link Kind};
 * {@link GlobalExceptionHandler} turns the kind into an HTTP status in one place.
 */
public abstract class ApiException extends RuntimeException {

    public enum Kind { BAD_REQUEST, UNAUTHORIZED, FORBIDDEN, NOT_FOUND, CONFLICT }

    private final Kind kind;

    protected ApiException(Kind kind, String message) {
        super(message);
        this.kind = kind;
    }

    public Kind kind() {
        return kind;
    }
}
