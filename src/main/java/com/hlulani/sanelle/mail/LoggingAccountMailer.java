package com.hlulani.sanelle.mail;

import com.hlulani.sanelle.domain.entity.EmailTokenPurpose;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/**
 * Until a mail server is wired up, "sending" writes the link to the log so a developer can click
 * it, and, when the development outbox is switched on, keeps a copy there for automated tests.
 */
@Component
public class LoggingAccountMailer implements AccountMailer {

    private static final Logger log = LoggerFactory.getLogger(LoggingAccountMailer.class);

    private final ObjectProvider<DevOutbox> outbox;

    public LoggingAccountMailer(ObjectProvider<DevOutbox> outbox) {
        this.outbox = outbox;
    }

    @Override
    public void sendVerification(String email, String name, String link) {
        log.info("Verification email for {} ({}): {}", email, name, link);
        outbox.ifAvailable(o -> o.record(email, EmailTokenPurpose.VERIFY_EMAIL, link));
    }

    @Override
    public void sendPasswordReset(String email, String name, String link) {
        log.info("Password reset email for {} ({}): {}", email, name, link);
        outbox.ifAvailable(o -> o.record(email, EmailTokenPurpose.RESET_PASSWORD, link));
    }
}
