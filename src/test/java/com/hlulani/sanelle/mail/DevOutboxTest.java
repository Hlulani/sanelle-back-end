package com.hlulani.sanelle.mail;

import com.hlulani.sanelle.domain.entity.EmailTokenPurpose;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

class DevOutboxTest {

    private final DevOutbox outbox = new DevOutbox();

    @Test
    void keepsEachAddressesMessagesNewestFirstWithTheirToken() {
        outbox.record("a@example.com", EmailTokenPurpose.VERIFY_EMAIL, "http://app/verify-email?token=first");
        outbox.record("b@example.com", EmailTokenPurpose.VERIFY_EMAIL, "http://app/verify-email?token=other");
        outbox.record("a@example.com", EmailTokenPurpose.RESET_PASSWORD, "http://app/reset-password?token=second");

        List<OutboxMessage> messages = outbox.to("A@Example.com");

        assertThat(messages).extracting(OutboxMessage::token).containsExactly("second", "first");
        assertThat(messages.get(0).purpose()).isEqualTo("RESET_PASSWORD");
        assertThat(messages.get(0).link()).isEqualTo("http://app/reset-password?token=second");
        assertThat(messages.get(0).sentAt()).isNotNull();
    }

    @Test
    void forgetsTheOldestPastItsCapacity() {
        for (int i = 0; i <= DevOutbox.CAPACITY; i++) {
            outbox.record("a@example.com", EmailTokenPurpose.VERIFY_EMAIL, "http://app/verify-email?token=t" + i);
        }

        List<OutboxMessage> messages = outbox.to("a@example.com");

        assertThat(messages).hasSize(DevOutbox.CAPACITY);
        assertThat(messages.get(0).token()).isEqualTo("t" + DevOutbox.CAPACITY);
        assertThat(messages).extracting(OutboxMessage::token).doesNotContain("t0");
    }
}
