package com.hlulani.sanelle.controller;

import com.hlulani.sanelle.api.dto.request.EmailRequest;
import com.hlulani.sanelle.api.dto.request.LoginRequest;
import com.hlulani.sanelle.api.dto.request.PasswordResetConfirmRequest;
import com.hlulani.sanelle.api.dto.request.RefreshTokenRequest;
import com.hlulani.sanelle.api.dto.request.RegisterRequest;
import com.hlulani.sanelle.api.dto.request.VerifyEmailRequest;
import com.hlulani.sanelle.api.dto.response.LoginResponse;
import com.hlulani.sanelle.api.dto.response.RegistrationResponse;
import com.hlulani.sanelle.api.dto.response.TokenPair;
import com.hlulani.sanelle.api.dto.response.UserResponse;
import com.hlulani.sanelle.security.AuthenticatedUser;
import com.hlulani.sanelle.service.AuthService;
import org.springframework.http.HttpStatus;
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
    @ResponseStatus(HttpStatus.CREATED)
    public RegistrationResponse register(@RequestBody RegisterRequest req) {
        return auth.register(req);
    }

    @PostMapping("/login")
    public LoginResponse login(@RequestBody LoginRequest req) {
        return auth.login(req);
    }

    @PostMapping("/verify-email")
    public LoginResponse verifyEmail(@RequestBody VerifyEmailRequest req) {
        return auth.verifyEmail(req.token());
    }

    // Always 202, whatever the address: the answer must not reveal who has an account.
    @PostMapping("/verification/resend")
    public ResponseEntity<Void> resendVerification(@RequestBody EmailRequest req) {
        auth.resendVerification(req.email());
        return ResponseEntity.accepted().build();
    }

    @PostMapping("/password-reset/request")
    public ResponseEntity<Void> requestPasswordReset(@RequestBody EmailRequest req) {
        auth.requestPasswordReset(req.email());
        return ResponseEntity.accepted().build();
    }

    @PostMapping("/password-reset/confirm")
    public ResponseEntity<Void> confirmPasswordReset(@RequestBody PasswordResetConfirmRequest req) {
        auth.confirmPasswordReset(req.token(), req.password());
        return ResponseEntity.noContent().build();
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
