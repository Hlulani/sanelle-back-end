package com.hlulani.sanelle.exception;

public class UsernameAlreadyTakenException extends ApiException {
    public UsernameAlreadyTakenException(String username) {
        super(Kind.CONFLICT, "Username already taken: " + username);
    }
}
