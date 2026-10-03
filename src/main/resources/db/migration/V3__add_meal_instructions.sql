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
