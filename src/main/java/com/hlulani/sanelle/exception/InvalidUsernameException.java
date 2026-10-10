package com.hlulani.sanelle.exception;

public class InvalidUsernameException extends ApiException {
    public InvalidUsernameException(String message) {
        super(Kind.BAD_REQUEST, ErrorCode.USERNAME_INVALID, message);
    }
}
