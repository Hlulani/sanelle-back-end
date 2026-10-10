package com.hlulani.sanelle.domain.entity;

/** What an emailed link is for. Stored by name in email_tokens.purpose. */
public enum EmailTokenPurpose {
    VERIFY_EMAIL,
    RESET_PASSWORD
}
