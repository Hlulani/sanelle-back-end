package com.hlulani.sanelle.support;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Map;
import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Signed-in accounts for tests that aren't about signing up: registers over HTTP, marks the
 * address confirmed directly in the database (the emailed link is covered by AccountJourneyTest),
 * then signs in.
 */
public final class TestAccounts {

    public static final String PASSWORD = "TestPass123!";

    private final MockMvc mockMvc;
    private final ObjectMapper objectMapper;
    private final JdbcTemplate jdbc;

    public TestAccounts(MockMvc mockMvc, ObjectMapper objectMapper, JdbcTemplate jdbc) {
        this.mockMvc = mockMvc;
        this.objectMapper = objectMapper;
        this.jdbc = jdbc;
    }

    public static String uniqueEmail(String prefix) {
        return prefix + "-" + UUID.randomUUID().toString().replace("-", "").substring(0, 10) + "@example.com";
    }

    /** Registers an account and returns the address, still unconfirmed. */
    public String register(String email, String username) throws Exception {
        Map<String, Object> body = new java.util.HashMap<>(Map.of(
                "name", "Test Person", "email", email, "password", PASSWORD, "termsAccepted", true));
        if (username != null) {
            body.put("username", username);
        }
        mockMvc.perform(post("/api/v1/auth/register").contentType("application/json")
                        .content(objectMapper.writeValueAsString(body)))
                .andExpect(status().isCreated());
        return email;
    }

    public void markVerified(String email) {
        jdbc.update("UPDATE users SET email_verified_at = now() WHERE email = ?", email);
    }

    /** A confirmed account's session: {@code accessToken}, {@code refreshToken} and {@code user}. */
    public Map<?, ?> signedIn(String emailPrefix, String username) throws Exception {
        String email = register(uniqueEmail(emailPrefix), username);
        markVerified(email);
        return login(email, PASSWORD);
    }

    public Map<?, ?> signedIn(String emailPrefix) throws Exception {
        return signedIn(emailPrefix, null);
    }

    public Map<?, ?> login(String email, String password) throws Exception {
        String json = mockMvc.perform(post("/api/v1/auth/login").contentType("application/json")
                        .content(objectMapper.writeValueAsString(Map.of("email", email, "password", password))))
                .andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        return objectMapper.readValue(json, Map.class);
    }
}
