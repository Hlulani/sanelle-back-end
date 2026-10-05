package com.hlulani.sanelle.api.dto.request;

/** Body of both /auth/refresh and /auth/logout. */
public record RefreshTokenRequest(String refreshToken) {}
