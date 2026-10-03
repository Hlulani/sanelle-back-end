package com.hlulani.sanelle.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import java.util.Map;
import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class CustomChallengeControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    private String registerAndLogin(String emailPrefix) throws Exception {
        String suffix = UUID.randomUUID().toString().replace("-", "").substring(0, 10);
        Map<String, String> registerBody = Map.of(
                "email", emailPrefix + "-" + suffix + "@example.com",
                "username", "u" + suffix,
                "password", "TestPass123!"
        );

        MvcResult result = mockMvc.perform(post("/api/v1/auth/register")
                        .contentType("application/json")
                        .content(objectMapper.writeValueAsString(registerBody)))
                .andExpect(status().isOk())
                .andReturn();

        Map<?, ?> response = objectMapper.readValue(result.getResponse().getContentAsString(), Map.class);
        return (String) response.get("accessToken");
    }

    private Map<?, ?> createChallenge(String token, String name, String type, int targetCount, int durationDays) throws Exception {
        Map<String, Object> body = Map.of(
                "name", name,
                "type", type,
                "targetCount", targetCount,
                "durationDays", durationDays
        );

        MvcResult result = mockMvc.perform(post("/api/v1/custom-challenges")
                        .header("Authorization", "Bearer " + token)
                        .contentType("application/json")
                        .content(objectMapper.writeValueAsString(body)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.isCreator").value(true))
                .andExpect(jsonPath("$.inviteCode").isNotEmpty())
                .andReturn();

        return objectMapper.readValue(result.getResponse().getContentAsString(), Map.class);
    }

    @Test
    void creatingAChallengeAutoJoinsTheCreator() throws Exception {
        String token = registerAndLogin("creator");
        Map<?, ?> created = createChallenge(token, "Auto Join Test", "meals-in-period", 5, 7);
        String challengeId = (String) created.get("id");

        mockMvc.perform(get("/api/v1/custom-challenges/mine")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[?(@.id == '" + challengeId + "')]").exists());

        mockMvc.perform(get("/api/v1/custom-challenges/" + challengeId + "/members")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(1));
    }

    @Test
    void joiningByValidCodeSucceedsAndIsIdempotent() throws Exception {
        String creatorToken = registerAndLogin("creator2");
        String joinerToken = registerAndLogin("joiner");

        Map<?, ?> created = createChallenge(creatorToken, "Joinable Challenge", "streak", 3, 14);
        String inviteCode = (String) created.get("inviteCode");
        String challengeId = (String) created.get("id");

        Map<String, String> joinBody = Map.of("inviteCode", inviteCode);
        String joinJson = objectMapper.writeValueAsString(joinBody);

        mockMvc.perform(post("/api/v1/custom-challenges/join")
                        .header("Authorization", "Bearer " + joinerToken)
                        .contentType("application/json")
                        .content(joinJson))
                .andExpect(status().isOk());

        // Joining again must not throw or create a duplicate membership row.
        mockMvc.perform(post("/api/v1/custom-challenges/join")
                        .header("Authorization", "Bearer " + joinerToken)
                        .contentType("application/json")
                        .content(joinJson))
                .andExpect(status().isOk());

        mockMvc.perform(get("/api/v1/custom-challenges/" + challengeId + "/members")
                        .header("Authorization", "Bearer " + joinerToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2)); // creator + joiner, no duplicate
    }

    @Test
    void joiningWithUnknownCodeReturns404() throws Exception {
        String token = registerAndLogin("joiner2");
        Map<String, String> joinBody = Map.of("inviteCode", "NOPE0000");

        mockMvc.perform(post("/api/v1/custom-challenges/join")
                        .header("Authorization", "Bearer " + token)
                        .contentType("application/json")
                        .content(objectMapper.writeValueAsString(joinBody)))
                .andExpect(status().isNotFound());
    }

    @Test
    void membersReturns403ForANonMember() throws Exception {
        String creatorToken = registerAndLogin("creator3");
        String outsiderToken = registerAndLogin("outsider");

        Map<?, ?> created = createChallenge(creatorToken, "Private Challenge", "days-in-period", 10, 30);
        String challengeId = (String) created.get("id");

        mockMvc.perform(get("/api/v1/custom-challenges/" + challengeId + "/members")
                        .header("Authorization", "Bearer " + outsiderToken))
                .andExpect(status().isForbidden());
    }

    @Test
    void mineNeverIncludesAChallengeTheUserHasNotCreatedOrJoined() throws Exception {
        String creatorToken = registerAndLogin("creator4");
        String outsiderToken = registerAndLogin("outsider2");

        Map<?, ?> created = createChallenge(creatorToken, "Not Yours", "streak", 5, 7);
        String challengeId = (String) created.get("id");

        mockMvc.perform(get("/api/v1/custom-challenges/mine")
                        .header("Authorization", "Bearer " + outsiderToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[?(@.id == '" + challengeId + "')]").doesNotExist());
    }
}
