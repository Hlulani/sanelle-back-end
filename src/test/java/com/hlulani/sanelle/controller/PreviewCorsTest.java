package com.hlulani.sanelle.controller;

import com.hlulani.sanelle.support.IntegrationTest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.options;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@IntegrationTest
class PreviewCorsTest {
    @Autowired MockMvc mvc;

    @Test
    void localPreviewCanPreflightSignInAndAuthenticatedRecipes() throws Exception {
        for (String origin : new String[]{"http://localhost:4300", "http://127.0.0.1:4300", "http://localhost:4301", "http://127.0.0.1:4301"}) {
            mvc.perform(options("/api/v1/auth/login")
                    .header("Origin", origin)
                    .header("Access-Control-Request-Method", "POST")
                    .header("Access-Control-Request-Headers", "content-type"))
                .andExpect(status().isOk())
                .andExpect(header().string("Access-Control-Allow-Origin", origin));
            mvc.perform(options("/api/v1/meals")
                    .header("Origin", origin)
                    .header("Access-Control-Request-Method", "GET")
                    .header("Access-Control-Request-Headers", "authorization"))
                .andExpect(status().isOk())
                .andExpect(header().string("Access-Control-Allow-Origin", origin));
        }
    }

    @Test
    void unknownWebsiteIsStillRejected() throws Exception {
        mvc.perform(options("/api/v1/auth/login")
                .header("Origin", "https://unapproved.example.test")
                .header("Access-Control-Request-Method", "POST")
                .header("Access-Control-Request-Headers", "content-type"))
            .andExpect(status().isForbidden())
            .andExpect(header().doesNotExist("Access-Control-Allow-Origin"));
    }
}
