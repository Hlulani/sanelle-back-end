package com.hlulani.sanelle.mail;

import java.time.Instant;

/** One email kept by the development outbox. {@code purpose} is VERIFY_EMAIL or RESET_PASSWORD. */
public record OutboxMessage(String to, String purpose, String link, String token, Instant sentAt) {}
