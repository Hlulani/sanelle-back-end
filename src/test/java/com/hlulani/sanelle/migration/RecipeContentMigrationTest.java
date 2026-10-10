package com.hlulani.sanelle.migration;

import org.flywaydb.core.Flyway;
import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.util.HashSet;

import static org.assertj.core.api.Assertions.assertThat;

/** All migration checks run exclusively against this disposable container. */
@Testcontainers
class RecipeContentMigrationTest {
    @Container
    static final PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine");

    private Flyway flyway(String schema, String target) {
        var config = Flyway.configure().dataSource(postgres.getJdbcUrl(), postgres.getUsername(), postgres.getPassword())
                .schemas(schema).defaultSchema(schema).locations("classpath:db/migration");
        if (target != null) config.target(target);
        return config.load();
    }

    private JdbcTemplate jdbc(String schema) {
        return new JdbcTemplate(new DriverManagerDataSource(postgres.getJdbcUrl() + (postgres.getJdbcUrl().contains("?") ? "&" : "?") + "currentSchema=" + schema,
                postgres.getUsername(), postgres.getPassword()));
    }

    @Test
    void freshInstallationPublishesAllRecipesWithOrderedDirectionsAndHonestProvenance() {
        flyway("fresh_recipes", null).migrate();
        var db = jdbc("fresh_recipes");
        assertThat(db.queryForObject("select count(*) from meals", Integer.class)).isEqualTo(166);
        assertThat(db.queryForObject("select count(*) from meals where recipe_content is not null", Integer.class)).isEqualTo(166);
        assertThat(db.queryForObject("select count(*) from meals where recipe_content->>'kitchenTested' = 'false' and recipe_content->>'reviewStatus' = 'editorial'", Integer.class)).isEqualTo(166);
        assertThat(db.queryForObject("select count(*) from (select meal_id from meal_instructions group by meal_id having min(step_order) <> 0 or max(step_order) <> count(*) - 1) gaps", Integer.class)).isZero();
        var cod = db.queryForList("select instruction from meal_instructions where meal_id=(select id from meals where name='Baked Cod with Lemon and Greens') order by step_order", String.class);
        assertThat(cod).hasSize(5);
        assertThat(cod.get(0)).contains("200°C", "thawed");
        assertThat(cod.get(2)).contains("12-15 minutes", "fish cooking check");
        assertThat(db.queryForObject("select count(*) from meals where name in ('Oat Banana Pancakes','Golden Milk Smoothie Bowl')", Integer.class)).isEqualTo(2);
    }

    @Test
    void upgradePreservesCustomInstructionsIngredientsIdsAndOtherMealAttributes() {
        flyway("edited_recipes", "20").migrate();
        var db = jdbc("edited_recipes");
        var ids = new HashSet<>(db.queryForList("select id::text from meals", String.class));
        var ingredients = db.queryForList("select meal_id::text, name, amount from meal_ingredients order by meal_id,name,amount");
        var attributes = db.queryForList("select id::text, meal_type, image_url, prep_time_minutes from meals order by id");
        var tags = db.queryForList("select meal_id::text, dietary_tag from meal_dietary_tags order by meal_id,dietary_tag");
        db.update("update meal_instructions set instruction='Custom cooking directions' where step_order=0 and meal_id=(select id from meals where name='Baked Cod with Lemon and Greens')");
        db.update("update meal_ingredients set amount='Custom amount' where name='Apple' and meal_id=(select id from meals where name='Apple Cinnamon Oatmeal')");
        assertThat(db.queryForObject("select count(*) from meal_ingredients where amount='Custom amount'", Integer.class)).isEqualTo(1);
        var editedIngredients = db.queryForList("select meal_id::text, name, amount from meal_ingredients order by meal_id,name,amount");
        assertThat(editedIngredients).isNotEqualTo(ingredients);
        flyway("edited_recipes", null).migrate();
        assertThat(new HashSet<>(db.queryForList("select id::text from meals", String.class))).isEqualTo(ids);
        assertThat(db.queryForList("select meal_id::text, name, amount from meal_ingredients order by meal_id,name,amount")).isEqualTo(editedIngredients);
        assertThat(db.queryForList("select id::text, meal_type, image_url, prep_time_minutes from meals order by id")).isEqualTo(attributes);
        assertThat(db.queryForList("select meal_id::text, dietary_tag from meal_dietary_tags order by meal_id,dietary_tag")).isEqualTo(tags);
        assertThat(db.queryForObject("select instruction from meal_instructions where step_order=0 and meal_id=(select id from meals where name='Baked Cod with Lemon and Greens')", String.class)).isEqualTo("Custom cooking directions");
        assertThat(db.queryForObject("select count(*) from meals where recipe_content is null", Integer.class)).isEqualTo(2);
        assertThat(db.queryForObject("select count(*) from meals where recipe_content is not null", Integer.class)).isEqualTo(164);
    }
}
