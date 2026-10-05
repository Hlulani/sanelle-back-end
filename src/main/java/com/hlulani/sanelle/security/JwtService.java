package com.hlulani.sanelle.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.Optional;
import java.util.UUID;

public class JwtService {

    private static final String USER_ID = "uid";
    private static final String USERNAME = "username";
    private static final String TYPE = "typ";
    private static final String REFRESH = "refresh";

    private final JwtProperties props;
    private final SecretKey key;

    public JwtService(JwtProperties props) {
        if (props.secret() == null || props.secret().length() < 32) {
            throw new IllegalArgumentException("app.jwt.secret must be at least 32 characters");
        }
        this.props = props;
        this.key = Keys.hmacShaKeyFor(props.secret().getBytes(StandardCharsets.UTF_8));
    }

    public String generateAccessToken(UUID userId, String email, String username) {
        Instant now = Instant.now();
        return Jwts.builder()
                .id(UUID.randomUUID().toString())
                .subject(email)
                .claim(USER_ID, userId.toString())
                .claim(USERNAME, username)
                .issuedAt(Date.from(now))
                .expiration(Date.from(now.plus(props.accessMinutes(), ChronoUnit.MINUTES)))
                .signWith(key)
                .compact();
    }

    public String generateRefreshToken(UUID userId, String email) {
        Instant now = Instant.now();
        return Jwts.builder()
                .id(UUID.randomUUID().toString()) // unique even when issued twice in the same second
                .subject(email)
                .claim(USER_ID, userId.toString())
                .claim(TYPE, REFRESH)
                .issuedAt(Date.from(now))
                .expiration(Date.from(now.plus(props.refreshDays(), ChronoUnit.DAYS)))
                .signWith(key)
                .compact();
    }

    public Claims parse(String token) {
        return Jwts.parser()
                .verifyWith(key)
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    /** The claims of a signed, unexpired refresh token; empty for anything else. */
    public Optional<Claims> parseRefreshToken(String token) {
        try {
            Claims claims = parse(token);
            return REFRESH.equals(claims.get(TYPE, String.class)) ? Optional.of(claims) : Optional.empty();
        } catch (JwtException | IllegalArgumentException e) {
            return Optional.empty();
        }
    }

    public UUID getUserId(String token) {
        return userIdOf(parse(token));
    }

    public static UUID userIdOf(Claims claims) {
        return UUID.fromString(claims.get(USER_ID, String.class));
    }

    public String getEmail(String token) {
        return parse(token).getSubject();
    }

    public Instant expiresAt(String token) {
        return parse(token).getExpiration().toInstant();
    }
}
