package com.hlulani.sanelle.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hlulani.sanelle.security.JwtService;
import com.hlulani.sanelle.service.EmailTokenService;
import com.hlulani.sanelle.support.IntegrationTest;
import com.hlulani.sanelle.support.TestAccounts;
import io.jsonwebtoken.Claims;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasSize;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Sign up, confirm the address from the emailed link, sign in, and reset a forgotten password,
 * reading the links from the development outbox the way the end-to-end tests do.
 */
@IntegrationTest
@TestPropertySource(properties = {
        "app.mail.outbox.enabled=true",
        "app.evidence.editors= Editor-Journey@Example.com ,someone-else@example.com"
})
class AccountJourneyTest {

    private static final String PASSWORD = TestAccounts.PASSWORD;

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private JdbcTemplate jdbc;

    @Autowired
    private JwtService jwtService;

    private Map<String, Object> registration(String email) {
        return new HashMap<>(Map.of("name", "Thandi Mokoena", "email", email, "password", PASSWORD,
                "termsAccepted", true));
    }

    private ResultActions postJson(String path, Object body) throws Exception {
        return mockMvc.perform(post("/api/v1/auth" + path).contentType("application/json")
                .content(objectMapper.writeValueAsString(body)));
    }

    private String register(String email) throws Exception {
        postJson("/register", registration(email)).andExpect(status().isCreated());
        return email;
    }

    private List<Map<?, ?>> outbox(String email) throws Exception {
        String json = mockMvc.perform(get("/api/v1/dev/outbox").param("email", email))
                .andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        return List.of(objectMapper.readValue(json, Map[].class));
    }

    /** The token from the newest email of this kind sent to the address. */
    private String latestToken(String email, String purpose) throws Exception {
        return outbox(email).stream()
                .filter(m -> purpose.equals(m.get("purpose")))
                .map(m -> (String) m.get("token"))
                .findFirst()
                .orElseThrow(() -> new AssertionError("no " + purpose + " email to " + email));
    }

    private Map<?, ?> verify(String token) throws Exception {
        String json = postJson("/verify-email", Map.of("token", token))
                .andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        return objectMapper.readValue(json, Map.class);
    }

    private ResultActions login(String email, String password) throws Exception {
        return postJson("/login", Map.of("email", email, "password", password));
    }

    // --- Sign-up ---

    @Test
    void signingUpSendsALinkAndReturnsNoTokens() throws Exception {
        String email = TestAccounts.uniqueEmail("journey");

        postJson("/register", registration(email))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.email").value(email))
                .andExpect(jsonPath("$.verificationRequired").value(true))
                .andExpect(jsonPath("$.accessToken").doesNotExist())
                .andExpect(jsonPath("$.refreshToken").doesNotExist());

        List<Map<?, ?>> sent = outbox(email);
        assertThat(sent).hasSize(1);
        assertThat(sent.get(0).get("to")).isEqualTo(email);
        assertThat(sent.get(0).get("purpose")).isEqualTo("VERIFY_EMAIL");
        assertThat((String) sent.get(0).get("link"))
                .isEqualTo("http://localhost:4200/verify-email?token=" + sent.get(0).get("token"));
        assertThat(sent.get(0).get("sentAt")).isNotNull();
    }

    @Test
    void theRawTokenIsNeverStored() throws Exception {
        String email = register(TestAccounts.uniqueEmail("hashed"));
        String token = latestToken(email, "VERIFY_EMAIL");

        assertThat(jdbc.queryForObject("SELECT COUNT(*) FROM email_tokens WHERE token_hash = ?", Integer.class,
                EmailTokenService.hash(token))).isEqualTo(1);
        assertThat(jdbc.queryForObject("SELECT COUNT(*) FROM email_tokens WHERE token_hash = ?", Integer.class,
                token)).isZero();
    }

