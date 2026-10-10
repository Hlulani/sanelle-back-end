package com.hlulani.sanelle.mail;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/** The front-end pages emailed links open, built from {@code app.frontend-base-url}. */
@Component
public class AccountLinks {

    private final String baseUrl;

    public AccountLinks(@Value("${app.frontend-base-url:http://localhost:4200}") String baseUrl) {
        this.baseUrl = baseUrl.endsWith("/") ? baseUrl.substring(0, baseUrl.length() - 1) : baseUrl;
    }

    // Tokens are URL-safe base64, so they go into the query string as they are.
    public String verifyEmail(String rawToken) {
        return baseUrl + "/verify-email?token=" + rawToken;
    }

    public String resetPassword(String rawToken) {
        return baseUrl + "/reset-password?token=" + rawToken;
    }
}
