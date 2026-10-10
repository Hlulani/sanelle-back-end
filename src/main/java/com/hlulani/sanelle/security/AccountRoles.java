package com.hlulani.sanelle.security;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * The roles an account holds, from configuration rather than the database: the addresses in
 * {@code app.evidence.editors} (comma-separated, any case) may edit evidence. Everyone else has none.
 */
@Component
public class AccountRoles {

    public static final String EVIDENCE_EDITOR = "EVIDENCE_EDITOR";

    private final Set<String> evidenceEditors;

    public AccountRoles(@Value("${app.evidence.editors:}") String evidenceEditors) {
        this.evidenceEditors = Arrays.stream(evidenceEditors == null ? new String[0] : evidenceEditors.split(","))
                .map(email -> email.trim().toLowerCase(Locale.ROOT))
                .filter(email -> !email.isEmpty())
                .collect(Collectors.toUnmodifiableSet());
    }

    public List<String> of(String email) {
        return email != null && evidenceEditors.contains(email.trim().toLowerCase(Locale.ROOT))
                ? List.of(EVIDENCE_EDITOR)
                : List.of();
    }
}
