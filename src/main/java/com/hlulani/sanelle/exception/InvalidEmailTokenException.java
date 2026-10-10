package com.hlulani.sanelle.exception;

/** A verification or password-reset link that is unknown, already used ({@code TOKEN_INVALID}) or too old ({@code TOKEN_EXPIRED}). */
public class InvalidEmailTokenException extends ApiException {

    private InvalidEmailTokenException(ErrorCode code, String message) {
        super(Kind.BAD_REQUEST, code, message);
    }

    public static InvalidEmailTokenException invalid() {
        return new InvalidEmailTokenException(ErrorCode.TOKEN_INVALID, "This link is not valid or has already been used");
    }

    public static InvalidEmailTokenException expired() {
        return new InvalidEmailTokenException(ErrorCode.TOKEN_EXPIRED, "This link has expired; ask for a new one");
    }
}
