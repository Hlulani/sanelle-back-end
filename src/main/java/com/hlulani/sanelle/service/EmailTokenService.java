package com.hlulani.sanelle.service;

import com.hlulani.sanelle.domain.entity.EmailToken;
import com.hlulani.sanelle.domain.entity.EmailTokenPurpose;
import com.hlulani.sanelle.exception.InvalidEmailTokenException;
import com.hlulani.sanelle.repository.EmailTokenRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.Duration;
import java.time.Instant;
import java.util.Base64;
import java.util.HexFormat;
import java.util.UUID;

/**
 * Single-use tokens for links sent by email. Issuing one retires the account's older unused
 * tokens of the same kind, so only the newest link works. The raw token leaves only in the link;
 * the database keeps its SHA-256 hash.
 */
@Service
@Transactional
public class EmailTokenService {

    public static final Duration VERIFY_EMAIL_VALIDITY = Duration.ofHours(24);
    public static final Duration RESET_PASSWORD_VALIDITY = Duration.ofHours(1);

    private static final int TOKEN_BYTES = 32;

    private final EmailTokenRepository tokens;
    private final SecureRandom random = new SecureRandom();

    public EmailTokenService(EmailTokenRepository tokens) {
        this.tokens = tokens;
    }

    /** A new raw token for the account; the only copy that can ever be put in a link. */
    public String issue(UUID userId, EmailTokenPurpose purpose) {
        Instant now = Instant.now();
        tokens.retireUnused(userId, purpose, now);

        byte[] bytes = new byte[TOKEN_BYTES];
        random.nextBytes(bytes);
        String raw = Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
        tokens.save(new EmailToken(userId, purpose, hash(raw), now.plus(validityOf(purpose))));
        return raw;
    }

    /**
     * Uses up a token and returns the account it belongs to. Unknown, already used or of the
     * wrong kind is {@code TOKEN_INVALID}; past its expiry is {@code TOKEN_EXPIRED}.
     */
    public UUID consume(String raw, EmailTokenPurpose purpose) {
        if (raw == null || raw.isBlank()) {
            throw InvalidEmailTokenException.invalid();
        }
        EmailToken token = tokens.findByTokenHash(hash(raw.trim()))
                .filter(t -> t.getPurpose() == purpose && !t.isUsed())
                .orElseThrow(InvalidEmailTokenException::invalid);
        Instant now = Instant.now();
        if (token.isExpiredAt(now)) {
            throw InvalidEmailTokenException.expired();
        }
        token.markUsed(now);
        tokens.retireUnused(token.getUserId(), purpose, now); // any other link of this kind is spent too
        return token.getUserId();
    }

    static Duration validityOf(EmailTokenPurpose purpose) {
        return switch (purpose) {
            case VERIFY_EMAIL -> VERIFY_EMAIL_VALIDITY;
            case RESET_PASSWORD -> RESET_PASSWORD_VALIDITY;
        };
    }

    /** SHA-256 of the raw token, as 64 lower-case hex characters. */
    public static String hash(String raw) {
        try {
            byte[] digest = MessageDigest.getInstance("SHA-256").digest(raw.getBytes(StandardCharsets.UTF_8));
            return HexFormat.of().formatHex(digest);
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("SHA-256 is always available", e);
        }
    }
}
