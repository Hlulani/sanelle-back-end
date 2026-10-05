package com.hlulani.sanelle.api.dto.response;

import com.hlulani.sanelle.domain.entity.User;

public record LoginResponse(String accessToken, String refreshToken, UserResponse user) {
    public static LoginResponse of(TokenPair tokens, User user) {
        return new LoginResponse(tokens.accessToken(), tokens.refreshToken(), UserResponse.from(user));
    }
}
