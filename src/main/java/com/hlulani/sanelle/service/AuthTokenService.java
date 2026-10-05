package com.hlulani.sanelle.service;

import com.hlulani.sanelle.api.dto.response.TokenPair;
import com.hlulani.sanelle.domain.entity.RefreshToken;
import com.hlulani.sanelle.domain.entity.User;
import com.hlulani.sanelle.exception.InvalidRefreshTokenException;
import com.hlulani.sanelle.repository.RefreshTokenRepository;
import com.hlulani.sanelle.repository.UserRepository;
import com.hlulani.sanelle.security.JwtService;
import io.jsonwebtoken.Claims;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.UUID;

/**
 * The lifecycle of a session's tokens: issue a pair, exchange a refresh token for a
 * new pair (the old one is revoked), and revoke on logout. Every refresh token issued
 * is stored, so it can be revoked, with the same expiry as the token itself.
 */
@Service
@Transactional
public class AuthTokenService {

    private final JwtService jwtService;
    private final RefreshTokenRepository refreshTokens;
    private final UserRepository users;

    public AuthTokenService(JwtService jwtService, RefreshTokenRepository refreshTokens, UserRepository users) {
        this.jwtService = jwtService;
        this.refreshTokens = refreshTokens;
        this.users = users;
    }

    public TokenPair issueFor(User user) {
        String access = jwtService.generateAccessToken(user.getId(), user.getEmail(), user.getUsername());
        String refresh = jwtService.generateRefreshToken(user.getId(), user.getEmail());
        refreshTokens.save(new RefreshToken(user.getId(), refresh, jwtService.expiresAt(refresh)));
        return new TokenPair(access, refresh);
    }

    public TokenPair rotate(String refreshToken) {
        RefreshToken stored = refreshTokens.findByToken(refreshToken)
                .orElseThrow(() -> new InvalidRefreshTokenException("unknown token"));
        if (!stored.isUsableAt(Instant.now())) {
            throw new InvalidRefreshTokenException(stored.isRevoked() ? "revoked" : "expired");
        }
        Claims claims = jwtService.parseRefreshToken(refreshToken)
                .orElseThrow(() -> new InvalidRefreshTokenException("not a refresh token"));
        User user = users.findById(JwtService.userIdOf(claims))
                .orElseThrow(() -> new InvalidRefreshTokenException("account no longer exists"));

        stored.revoke();
        return issueFor(user);
    }

    public void revoke(String refreshToken) {
        refreshTokens.findByToken(refreshToken).ifPresent(RefreshToken::revoke);
    }

    /** Removes every token an account was ever issued, so none of its sessions can continue. */
    public void forgetAllFor(UUID userId) {
        refreshTokens.deleteByUserId(userId);
    }
}