    @Test
    void signUpStoresTheNameTermsAndAnUnconfirmedAddress() throws Exception {
        String email = register(TestAccounts.uniqueEmail("stored"));

        Map<String, Object> row = jdbc.queryForMap(
                "SELECT display_name, terms_accepted_at, email_verified_at, username FROM users WHERE email = ?", email);
        assertThat(row.get("display_name")).isEqualTo("Thandi Mokoena");
        assertThat(row.get("terms_accepted_at")).isNotNull();
        assertThat(row.get("email_verified_at")).isNull();
        assertThat((String) row.get("username")).matches("^[A-Za-z0-9_]{3,20}$");
    }

    @Test
    void theEmailIsStoredLowerCasedAndSignInAcceptsAnyCase() throws Exception {
        String email = TestAccounts.uniqueEmail("mixedcase");
        Map<String, Object> body = registration("  " + email.toUpperCase() + " ");
        postJson("/register", body)
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.email").value(email));
        verify(latestToken(email, "VERIFY_EMAIL"));

        login(email.toUpperCase(), PASSWORD).andExpect(status().isOk());
    }

    @Test
    void eachBrokenRuleHasItsOwnCode() throws Exception {
        String email = TestAccounts.uniqueEmail("rules");
        Map<String, Object> noName = registration(email);
        noName.put("name", "   ");
        Map<String, Object> longName = registration(email);
        longName.put("name", "a".repeat(81));
        Map<String, Object> badEmail = registration("not-an-email");
        Map<String, Object> shortPassword = registration(email);
        shortPassword.put("password", "short");
        Map<String, Object> longPassword = registration(email);
        longPassword.put("password", "x".repeat(129));
        Map<String, Object> noTerms = registration(email);
        noTerms.put("termsAccepted", false);
        Map<String, Object> missingTerms = registration(email);
        missingTerms.remove("termsAccepted");
        Map<String, Object> badUsername = registration(email);
        badUsername.put("username", "no spaces!");

        Map<Map<String, Object>, String> expected = Map.of(
                noName, "NAME_REQUIRED", longName, "NAME_TOO_LONG", badEmail, "EMAIL_INVALID",
                shortPassword, "PASSWORD_TOO_SHORT", longPassword, "PASSWORD_TOO_LONG",
                noTerms, "TERMS_REQUIRED", missingTerms, "TERMS_REQUIRED", badUsername, "USERNAME_INVALID");
        for (Map.Entry<Map<String, Object>, String> c : expected.entrySet()) {
            postJson("/register", c.getKey())
                    .andExpect(status().isBadRequest())
                    .andExpect(jsonPath("$.code").value(c.getValue()))
                    .andExpect(jsonPath("$.status").value(400))
                    .andExpect(jsonPath("$.message").isNotEmpty());
        }
        assertThat(outbox(email)).isEmpty();
    }

