package com.hlulani.sanelle.exception;

public class EmailAlreadyRegisteredException extends ApiException {
    public EmailAlreadyRegisteredException(String email) {
        super(Kind.CONFLICT, ErrorCode.EMAIL_TAKEN, "Email already registered: " + email);
    }
}
