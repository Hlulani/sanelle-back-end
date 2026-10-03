package com.hlulani.sanelle.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.UUID;

public class JwtService {

    private final JwtProperties props;
    private final SecretKey key;

    public boolean isRefreshToken(String token) {
        Claims c = parse(token);
        return "refresh".equals(c.get("typ", String.class));
    }


    public JwtService(JwtProperties props) {
        this.props = props;

        if (props.secret() == null || props.secret().length() < 32) {
            throw new IllegalArgumentException("app.jwt.secret must be at least 32 characters");
        }

        this.key = Keys.hmacShaKeyFor(props.secret().getBytes(StandardCharsets.UTF_8));
    }

    public String generateAccessToken(UUID userId, String email, String username) {
        Instant now = Instant.now();
        Instant exp = now.plus(props.accessMinutes(), ChronoUnit.MINUTES);

        return Jwts.builder()
                .id(UUID.randomUUID().toString())
                .subject(email)
                .claim("uid", userId.toString())
                .claim("username", username)
                .issuedAt(Date.from(now))
                .expiration(Date.from(exp))
                .signWith(key)
                .compact();
    }

    public String generateRefreshToken(UUID userId, String email) {
        Instant now = Instant.now();
        Instant exp = now.plus(props.refreshDays(), ChronoUnit.DAYS);

        return Jwts.builder()
                .subject(email)
                .claim("uid", userId.toString())
                .claim("typ", "refresh")
                .id(UUID.randomUUID().toString()) // 👈 add this
                .issuedAt(Date.from(now))
                .expiration(Date.from(exp))
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

    public UUID getUserId(String token) {
        return UUID.fromString(parse(token).get("uid", String.class));
    }

    public String getEmail(String token) {
        return parse(token).getSubject();
    }
}
