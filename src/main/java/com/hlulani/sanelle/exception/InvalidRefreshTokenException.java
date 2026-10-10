package com.hlulani.sanelle.exception;

public class InvalidRefreshTokenException extends ApiException {
    public InvalidRefreshTokenException(String reason) {
        super(Kind.UNAUTHORIZED, ErrorCode.REFRESH_TOKEN_INVALID, "Refresh token rejected: " + reason);
    }
}
