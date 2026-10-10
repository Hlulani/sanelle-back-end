package com.hlulani.sanelle.controller;

import com.hlulani.sanelle.mail.DevOutbox;
import com.hlulani.sanelle.mail.OutboxMessage;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/** Development only (app.mail.outbox.enabled=true): read the emails the server has "sent". */
@RestController
@RequestMapping(DevOutboxController.PATH)
@ConditionalOnProperty(name = "app.mail.outbox.enabled", havingValue = "true")
public class DevOutboxController {

    public static final String PATH = "/api/v1/dev/outbox";

    private final DevOutbox outbox;

    public DevOutboxController(DevOutbox outbox) {
        this.outbox = outbox;
    }

    @GetMapping
    public List<OutboxMessage> messagesTo(@RequestParam String email) {
        return outbox.to(email);
    }
}
