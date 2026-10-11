package com.hlulani.sanelle.exception;

/**
 * An error the API reports to the caller. Each subclass names its {@link Kind} and
 * {@link ErrorCode}; {@link GlobalExceptionHandler} turns the kind into an HTTP status
 * in one place and passes the code through so clients can tell failures apart.
 */
public abstract class ApiException extends RuntimeException {

    public enum Kind { BAD_REQUEST, UNAUTHORIZED, FORBIDDEN, NOT_FOUND, CONFLICT, TOO_MANY_REQUESTS, UNAVAILABLE }

    private final Kind kind;
    private final ErrorCode code;

    protected ApiException(Kind kind, ErrorCode code, String message) {
        super(message);
        this.kind = kind;
        this.code = code;
    }

    public Kind kind() {
        return kind;
    }

    public ErrorCode code() {
        return code;
    }
}
