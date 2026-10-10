package com.hlulani.sanelle.api.dto.request;

/** Body of /auth/verification/resend and /auth/password-reset/request. */
public record EmailRequest(String email) {}
