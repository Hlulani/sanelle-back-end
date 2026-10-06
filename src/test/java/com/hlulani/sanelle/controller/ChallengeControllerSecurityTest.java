package com.hlulani.sanelle.controller;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import com.hlulani.sanelle.support.IntegrationTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@IntegrationTest
class ChallengeControllerSecurityTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void joinWithoutAuthReturns401() throws Exception {
        mockMvc.perform(post("/api/v1/challenges/weekly-5/join"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    void leaveWithoutAuthReturns401() throws Exception {
        mockMvc.perform(delete("/api/v1/challenges/weekly-5/join"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    void countsWithoutAuthReturns401() throws Exception {
        mockMvc.perform(get("/api/v1/challenges/counts").param("ids", "weekly-5"))
                .andExpect(status().isUnauthorized());
    }
}
