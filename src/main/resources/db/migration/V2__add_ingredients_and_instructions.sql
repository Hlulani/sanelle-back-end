-- Ingredients table (Embeddable Ingredient)
-- Ingredients table (Embeddable Ingredient)
CREATE TABLE IF NOT EXISTS meal_ingredients (
                                                meal_id UUID NOT NULL,
                                                name TEXT NOT NULL,
                                                amount TEXT,
                                                PRIMARY KEY (meal_id, name),
                                                CONSTRAINT fk_meal_ingredients_meal
                                                    FOREIGN KEY (meal_id)
                                                        REFERENCES meals (id)
                                                        ON DELETE CASCADE
);

-- Instructions table (ordered list of strings)
CREATE TABLE IF NOT EXISTS meal_instructions (
                                                 meal_id UUID NOT NULL,
                                                 step_order INT NOT NULL,
                                                 instruction TEXT NOT NULL,
                                                 PRIMARY KEY (meal_id, step_order),
    CONSTRAINT fk_meal_instructions_meal
    FOREIGN KEY (meal_id)
    REFERENCES meals (id)
    ON DELETE CASCADE
    );
