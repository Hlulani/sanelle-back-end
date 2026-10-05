package com.hlulani.sanelle.exception;

public class InvalidRefreshTokenException extends ApiException {
    public InvalidRefreshTokenException(String reason) {
        super(Kind.UNAUTHORIZED, "Refresh token rejected: " + reason);
    }
}
