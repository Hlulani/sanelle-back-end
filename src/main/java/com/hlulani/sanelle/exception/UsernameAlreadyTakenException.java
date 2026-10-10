package com.hlulani.sanelle.exception;

public class UsernameAlreadyTakenException extends ApiException {
    public UsernameAlreadyTakenException(String username) {
        super(Kind.CONFLICT, ErrorCode.USERNAME_TAKEN, "Username already taken: " + username);
    }
}
