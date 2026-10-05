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

import java.util.ArrayList;
import java.util.UUID;
import java.util.regex.Pattern;

@Service
@Transactional
public class UserAuthenticationService implements UserDetailsService {

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
        User user = userRepository.findByEmail(email)
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
        return userRepository.findByEmail(email).orElseThrow(() -> new UserNotFoundException(email));
    }

    public void delete(UUID id) {
        userRepository.delete(getById(id));
    }

    public User register(String email, String username, String rawPassword) {
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