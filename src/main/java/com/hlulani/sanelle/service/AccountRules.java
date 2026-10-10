package com.hlulani.sanelle.service;

import com.hlulani.sanelle.exception.ErrorCode;
import com.hlulani.sanelle.exception.InvalidAccountDetailsException;

import java.util.Locale;
import java.util.regex.Pattern;

/**
 * The rules a name, email, password and terms answer must meet, shared by sign-up and password
 * reset. Each check throws with its own {@link ErrorCode} so the app can point at the right field.
 */
public final class AccountRules {

    public static final int NAME_MAX = 80;
    public static final int EMAIL_MAX = 255;
    public static final int PASSWORD_MIN = 8;
    public static final int PASSWORD_MAX = 128;

    // Plausible, not RFC-perfect: something@something.something, no spaces. The emailed link proves the rest.
    private static final Pattern EMAIL = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");

    private AccountRules() {}

    /** The name as it will be stored: trimmed. */
    public static String name(String raw) {
        String name = raw == null ? "" : raw.trim();
        if (name.isEmpty()) {
            throw new InvalidAccountDetailsException(ErrorCode.NAME_REQUIRED, "Tell us your name");
        }
        if (name.length() > NAME_MAX) {
            throw new InvalidAccountDetailsException(ErrorCode.NAME_TOO_LONG,
                    "Your name can be at most " + NAME_MAX + " characters");
        }
        return name;
    }

    /** The address as it will be stored: trimmed and lower-cased. */
    public static String email(String raw) {
        String email = normalizeEmail(raw);
        if (email.isEmpty() || email.length() > EMAIL_MAX || !EMAIL.matcher(email).matches()) {
            throw new InvalidAccountDetailsException(ErrorCode.EMAIL_INVALID, "Enter a valid email address");
        }
        return email;
    }

    public static void password(String raw) {
        int length = raw == null ? 0 : raw.length();
        if (length < PASSWORD_MIN) {
            throw new InvalidAccountDetailsException(ErrorCode.PASSWORD_TOO_SHORT,
                    "Your password needs at least " + PASSWORD_MIN + " characters");
        }
        if (length > PASSWORD_MAX) {
            throw new InvalidAccountDetailsException(ErrorCode.PASSWORD_TOO_LONG,
                    "Your password can be at most " + PASSWORD_MAX + " characters");
        }
    }

    public static void termsAccepted(Boolean accepted) {
        if (!Boolean.TRUE.equals(accepted)) {
            throw new InvalidAccountDetailsException(ErrorCode.TERMS_REQUIRED, "Accept the terms to create an account");
        }
    }

    public static String normalizeEmail(String raw) {
        return raw == null ? "" : raw.trim().toLowerCase(Locale.ROOT);
    }
}
