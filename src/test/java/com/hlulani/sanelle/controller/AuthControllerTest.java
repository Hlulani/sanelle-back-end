package com.hlulani.sanelle.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Map;
import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class AuthControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    private Map<?, ?> register() throws Exception {
        String suffix = UUID.randomUUID().toString().replace("-", "").substring(0, 10);
        String body = objectMapper.writeValueAsString(Map.of(
                "email", "auth-" + suffix + "@example.com", "username", "a" + suffix, "password", "TestPass123!"));
        String json = mockMvc.perform(post("/api/v1/auth/register").contentType("application/json").content(body))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.user.username").value("a" + suffix))
                .andReturn().getResponse().getContentAsString();
        return objectMapper.readValue(json, Map.class);
    }

    private String refreshBody(Object token) throws Exception {
        return objectMapper.writeValueAsString(Map.of("refreshToken", token));
    }

    @Test
    void refreshRotatesTheTokenAndTheOldOneStopsWorking() throws Exception {
        Object first = register().get("refreshToken");

        mockMvc.perform(post("/api/v1/auth/refresh").contentType("application/json").content(refreshBody(first)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.accessToken").isNotEmpty());
        mockMvc.perform(post("/api/v1/auth/refresh").contentType("application/json").content(refreshBody(first)))
                .andExpect(status().isUnauthorized());
    }

    @Test
    void aLoggedOutRefreshTokenIsRejected() throws Exception {
        Object token = register().get("refreshToken");

        mockMvc.perform(post("/api/v1/auth/logout").contentType("application/json").content(refreshBody(token)))
                .andExpect(status().isNoContent());
        mockMvc.perform(post("/api/v1/auth/refresh").contentType("application/json").content(refreshBody(token)))
                .andExpect(status().isUnauthorized());
    }

    @Test
    void anUnknownRefreshTokenIsUnauthorizedNotAServerError() throws Exception {
        mockMvc.perform(post("/api/v1/auth/refresh").contentType("application/json").content(refreshBody("not-a-token")))
                .andExpect(status().isUnauthorized());
    }

    @Test
    void meReturnsTheSignedInUser() throws Exception {
        Map<?, ?> session = register();
        Map<?, ?> user = (Map<?, ?>) session.get("user");

        mockMvc.perform(get("/api/v1/auth/me").header("Authorization", "Bearer " + session.get("accessToken")))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.email").value(user.get("email")));
    }

    @Test
    void aMissingMealIsNotFound() throws Exception {
        Object access = register().get("accessToken");

        mockMvc.perform(get("/api/v1/meals/" + UUID.randomUUID()).header("Authorization", "Bearer " + access))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.message").value(org.hamcrest.Matchers.startsWith("Meal not found")));
    }

    @Test
    void deletingAnAccountRemovesItsSessionsAndChallenges() throws Exception {
        Map<?, ?> owner = register();
        String ownerAccess = "Bearer " + owner.get("accessToken");
        Map<?, ?> friend = register();
        String friendAccess = "Bearer " + friend.get("accessToken");

        String created = mockMvc.perform(post("/api/v1/custom-challenges").header("Authorization", ownerAccess)
                        .contentType("application/json")
                        .content(objectMapper.writeValueAsString(Map.of(
                                "name", "Cook 3 times", "type", "meals-in-period", "targetCount", 3, "durationDays", 7))))
                .andExpect(status().isCreated())
                .andReturn().getResponse().getContentAsString();
        Map<?, ?> challenge = objectMapper.readValue(created, Map.class);
        mockMvc.perform(post("/api/v1/custom-challenges/join").header("Authorization", friendAccess)
                        .contentType("application/json")
                        .content(objectMapper.writeValueAsString(Map.of("inviteCode", challenge.get("inviteCode")))))
                .andExpect(status().isOk());

        mockMvc.perform(delete("/api/v1/auth/me").header("Authorization", ownerAccess))
                .andExpect(status().isNoContent());

        Map<?, ?> ownerUser = (Map<?, ?>) owner.get("user");
        mockMvc.perform(post("/api/v1/auth/login").contentType("application/json")
                        .content(objectMapper.writeValueAsString(Map.of("email", ownerUser.get("email"), "password", "TestPass123!"))))
                .andExpect(status().isUnauthorized());
        mockMvc.perform(post("/api/v1/auth/refresh").contentType("application/json").content(refreshBody(owner.get("refreshToken"))))
                .andExpect(status().isUnauthorized());
        mockMvc.perform(get("/api/v1/custom-challenges/mine").header("Authorization", friendAccess))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(0));
        mockMvc.perform(get("/api/v1/custom-challenges/" + challenge.get("id") + "/members").header("Authorization", friendAccess))
                .andExpect(status().isNotFound());
    }

    @Test
    void deletingWithoutSigningInIsRefused() throws Exception {
        mockMvc.perform(delete("/api/v1/auth/me")).andExpect(status().isUnauthorized());
    }
}
