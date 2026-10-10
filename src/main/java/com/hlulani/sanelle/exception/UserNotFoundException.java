package com.hlulani.sanelle.exception;

public class UserNotFoundException extends ApiException {
    public UserNotFoundException(Object identifier) {
        super(Kind.NOT_FOUND, ErrorCode.USER_NOT_FOUND, "User not found: " + identifier);
    }
}
