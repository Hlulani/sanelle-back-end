package com.hlulani.sanelle.service;

import com.hlulani.sanelle.api.dto.request.LoginRequest;
import com.hlulani.sanelle.api.dto.request.RegisterRequest;
import com.hlulani.sanelle.api.dto.response.LoginResponse;
import com.hlulani.sanelle.api.dto.response.TokenPair;
import com.hlulani.sanelle.api.dto.response.UserResponse;
import com.hlulani.sanelle.domain.entity.User;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

/** The account use cases behind /auth: sign up, sign in, refresh, sign out, "who am I" and delete. */
@Service
@Transactional
public class AuthService {

    private final AuthenticationManager authenticationManager;
    private final UserAuthenticationService accounts;
    private final AuthTokenService tokens;
    private final CustomChallengeService customChallenges;

    public AuthService(AuthenticationManager authenticationManager, UserAuthenticationService accounts,
                       AuthTokenService tokens, CustomChallengeService customChallenges) {
        this.authenticationManager = authenticationManager;
        this.accounts = accounts;
        this.tokens = tokens;
        this.customChallenges = customChallenges;
    }

    public LoginResponse register(RegisterRequest req) {
        User user = accounts.register(req.email(), req.username(), req.password());
        return LoginResponse.of(tokens.issueFor(user), user);
    }

    public LoginResponse login(LoginRequest req) {
        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(req.email(), req.password()));
        User user = accounts.getByEmail(req.email());
        return LoginResponse.of(tokens.issueFor(user), user);
    }

    public TokenPair refresh(String refreshToken) {
        return tokens.rotate(refreshToken);
    }

    public void logout(String refreshToken) {
        tokens.revoke(refreshToken);
    }

    @Transactional(readOnly = true)
    public UserResponse me(UUID userId) {
        return UserResponse.from(accounts.getById(userId));
    }

    /**
     * Deletes the account and everything the server holds for it: sessions, the challenges
     * it created (with their members) and its own challenge memberships. Health records
     * never reach the server; the app clears them from the device.
     */
    public void deleteAccount(UUID userId) {
        tokens.forgetAllFor(userId);
        customChallenges.deleteCreatedBy(userId);
        accounts.delete(userId); // its remaining memberships go with it (ON DELETE CASCADE)
    }
}
