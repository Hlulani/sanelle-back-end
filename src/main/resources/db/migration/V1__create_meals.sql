CREATE TABLE meals (
                       id UUID PRIMARY KEY,
                       name VARCHAR(255) NOT NULL,
                       meal_type VARCHAR(50) NOT NULL,
                       anti_inflammatory_score INTEGER NOT NULL,
                       iron_support INTEGER NOT NULL,
                       fiber_score INTEGER NOT NULL,
                       created_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE meal_tags (
                           meal_id UUID NOT NULL,
                           tag VARCHAR(255) NOT NULL,

                           CONSTRAINT fk_meal_tags_meal
                               FOREIGN KEY (meal_id)
                                   REFERENCES meals (id)
                                   ON DELETE CASCADE
);
