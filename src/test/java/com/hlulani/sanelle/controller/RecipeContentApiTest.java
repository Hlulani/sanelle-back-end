package com.hlulani.sanelle.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hlulani.sanelle.support.IntegrationTest;
import com.hlulani.sanelle.support.TestAccounts;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.web.servlet.MockMvc;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@IntegrationTest
class RecipeContentApiTest {
    @Autowired MockMvc mvc;
    @Autowired ObjectMapper mapper;
    @Autowired JdbcTemplate jdbc;

    @Test
    void databaseProvenanceAndDirectionsReachTheAuthenticatedRecipeApi() throws Exception {
        var session = new TestAccounts(mvc, mapper, jdbc).signedIn("recipe-content", "recipe_reader");
        var token = (String) session.get("accessToken");
        var id = jdbc.queryForObject("select id::text from meals where name='Baked Cod with Lemon and Greens'", String.class);
        var result = mvc.perform(get("/api/v1/meals/" + id).header("Authorization", "Bearer " + token))
                .andExpect(status().isOk()).andReturn();
        var meal = mapper.readTree(result.getResponse().getContentAsString(java.nio.charset.StandardCharsets.UTF_8));
        assertThat(meal.path("instructions").size()).isEqualTo(5);
        assertThat(meal.path("instructions").get(0).asText()).contains("200°C");
        assertThat(meal.path("recipeContent").path("version").asText()).isEqualTo("2026-10-10.v1");
        assertThat(meal.path("recipeContent").path("kitchenTested").asBoolean()).isFalse();
        assertThat(meal.path("recipeContent").path("cookingChecks").toString()).contains("fish");
        assertThat(meal.path("recipeContent").path("ingredientNotes").toString()).contains("thawed");
        assertThat(meal.path("recipeContent").path("sourceUrls").toString()).contains("foodsafety.gov", "neff-international.com");
    }
}
