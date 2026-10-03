package com.hlulani.sanelle.service;

import com.hlulani.sanelle.domain.entity.User;
import com.hlulani.sanelle.exception.EmailAlreadyRegisteredException;
import com.hlulani.sanelle.exception.InvalidUsernameException;
import com.hlulani.sanelle.exception.UsernameAlreadyTakenException;
import com.hlulani.sanelle.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.regex.Pattern;

@Service
@Transactional
public class UserAuthenticationService implements UserDetailsService {

    private static final Logger log = LoggerFactory.getLogger(UserAuthenticationService.class);

    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[A-Za-z0-9_]{3,20}$");

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserAuthenticationService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        log.info("Attempting to load user by email: {}", email); // EYE 1: See the incoming request

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> {
                    log.warn("User lookup failed for email: {}", email); // EYE 2: See if lookup failed
                    return new UsernameNotFoundException("User not found: " + email);
                });

        log.info("User found! Proceeding to password check for: {}", email); // EYE 3: Confirmation

        return new org.springframework.security.core.userdetails.User(
                user.getEmail(),
                user.getPasswordHash(),
                new ArrayList<>()
        );
    }

    public User register(String email, String username, String rawPassword) {
        log.info("Registering new user: {} ({})", email, username);

        if (username == null || !USERNAME_PATTERN.matcher(username).matches()) {
            throw new InvalidUsernameException(
                    "Username must be 3-20 characters and contain only letters, numbers, and underscores");
        }
        if (userRepository.existsByEmail(email)) {
            throw new EmailAlreadyRegisteredException(email);
        }
        if (userRepository.existsByUsername(username)) {
            throw new UsernameAlreadyTakenException(username);
        }

        User user = new User(email, username, passwordEncoder.encode(rawPassword));
        return userRepository.save(user);
    }
}