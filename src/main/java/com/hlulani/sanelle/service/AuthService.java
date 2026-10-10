package com.hlulani.sanelle.service;

import com.hlulani.sanelle.api.dto.request.LoginRequest;
import com.hlulani.sanelle.api.dto.request.RegisterRequest;
import com.hlulani.sanelle.api.dto.response.LoginResponse;
import com.hlulani.sanelle.api.dto.response.RegistrationResponse;
import com.hlulani.sanelle.api.dto.response.TokenPair;
import com.hlulani.sanelle.api.dto.response.UserResponse;
import com.hlulani.sanelle.domain.entity.EmailTokenPurpose;
import com.hlulani.sanelle.domain.entity.User;
import com.hlulani.sanelle.exception.EmailNotVerifiedException;
import com.hlulani.sanelle.exception.InvalidCredentialsException;
import com.hlulani.sanelle.mail.AccountLinks;
import com.hlulani.sanelle.mail.AccountMailer;
import com.hlulani.sanelle.security.AccountRoles;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.UUID;

/**
 * The account use cases behind /auth: sign up, confirm the address, sign in, reset a forgotten
 * password, refresh, sign out, "who am I" and delete. Requests about an address (resend the link,
 * reset the password) answer the same whether or not an account exists, so they can't be used
 * to find out who has one.
 */
@Service
@Transactional
public class AuthService {

    private final AuthenticationManager authenticationManager;
    private final UserAuthenticationService accounts;
    private final AuthTokenService tokens;
    private final EmailTokenService emailTokens;
    private final AccountMailer mailer;
    private final AccountLinks links;
    private final AccountRoles roles;
    private final CustomChallengeService customChallenges;

    public AuthService(AuthenticationManager authenticationManager, UserAuthenticationService accounts,
                       AuthTokenService tokens, EmailTokenService emailTokens, AccountMailer mailer,
                       AccountLinks links, AccountRoles roles, CustomChallengeService customChallenges) {
        this.authenticationManager = authenticationManager;
        this.accounts = accounts;
        this.tokens = tokens;
        this.emailTokens = emailTokens;
        this.mailer = mailer;
        this.links = links;
        this.roles = roles;
        this.customChallenges = customChallenges;
    }

    /** Creates an unverified account and emails the link that confirms it; no session until then. */
    public RegistrationResponse register(RegisterRequest req) {
        String name = AccountRules.name(req.name());
        String email = AccountRules.email(req.email());
        AccountRules.password(req.password());
        AccountRules.termsAccepted(req.termsAccepted());

        User user = accounts.register(name, email, req.username(), req.password());
        sendVerification(user);
        return new RegistrationResponse(user.getEmail(), true);
    }

    /** Wrong email or password is 401; the right password on an unconfirmed address is 403. */
    public LoginResponse login(LoginRequest req) {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(req.email(), req.password()));
        } catch (AuthenticationException e) {
            throw new InvalidCredentialsException();
        }
        User user = accounts.getByEmail(req.email());
        if (!user.isEmailVerified()) {
            throw new EmailNotVerifiedException();
        }
        return signIn(user);
    }

    /** Following the emailed link confirms the address and signs the person in. */
    public LoginResponse verifyEmail(String token) {
        User user = accounts.getById(emailTokens.consume(token, EmailTokenPurpose.VERIFY_EMAIL));
        user.markEmailVerified(Instant.now());
        return signIn(user);
    }

    /** Sends a fresh link to an unconfirmed account; does nothing, silently, for anything else. */
    public void resendVerification(String email) {
        accounts.findByEmail(email)
                .filter(user -> !user.isEmailVerified())
                .ifPresent(this::sendVerification);
    }

    /** Sends a reset link if the account exists; does nothing, silently, otherwise. */
    public void requestPasswordReset(String email) {
        accounts.findByEmail(email).ifPresent(user -> {
            String token = emailTokens.issue(user.getId(), EmailTokenPurpose.RESET_PASSWORD);
            mailer.sendPasswordReset(user.getEmail(), user.getName(), links.resetPassword(token));
        });
    }

    /**
     * Sets a new password from a reset link. The link proves the address, so it also confirms it,
     * and every open session ends: whoever knew the old password is signed out.
     */
    public void confirmPasswordReset(String token, String newPassword) {
        AccountRules.password(newPassword);
        User user = accounts.getById(emailTokens.consume(token, EmailTokenPurpose.RESET_PASSWORD));
        accounts.changePassword(user, newPassword);
        user.markEmailVerified(Instant.now());
        tokens.revokeAllFor(user.getId());
    }

    public TokenPair refresh(String refreshToken) {
        return tokens.rotate(refreshToken);
    }

    public void logout(String refreshToken) {
        tokens.revoke(refreshToken);
    }

    @Transactional(readOnly = true)
    public UserResponse me(UUID userId) {
        return describe(accounts.getById(userId));
    }

    /**
     * Deletes the account and everything the server holds for it: sessions, the challenges
     * it created (with their members) and its own challenge memberships. Health records
     * never reach the server; the app clears them from the device.
     */
    public void deleteAccount(UUID userId) {
        tokens.forgetAllFor(userId);
        customChallenges.deleteCreatedBy(userId);
        accounts.delete(userId); // its remaining memberships and email links go with it (ON DELETE CASCADE)
    }

    private void sendVerification(User user) {
        String token = emailTokens.issue(user.getId(), EmailTokenPurpose.VERIFY_EMAIL);
        mailer.sendVerification(user.getEmail(), user.getName(), links.verifyEmail(token));
    }

    private LoginResponse signIn(User user) {
        return LoginResponse.of(tokens.issueFor(user), describe(user));
    }

    private UserResponse describe(User user) {
        return UserResponse.from(user, roles.of(user.getEmail()));
    }
}
