package com.hlulani.sanelle.service;

import com.hlulani.sanelle.domain.entity.User;
import com.hlulani.sanelle.exception.EmailAlreadyRegisteredException;
import com.hlulani.sanelle.exception.InvalidUsernameException;
import com.hlulani.sanelle.exception.UsernameAlreadyTakenException;
import com.hlulani.sanelle.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.password.PasswordEncoder;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class UserAuthenticationServiceTest {

    private final UserRepository userRepository = mock(UserRepository.class);
    private final PasswordEncoder passwordEncoder = mock(PasswordEncoder.class);
    private final UserAuthenticationService service = new UserAuthenticationService(userRepository, passwordEncoder);

    @Test
    void registersUserWithUsername() {
        when(passwordEncoder.encode("secret123")).thenReturn("hashed");
        when(userRepository.save(any(User.class))).thenAnswer(inv -> inv.getArgument(0));

        User user = service.register("New Person", "new@example.com", "new_user", "secret123");

        assertThat(user.getEmail()).isEqualTo("new@example.com");
        assertThat(user.getUsername()).isEqualTo("new_user");
        assertThat(user.getPasswordHash()).isEqualTo("hashed");
        assertThat(user.getDisplayName()).isEqualTo("New Person");
        assertThat(user.getTermsAcceptedAt()).isNotNull();
        assertThat(user.isEmailVerified()).isFalse();
    }

    @Test
    void rejectsDuplicateEmailWithDistinguishableError() {
        when(userRepository.existsByEmailIgnoringCase("taken@example.com")).thenReturn(true);

        assertThatThrownBy(() -> service.register("Name", "taken@example.com", "someuser", "secret123"))
                .isInstanceOf(EmailAlreadyRegisteredException.class);
    }

    @Test
    void rejectsDuplicateUsernameWithDistinguishableError() {
        when(userRepository.existsByEmailIgnoringCase(any())).thenReturn(false);
        when(userRepository.existsByUsername("taken_user")).thenReturn(true);

        assertThatThrownBy(() -> service.register("Name", "fresh@example.com", "taken_user", "secret123"))
                .isInstanceOf(UsernameAlreadyTakenException.class);
    }

    @Test
    void rejectsTooShortUsernameWithDistinguishableError() {
        assertThatThrownBy(() -> service.register("Name", "fresh@example.com", "ab", "secret123"))
                .isInstanceOf(InvalidUsernameException.class);
    }

    @Test
    void rejectsUsernameWithInvalidCharactersWithDistinguishableError() {
        assertThatThrownBy(() -> service.register("Name", "fresh@example.com", "bad name!", "secret123"))
                .isInstanceOf(InvalidUsernameException.class);
    }

    @Test
    void invalidUsernameIsCheckedBeforeHittingTheDatabase() {
        // Format validation should short-circuit before any repository lookups.
        assertThatThrownBy(() -> service.register("Name", "fresh@example.com", "x", "secret123"))
                .isInstanceOf(InvalidUsernameException.class);

        org.mockito.Mockito.verifyNoInteractions(userRepository);
    }

    @Test
    void withoutAUsernameOneIsMadeFromTheEmail() {
        when(userRepository.save(any(User.class))).thenAnswer(inv -> inv.getArgument(0));

        User user = service.register("Thandi Mokoena", "thandi.mokoena+food@example.com", null, "secret123");

        assertThat(user.getUsername()).isEqualTo("thandimokoenafood");
    }

    @Test
    void aGeneratedUsernameIsNumberedWhenTaken() {
        when(userRepository.existsByUsername("thandi")).thenReturn(true);
        when(userRepository.existsByUsername("thandi2")).thenReturn(true);

        assertThat(service.generateUsername("thandi@example.com", "Thandi")).isEqualTo("thandi3");
    }

    @Test
    void aGeneratedUsernameAlwaysMeetsTheUsernameRules() {
        when(userRepository.existsByUsername(any())).thenReturn(false);
        when(userRepository.existsByUsername("averyveryverylongnam")).thenReturn(true);

        // A short local part falls back to the name; nothing usable falls back to "user".
        assertThat(service.generateUsername("j@example.com", "Jo Ann")).isEqualTo("joann");
        assertThat(service.generateUsername("é@example.com", "李")).isEqualTo("user");
        // Long names are cut so the number still fits in 20 characters.
        assertThat(service.generateUsername("averyveryverylongname@example.com", "x"))
                .isEqualTo("averyveryverylongna2")
                .matches("^[A-Za-z0-9_]{3,20}$");
    }
}
