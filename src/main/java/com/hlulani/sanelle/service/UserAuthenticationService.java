package com.hlulani.sanelle.service;

import com.hlulani.sanelle.domain.entity.User;
import com.hlulani.sanelle.exception.EmailAlreadyRegisteredException;
import com.hlulani.sanelle.exception.InvalidUsernameException;
import com.hlulani.sanelle.exception.UserNotFoundException;
import com.hlulani.sanelle.exception.UsernameAlreadyTakenException;
import com.hlulani.sanelle.repository.UserRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Locale;
import java.util.Optional;
import java.util.UUID;
import java.util.regex.Pattern;

@Service
@Transactional
public class UserAuthenticationService implements UserDetailsService {

    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[A-Za-z0-9_]{3,20}$");
    private static final int USERNAME_MAX = 20;
    private static final int NUMBERED_ATTEMPTS = 20;

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final SecureRandom random = new SecureRandom();

    public UserAuthenticationService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + email));
        return new org.springframework.security.core.userdetails.User(
                user.getEmail(),
                user.getPasswordHash(),
                new ArrayList<>()
        );
    }

    @Transactional(readOnly = true)
    public User getById(UUID id) {
        return userRepository.findById(id).orElseThrow(() -> new UserNotFoundException(id));
    }

    @Transactional(readOnly = true)
    public User getByEmail(String email) {
        return findByEmail(email).orElseThrow(() -> new UserNotFoundException(email));
    }

    /**
     * The account for an address as typed. New accounts are stored lower-cased; older ones may
     * not be, so the exact spelling is tried first.
     */
    @Transactional(readOnly = true)
    public Optional<User> findByEmail(String email) {
        if (email == null || email.isBlank()) {
            return Optional.empty();
        }
        return userRepository.findByEmail(email)
                .or(() -> userRepository.findByEmail(AccountRules.normalizeEmail(email)));
    }

    public void delete(UUID id) {
        userRepository.delete(getById(id));
    }

    public void changePassword(User user, String rawPassword) {
        user.changePasswordHash(passwordEncoder.encode(rawPassword));
    }

    /**
     * Creates an unverified account. The name, email and password have already passed
     * {@link AccountRules}; a username is optional and is generated from the email (or name) when absent.
     */
    public User register(String name, String email, String username, String rawPassword) {
        boolean chosen = username != null && !username.isBlank();
        if (chosen && !USERNAME_PATTERN.matcher(username).matches()) {
            throw new InvalidUsernameException(
                    "Username must be 3-20 characters and contain only letters, numbers, and underscores");
        }
        if (userRepository.existsByEmailIgnoringCase(email)) {
            throw new EmailAlreadyRegisteredException(email);
        }
        if (chosen && userRepository.existsByUsername(username)) {
            throw new UsernameAlreadyTakenException(username);
        }

        String finalUsername = chosen ? username : generateUsername(email, name);
        User user = new User(email, finalUsername, passwordEncoder.encode(rawPassword), name, Instant.now());
        return userRepository.save(user);
    }

    /**
     * A free username that meets the username rules: the email's local part (or the name) with
     * anything but letters, digits and underscores dropped, then numbered (jane, jane2, jane3...) when taken.
     */
    String generateUsername(String email, String name) {
        String base = usernameSafe(email == null ? "" : email.substring(0, Math.max(email.indexOf('@'), 0)));
        if (base.length() < 3) {
            base = usernameSafe(name);
        }
        if (base.length() < 3) {
            base = "user";
        }
        base = truncate(base, USERNAME_MAX);
        if (!userRepository.existsByUsername(base)) {
            return base;
        }
        for (int n = 2; n < 2 + NUMBERED_ATTEMPTS; n++) {
            String candidate = numbered(base, String.valueOf(n));
            if (!userRepository.existsByUsername(candidate)) {
                return candidate;
            }
        }
        while (true) {
            String candidate = numbered(base, String.valueOf(100_000 + random.nextInt(900_000)));
            if (!userRepository.existsByUsername(candidate)) {
                return candidate;
            }
        }
    }

    private static String usernameSafe(String raw) {
        return raw == null ? "" : raw.toLowerCase(Locale.ROOT).replaceAll("[^a-z0-9_]", "");
    }

    private static String numbered(String base, String digits) {
        return truncate(base, USERNAME_MAX - digits.length()) + digits;
    }

    private static String truncate(String value, int max) {
        return value.length() > max ? value.substring(0, max) : value;
    }
}
