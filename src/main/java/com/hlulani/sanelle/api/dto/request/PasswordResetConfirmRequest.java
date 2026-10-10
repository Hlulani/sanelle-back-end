package com.hlulani.sanelle.api.dto.request;

/** The token from a reset link and the new password. */
public record PasswordResetConfirmRequest(String token, String password) {}
