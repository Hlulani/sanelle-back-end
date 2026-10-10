package com.hlulani.sanelle.api.dto.response;

/** Sign-up succeeded; the person signs in by following the link sent to {@code email}. */
public record RegistrationResponse(String email, boolean verificationRequired) {}
