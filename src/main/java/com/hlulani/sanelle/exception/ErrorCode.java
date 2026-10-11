package com.hlulani.sanelle.exception;

/**
 * The stable, machine-readable reason behind an {@link ApiError}. Clients branch on the code;
 * the message beside it is for people and may change wording at any time.
 */
public enum ErrorCode {
    // Request shape
    VALIDATION_FAILED,

    // Registration and password rules
    NAME_REQUIRED,
    NAME_TOO_LONG,
    EMAIL_INVALID,
    PASSWORD_TOO_SHORT,
    PASSWORD_TOO_LONG,
    TERMS_REQUIRED,
    USERNAME_INVALID,
    EMAIL_TAKEN,
    USERNAME_TAKEN,

    // Signing in and sessions
    INVALID_CREDENTIALS,
    EMAIL_NOT_VERIFIED,
    REFRESH_TOKEN_INVALID,

    // Links sent by email (verification and password reset)
    TOKEN_INVALID,
    TOKEN_EXPIRED,

    // Everything else
    USER_NOT_FOUND,
    MEAL_NOT_FOUND,
    CHALLENGE_NOT_FOUND,
    NOT_CHALLENGE_MEMBER,
    UNKNOWN_ALLERGEN,

    // AI drafting
    AI_UNAVAILABLE,
    AI_RATE_LIMITED,
    AI_FAILED
}
