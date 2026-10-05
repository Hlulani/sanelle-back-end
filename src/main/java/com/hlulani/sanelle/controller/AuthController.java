package com.hlulani.sanelle.controller;

import com.hlulani.sanelle.api.dto.request.LoginRequest;
import com.hlulani.sanelle.api.dto.request.RefreshTokenRequest;
import com.hlulani.sanelle.api.dto.request.RegisterRequest;
import com.hlulani.sanelle.api.dto.response.LoginResponse;
import com.hlulani.sanelle.api.dto.response.TokenPair;
import com.hlulani.sanelle.api.dto.response.UserResponse;
import com.hlulani.sanelle.security.AuthenticatedUser;
import com.hlulani.sanelle.service.AuthService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {

    private final AuthService auth;

    public AuthController(AuthService auth) {
        this.auth = auth;
    }

    @PostMapping("/register")
    public LoginResponse register(@RequestBody RegisterRequest req) {
        return auth.register(req);
    }

    @PostMapping("/login")
    public LoginResponse login(@RequestBody LoginRequest req) {
        return auth.login(req);
    }

    @PostMapping("/refresh")
    public TokenPair refresh(@RequestBody RefreshTokenRequest req) {
        return auth.refresh(req.refreshToken());
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@RequestBody RefreshTokenRequest req) {
        auth.logout(req.refreshToken());
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/me")
    public ResponseEntity<UserResponse> me(@AuthenticationPrincipal AuthenticatedUser principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }
        return ResponseEntity.ok(auth.me(principal.getUserId()));
    }

    @DeleteMapping("/me")
    public ResponseEntity<Void> deleteMe(@AuthenticationPrincipal AuthenticatedUser principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }
        auth.deleteAccount(principal.getUserId());
        return ResponseEntity.noContent().build();
    }
}
