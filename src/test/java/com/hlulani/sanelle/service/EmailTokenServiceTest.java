package com.hlulani.sanelle.service;

import com.hlulani.sanelle.domain.entity.EmailToken;
import com.hlulani.sanelle.domain.entity.EmailTokenPurpose;
import com.hlulani.sanelle.exception.ErrorCode;
import com.hlulani.sanelle.exception.InvalidEmailTokenException;
import com.hlulani.sanelle.repository.EmailTokenRepository;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import java.time.Duration;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.assertj.core.api.Assertions.within;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class EmailTokenServiceTest {

    private final EmailTokenRepository repository = mock(EmailTokenRepository.class);
    private final EmailTokenService service = new EmailTokenService(repository);
    private final UUID userId = UUID.randomUUID();

    private static void assertRejectedWith(Runnable consume, ErrorCode code) {
        assertThatThrownBy(consume::run)
                .isInstanceOf(InvalidEmailTokenException.class)
                .satisfies(e -> assertThat(((InvalidEmailTokenException) e).code()).isEqualTo(code));
    }

    @Test
    void issuingStoresOnlyTheHashAndRetiresOlderLinks() {
        String raw = service.issue(userId, EmailTokenPurpose.VERIFY_EMAIL);

        ArgumentCaptor<EmailToken> saved = ArgumentCaptor.forClass(EmailToken.class);
        verify(repository).retireUnused(eq(userId), eq(EmailTokenPurpose.VERIFY_EMAIL), any());
        verify(repository).save(saved.capture());
        assertThat(raw).matches("^[A-Za-z0-9_-]{43}$"); // 32 random bytes, URL-safe base64, no padding
        assertThat(EmailTokenService.hash(raw)).matches("^[0-9a-f]{64}$").isNotEqualTo(raw);
        assertThat(saved.getValue().getExpiresAt())
                .isCloseTo(Instant.now().plus(Duration.ofHours(24)), within(5, ChronoUnit.SECONDS));
    }

    @Test
    void resetLinksLastAnHour() {
        service.issue(userId, EmailTokenPurpose.RESET_PASSWORD);

        ArgumentCaptor<EmailToken> saved = ArgumentCaptor.forClass(EmailToken.class);
        verify(repository).save(saved.capture());
        assertThat(saved.getValue().getExpiresAt())
                .isCloseTo(Instant.now().plus(Duration.ofHours(1)), within(5, ChronoUnit.SECONDS));
    }

    @Test
    void aValidTokenIsUsedUpAndNamesItsAccount() {
        EmailToken token = new EmailToken(userId, EmailTokenPurpose.VERIFY_EMAIL, "h", Instant.now().plusSeconds(60));
        when(repository.findByTokenHash(EmailTokenService.hash("raw"))).thenReturn(Optional.of(token));

        assertThat(service.consume("raw", EmailTokenPurpose.VERIFY_EMAIL)).isEqualTo(userId);
        assertThat(token.isUsed()).isTrue();
    }

    @Test
    void unknownBlankUsedOrWrongKindIsInvalid() {
        when(repository.findByTokenHash(any())).thenReturn(Optional.empty());
        assertRejectedWith(() -> service.consume("nope", EmailTokenPurpose.VERIFY_EMAIL), ErrorCode.TOKEN_INVALID);
        assertRejectedWith(() -> service.consume(" ", EmailTokenPurpose.VERIFY_EMAIL), ErrorCode.TOKEN_INVALID);

        EmailToken used = new EmailToken(userId, EmailTokenPurpose.VERIFY_EMAIL, "h", Instant.now().plusSeconds(60));
        used.markUsed(Instant.now());
        when(repository.findByTokenHash(EmailTokenService.hash("used"))).thenReturn(Optional.of(used));
        assertRejectedWith(() -> service.consume("used", EmailTokenPurpose.VERIFY_EMAIL), ErrorCode.TOKEN_INVALID);

        EmailToken reset = new EmailToken(userId, EmailTokenPurpose.RESET_PASSWORD, "h", Instant.now().plusSeconds(60));
        when(repository.findByTokenHash(EmailTokenService.hash("reset"))).thenReturn(Optional.of(reset));
        assertRejectedWith(() -> service.consume("reset", EmailTokenPurpose.VERIFY_EMAIL), ErrorCode.TOKEN_INVALID);
    }

    @Test
    void anOldTokenIsExpiredAndStaysUnused() {
        EmailToken old = new EmailToken(userId, EmailTokenPurpose.RESET_PASSWORD, "h", Instant.now().minusSeconds(1));
        when(repository.findByTokenHash(EmailTokenService.hash("old"))).thenReturn(Optional.of(old));

        assertRejectedWith(() -> service.consume("old", EmailTokenPurpose.RESET_PASSWORD), ErrorCode.TOKEN_EXPIRED);
        assertThat(old.isUsed()).isFalse();
    }
}
