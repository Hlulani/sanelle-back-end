package com.hlulani.sanelle.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hlulani.sanelle.support.IntegrationTest;
import com.hlulani.sanelle.support.TestAccounts;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/** Without an API key the AI endpoints say so, and the app keeps its own suggestions. */
@IntegrationTest
class AiInsightsApiTest {
    @Autowired MockMvc mvc;
    @Autowired ObjectMapper mapper;
    @Autowired JdbcTemplate jdbc;

    private static final String REQUEST = """
            {"checkins":[{"date":"2026-10-09","symptoms":["Pain"],"bleeding":"none","dailyImpact":"Slowed me down","note":""}],
             "facts":["Pain on 1 of 1 check-ins."],"explanations":[],"savedQuestions":[]}
            """;

    @Test
    void needsASignedInAccount() throws Exception {
        mvc.perform(get("/api/v1/ai/status")).andExpect(status().isUnauthorized());
        mvc.perform(post("/api/v1/ai/insights").contentType(MediaType.APPLICATION_JSON).content(REQUEST))
                .andExpect(status().isUnauthorized());
    }

    @Test
    void reportsUnavailableWithoutAKey() throws Exception {
        var token = (String) new TestAccounts(mvc, mapper, jdbc).signedIn("ai-status", "ai_reader").get("accessToken");
        mvc.perform(get("/api/v1/ai/status").header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.available").value(false))
                .andExpect(jsonPath("$.reason").value("no-key"));
        mvc.perform(post("/api/v1/ai/insights").header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON).content(REQUEST))
                .andExpect(status().isServiceUnavailable());
    }
}
