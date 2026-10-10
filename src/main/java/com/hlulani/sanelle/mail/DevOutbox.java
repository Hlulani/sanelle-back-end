package com.hlulani.sanelle.mail;

import com.hlulani.sanelle.domain.entity.EmailTokenPurpose;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

import java.time.Instant;
import java.util.ArrayDeque;
import java.util.Deque;
import java.util.List;
import java.util.Locale;

/**
 * Development only: the last {@value #CAPACITY} emails sent, in memory, so end-to-end tests can
 * follow a link without a mail server. Exists only when {@code app.mail.outbox.enabled=true}.
 */
@Component
@ConditionalOnProperty(name = "app.mail.outbox.enabled", havingValue = "true")
public class DevOutbox {

    static final int CAPACITY = 200;

    private final Deque<OutboxMessage> messages = new ArrayDeque<>();

    public synchronized void record(String to, EmailTokenPurpose purpose, String link) {
        String token = UriComponentsBuilder.fromUriString(link).build().getQueryParams().getFirst("token");
        messages.addFirst(new OutboxMessage(to, purpose.name(), link, token, Instant.now()));
        while (messages.size() > CAPACITY) {
            messages.removeLast();
        }
    }

    /** The messages sent to an address, newest first. */
    public synchronized List<OutboxMessage> to(String email) {
        String wanted = email == null ? "" : email.trim().toLowerCase(Locale.ROOT);
        return messages.stream().filter(m -> m.to().toLowerCase(Locale.ROOT).equals(wanted)).toList();
    }
}
