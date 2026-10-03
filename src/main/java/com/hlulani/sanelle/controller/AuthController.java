package com.hlulani.sanelle.controller;

import com.hlulani.sanelle.domain.entity.RefreshToken;
import com.hlulani.sanelle.domain.entity.User;
import com.hlulani.sanelle.repository.RefreshTokenRepository;
import com.hlulani.sanelle.repository.UserRepository;
import com.hlulani.sanelle.security.JwtProperties;
import com.hlulani.sanelle.security.JwtService;
import com.hlulani.sanelle.service.UserAuthenticationService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {

    private final AuthenticationManager authenticationManager;
    private final UserAuthenticationService userAuthenticationService;
    private final UserRepository userRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private final JwtService jwtService;
    private final JwtProperties jwtProperties;

    public AuthController(
            AuthenticationManager authenticationManager,
            UserAuthenticationService userAuthenticationService,
            UserRepository userRepository,
            RefreshTokenRepository refreshTokenRepository,
            JwtService jwtService,
            JwtProperties jwtProperties
    ) {
        this.authenticationManager = authenticationManager;
        this.userAuthenticationService = userAuthenticationService;
        this.userRepository = userRepository;
        this.refreshTokenRepository = refreshTokenRepository;
        this.jwtService = jwtService;
        this.jwtProperties = jwtProperties;
    }

    public record AuthRequest(String email, String password) {}
    public record RegisterRequest(String email, String username, String password) {}
    public record UserResponse(UUID id, String email, String username) {}

    public record LoginResponse(String accessToken, String refreshToken, UserResponse user) {}
    public record RefreshRequest(String refreshToken) {}
    public record TokenPair(String accessToken, String refreshToken) {}
    public record LogoutRequest(String refreshToken) {}

    @PostMapping("/register")
    public ResponseEntity<LoginResponse> register(@RequestBody RegisterRequest req) {

        // 1) Create user
        User user = userAuthenticationService.register(req.email(), req.username(), req.password());

        // 2) Issue tokens (same as login)
        String access = jwtService.generateAccessToken(user.getId(), user.getEmail(), user.getUsername());
        String refresh = jwtService.generateRefreshToken(user.getId(), user.getEmail());

        // 3) Persist refresh token
        Instant refreshExp = Instant.now().plus(jwtProperties.refreshDays(), ChronoUnit.DAYS);
        refreshTokenRepository.save(new RefreshToken(user.getId(), refresh, refreshExp));

        return ResponseEntity.ok(
                new LoginResponse(access, refresh, new UserResponse(user.getId(), user.getEmail(), user.getUsername()))
        );
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@RequestBody AuthRequest req) {
        // 1) Validate credentials via Spring Security
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(req.email(), req.password())
        );

        // 2) Load user to get UUID
        User user = userRepository.findByEmail(req.email())
                .orElseThrow(() -> new IllegalStateException("Authenticated but user missing in DB"));

        // 3) Issue tokens
        String access = jwtService.generateAccessToken(user.getId(), user.getEmail(), user.getUsername());
        String refresh = jwtService.generateRefreshToken(user.getId(), user.getEmail());

        // 4) Persist refresh token (for revoke/rotate)
        Instant refreshExp = Instant.now().plus(jwtProperties.refreshDays(), ChronoUnit.DAYS);
        refreshTokenRepository.save(new RefreshToken(user.getId(), refresh, refreshExp));

        return ResponseEntity.ok(
                new LoginResponse(access, refresh, new UserResponse(user.getId(), user.getEmail(), user.getUsername()))
        );
    }

    @PostMapping("/refresh")
    public ResponseEntity<TokenPair> refresh(@RequestBody RefreshRequest req) {
        RefreshToken stored = refreshTokenRepository.findByToken(req.refreshToken())
                .orElseThrow(() -> new IllegalArgumentException("Invalid refresh token"));

        if (stored.isRevoked()) {
            throw new IllegalArgumentException("Refresh token revoked");
        }
        if (stored.getExpiresAt().isBefore(Instant.now())) {
            throw new IllegalArgumentException("Refresh token expired");
        }

        // ✅ ADD THIS EXACTLY HERE
        if (!jwtService.isRefreshToken(req.refreshToken())) {
            throw new IllegalArgumentException("Not a refresh token");
        }

        UUID userId = jwtService.getUserId(req.refreshToken());
        String email = jwtService.getEmail(req.refreshToken());
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalStateException("Refresh token valid but user missing in DB"));

        stored.revoke();

        String newAccess = jwtService.generateAccessToken(userId, email, user.getUsername());
        String newRefresh = jwtService.generateRefreshToken(userId, email);

        Instant refreshExp = Instant.now().plus(jwtProperties.refreshDays(), ChronoUnit.DAYS);
        refreshTokenRepository.save(new RefreshToken(userId, newRefresh, refreshExp));

        return ResponseEntity.ok(new TokenPair(newAccess, newRefresh));
    }


    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@RequestBody LogoutRequest req) {
        refreshTokenRepository.findByToken(req.refreshToken())
                .ifPresent(RefreshToken::revoke);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/me")
    public ResponseEntity<UserResponse> me(@AuthenticationPrincipal UserDetails principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }

        User user = userRepository.findByEmail(principal.getUsername())
                .orElseThrow(() -> new IllegalStateException("Principal exists but user missing in DB"));

        return ResponseEntity.ok(new UserResponse(user.getId(), user.getEmail(), user.getUsername()));
    }
}
