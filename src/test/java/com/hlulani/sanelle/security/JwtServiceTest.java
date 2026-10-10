package com.hlulani.sanelle.security;

import io.jsonwebtoken.Claims;
import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

class JwtServiceTest {

    private final JwtService jwtService = new JwtService(
            new JwtProperties("x".repeat(40), 15, 30)
    );

    @Test
    void accessTokenIncludesUsernameClaimAlongsideEmailAndUid() {
        UUID userId = UUID.randomUUID();
        String token = jwtService.generateAccessToken(userId, "someone@example.com", "someone_123", "Some One", List.of());

        Claims claims = jwtService.parse(token);

        assertThat(claims.getSubject()).isEqualTo("someone@example.com");
        assertThat(claims.get("uid", String.class)).isEqualTo(userId.toString());
        assertThat(claims.get("username", String.class)).isEqualTo("someone_123");
    }

    @Test
    void accessTokenCarriesTheNameAndRoles() {
        String token = jwtService.generateAccessToken(UUID.randomUUID(), "editor@example.com", "editor",
                "Ed Itor", List.of(AccountRoles.EVIDENCE_EDITOR));

        Claims claims = jwtService.parse(token);

        assertThat(claims.get("name", String.class)).isEqualTo("Ed Itor");
        assertThat(claims.get("roles", List.class)).containsExactly("EVIDENCE_EDITOR");
    }

    @Test
    void rolesIsAnEmptyListNotMissingForOrdinaryAccounts() {
        Claims claims = jwtService.parse(jwtService.generateAccessToken(UUID.randomUUID(), "a@example.com", "abc",
                "abc", List.of()));

        assertThat(claims.get("roles", List.class)).isEmpty();
    }
}