    @Test
    void onlyTheFirstBrokenRuleIsReported() throws Exception {
        Map<String, Object> everythingWrong = new HashMap<>(Map.of("name", "", "email", "x", "password", "1"));

        postJson("/register", everythingWrong)
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("NAME_REQUIRED"));
    }

    @Test
    void anAddressCanOnlyBeRegisteredOnce() throws Exception {
        String email = register(TestAccounts.uniqueEmail("twice"));

        postJson("/register", registration(email.toUpperCase()))
                .andExpect(status().isConflict())
                .andExpect(jsonPath("$.code").value("EMAIL_TAKEN"));
    }

    @Test
    void aChosenUsernameMustBeFree() throws Exception {
        String username = "u" + java.util.UUID.randomUUID().toString().replace("-", "").substring(0, 12);
        Map<String, Object> first = registration(TestAccounts.uniqueEmail("first"));
        first.put("username", username);
        postJson("/register", first).andExpect(status().isCreated());

        Map<String, Object> second = registration(TestAccounts.uniqueEmail("second"));
        second.put("username", username.toUpperCase());
        postJson("/register", second)
                .andExpect(status().isConflict())
                .andExpect(jsonPath("$.code").value("USERNAME_TAKEN"));
    }

    // --- Signing in and confirming the address ---

    @Test
    void anUnconfirmedAccountIsToldSoOnlyWithTheRightPassword() throws Exception {
        String email = register(TestAccounts.uniqueEmail("unconfirmed"));

        login(email, "WrongPass123!")
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.code").value("INVALID_CREDENTIALS"));
        login(email, PASSWORD)
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.code").value("EMAIL_NOT_VERIFIED"));
        login("nobody-" + email, PASSWORD)
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.code").value("INVALID_CREDENTIALS"));
    }

    @Test
    void theLinkConfirmsTheAddressAndSignsIn() throws Exception {
        String email = register(TestAccounts.uniqueEmail("confirm"));

        Map<?, ?> session = verify(latestToken(email, "VERIFY_EMAIL"));

        assertThat(session.get("accessToken")).isNotNull();
        assertThat(session.get("refreshToken")).isNotNull();
        Map<?, ?> user = (Map<?, ?>) session.get("user");
        assertThat(user.get("email")).isEqualTo(email);
        assertThat(user.get("name")).isEqualTo("Thandi Mokoena");
        assertThat(user.get("emailVerified")).isEqualTo(true);
        assertThat(user.get("roles")).isEqualTo(List.of());

        login(email, PASSWORD).andExpect(status().isOk()).andExpect(jsonPath("$.accessToken").isNotEmpty());
        mockMvc.perform(get("/api/v1/auth/me").header("Authorization", "Bearer " + session.get("accessToken")))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name").value("Thandi Mokoena"))
                .andExpect(jsonPath("$.emailVerified").value(true))
                .andExpect(jsonPath("$.roles", hasSize(0)));
    }

    @Test
    void aLinkWorksOnlyOnce() throws Exception {
        String email = register(TestAccounts.uniqueEmail("once"));
        String token = latestToken(email, "VERIFY_EMAIL");
        verify(token);

        postJson("/verify-email", Map.of("token", token))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("TOKEN_INVALID"));
        postJson("/verify-email", Map.of("token", "made-up"))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("TOKEN_INVALID"));
    }

    @Test
    void anExpiredLinkIsRejected() throws Exception {
        String email = register(TestAccounts.uniqueEmail("expired"));
        String token = latestToken(email, "VERIFY_EMAIL");
        jdbc.update("UPDATE email_tokens SET expires_at = now() - interval '1 minute' WHERE token_hash = ?",
                EmailTokenService.hash(token));

        postJson("/verify-email", Map.of("token", token))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("TOKEN_EXPIRED"));
        login(email, PASSWORD).andExpect(jsonPath("$.code").value("EMAIL_NOT_VERIFIED"));
    }

    @Test
    void aResentLinkReplacesTheOldOne() throws Exception {
        String email = register(TestAccounts.uniqueEmail("resend"));
        String first = latestToken(email, "VERIFY_EMAIL");

        postJson("/verification/resend", Map.of("email", email))
                .andExpect(status().isAccepted())
                .andExpect(content().string(""));
        String second = latestToken(email, "VERIFY_EMAIL");

        assertThat(outbox(email)).hasSize(2);
        assertThat(second).isNotEqualTo(first);
        postJson("/verify-email", Map.of("token", first)).andExpect(jsonPath("$.code").value("TOKEN_INVALID"));
        verify(second);
    }

    @Test
    void resendingSaysNothingAboutUnknownOrConfirmedAddresses() throws Exception {
        String unknown = TestAccounts.uniqueEmail("unknown");
        postJson("/verification/resend", Map.of("email", unknown)).andExpect(status().isAccepted());
        assertThat(outbox(unknown)).isEmpty();

        String confirmed = register(TestAccounts.uniqueEmail("confirmed"));
        verify(latestToken(confirmed, "VERIFY_EMAIL"));
        postJson("/verification/resend", Map.of("email", confirmed)).andExpect(status().isAccepted());
        assertThat(outbox(confirmed)).hasSize(1); // only the original sign-up email

        postJson("/verification/resend", Map.of("email", "not an email")).andExpect(status().isAccepted());
    }

    // --- Forgotten password ---

    @Test
    void resetRequestsSayNothingAboutUnknownAddresses() throws Exception {
        String unknown = TestAccounts.uniqueEmail("nobody");

        postJson("/password-reset/request", Map.of("email", unknown))
                .andExpect(status().isAccepted())
                .andExpect(content().string(""));
        assertThat(outbox(unknown)).isEmpty();
    }

    @Test
    void resettingThePasswordEndsEverySessionAndTheOldPasswordStopsWorking() throws Exception {
        String email = register(TestAccounts.uniqueEmail("reset"));
        Map<?, ?> session = verify(latestToken(email, "VERIFY_EMAIL"));
        Object refresh = session.get("refreshToken");

        postJson("/password-reset/request", Map.of("email", email)).andExpect(status().isAccepted());
        String token = latestToken(email, "RESET_PASSWORD");
        assertThat((String) outbox(email).get(0).get("link"))
                .isEqualTo("http://localhost:4200/reset-password?token=" + token);

        postJson("/password-reset/confirm", Map.of("token", token, "password", "short"))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("PASSWORD_TOO_SHORT"));
        postJson("/password-reset/confirm", Map.of("token", token, "password", "BrandNewPass456!"))
                .andExpect(status().isNoContent());

        postJson("/refresh", Map.of("refreshToken", refresh))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.code").value("REFRESH_TOKEN_INVALID"));
        login(email, PASSWORD)
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.code").value("INVALID_CREDENTIALS"));
        login(email, "BrandNewPass456!").andExpect(status().isOk());
        postJson("/password-reset/confirm", Map.of("token", token, "password", "AnotherPass789!"))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("TOKEN_INVALID"));
    }

    @Test
    void aResetLinkAlsoConfirmsTheAddress() throws Exception {
        String email = register(TestAccounts.uniqueEmail("reset-unconfirmed"));

        postJson("/password-reset/request", Map.of("email", email)).andExpect(status().isAccepted());
        postJson("/password-reset/confirm",
                Map.of("token", latestToken(email, "RESET_PASSWORD"), "password", "BrandNewPass456!"))
                .andExpect(status().isNoContent());

        login(email, "BrandNewPass456!").andExpect(status().isOk());
    }

    @Test
    void anExpiredOrVerificationTokenCannotResetAPassword() throws Exception {
        String email = register(TestAccounts.uniqueEmail("reset-expired"));
        String verifyToken = latestToken(email, "VERIFY_EMAIL");
        postJson("/password-reset/confirm", Map.of("token", verifyToken, "password", "BrandNewPass456!"))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("TOKEN_INVALID"));

        postJson("/password-reset/request", Map.of("email", email)).andExpect(status().isAccepted());
        String token = latestToken(email, "RESET_PASSWORD");
        jdbc.update("UPDATE email_tokens SET expires_at = now() - interval '1 second' WHERE token_hash = ?",
                EmailTokenService.hash(token));
        postJson("/password-reset/confirm", Map.of("token", token, "password", "BrandNewPass456!"))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("TOKEN_EXPIRED"));
    }

    // --- Roles ---

    @Test
    void configuredEditorsGetTheEvidenceEditorRole() throws Exception {
        String email = register(TestAccounts.uniqueEmail("x").replaceFirst("^x-[^@]+", "editor-journey"));
        Map<?, ?> session = verify(latestToken(email, "VERIFY_EMAIL"));

        Claims claims = jwtService.parse((String) session.get("accessToken"));
        assertThat(claims.get("roles", List.class)).containsExactly("EVIDENCE_EDITOR");
        assertThat(claims.get("name", String.class)).isEqualTo("Thandi Mokoena");
        assertThat(((Map<?, ?>) session.get("user")).get("roles")).isEqualTo(List.of("EVIDENCE_EDITOR"));

        String other = register(TestAccounts.uniqueEmail("reader"));
        Claims readerClaims = jwtService.parse((String) verify(latestToken(other, "VERIFY_EMAIL")).get("accessToken"));
        assertThat(readerClaims.get("roles", List.class)).isEmpty();
    }
}
