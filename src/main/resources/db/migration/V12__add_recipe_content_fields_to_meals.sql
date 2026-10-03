-- V12__add_recipe_content_fields_to_meals.sql
-- Adds richer recipe-detail content to meals: why it helps nutritionally,
-- vegetable substitution guidance, fresh-vs-frozen guidance, a plating/color
-- description, and prep time. All nullable since the 62 existing meals don't
-- have this content yet (only the new batch seeded in V13 will).

ALTER TABLE meals
    ADD COLUMN why_it_helps TEXT,
    ADD COLUMN vegetable_substitutes TEXT,
    ADD COLUMN fresh_or_frozen TEXT,
    ADD COLUMN color_palette TEXT,
    ADD COLUMN prep_time_minutes INTEGER;

-- Dietary labels (Vegan, Vegetarian, Gluten-free, Dairy-free, etc.) — distinct
-- from the existing free-form `meal_tags` (which mixes diet, prep-style, and
-- health-focus tags together). Same shape/FK pattern as meal_tags.
CREATE TABLE IF NOT EXISTS meal_dietary_tags (
    meal_id UUID NOT NULL,
    dietary_tag VARCHAR(255) NOT NULL,
    CONSTRAINT fk_meal_dietary_tags_meal
        FOREIGN KEY (meal_id)
            REFERENCES meals (id)
            ON DELETE CASCADE
);
