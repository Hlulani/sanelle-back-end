package com.hlulani.sanelle.api.dto.request;

/** Sign-up. {@code username} is optional; one is generated when it's left out. */
public record RegisterRequest(String name, String email, String password, Boolean termsAccepted, String username) {}
