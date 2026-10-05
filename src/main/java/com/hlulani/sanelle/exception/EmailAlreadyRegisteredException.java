package com.hlulani.sanelle.exception;

public class EmailAlreadyRegisteredException extends ApiException {
    public EmailAlreadyRegisteredException(String email) {
        super(Kind.CONFLICT, "Email already registered: " + email);
    }
}
