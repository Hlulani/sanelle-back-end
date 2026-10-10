package com.hlulani.sanelle.api.dto.response;

public record LoginResponse(String accessToken, String refreshToken, UserResponse user) {
    public static LoginResponse of(TokenPair tokens, UserResponse user) {
        return new LoginResponse(tokens.accessToken(), tokens.refreshToken(), user);
    }
}
