package com.hlulani.sanelle.exception;

/** Wrong email or password. Deliberately says nothing about which, or whether the account exists. */
public class InvalidCredentialsException extends ApiException {
    public InvalidCredentialsException() {
        super(Kind.UNAUTHORIZED, ErrorCode.INVALID_CREDENTIALS, "The email or password is not right");
    }
}
