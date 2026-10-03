-- V4__seed_50_meals.sql
-- Seeds 50 meals with ingredients + instructions + tags

CREATE EXTENSION IF NOT EXISTS pgcrypto;

DO $$
DECLARE
m UUID;
BEGIN
  --------------------------------------------------------------------
  -- 1) BREAKFAST (12)
  --------------------------------------------------------------------
  m := gen_random_uuid();
INSERT INTO meals (id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score, created_at)
VALUES (m, 'Spinach and Feta Scramble', 'BREAKFAST', 4, 3, 2, now());
INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'high-protein'), (m, 'quick');
INSERT INTO meal_ingredients (meal_id, name, amount) VALUES
                                                         (m, 'Eggs', '2'),
                                                         (m, 'Spinach', '2 cups'),
                                                         (m, 'Feta', '30 g'),
                                                         (m, 'Olive oil', '1 tsp'),
                                                         (m, 'Salt', 'pinch');
INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES
                                                                     (m, 0, 'Heat olive oil in a pan on medium heat.'),
                                                                     (m, 1, 'Add spinach and cook until wilted.'),
                                                                     (m, 2, 'Add beaten eggs, scramble, then finish with feta.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Overnight Oats with Chia and Berries', 'BREAKFAST', 5, 2, 5, now());
INSERT INTO meal_tags VALUES (m, 'breakfast'), (m, 'meal-prep'), (m, 'high-fiber');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Rolled oats', '1/2 cup'),
                                 (m, 'Chia seeds', '1 tbsp'),
                                 (m, 'Milk (or oat milk)', '3/4 cup'),
                                 (m, 'Greek yogurt', '2 tbsp'),
                                 (m, 'Mixed berries', '1/2 cup');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Mix oats, chia, milk, and yogurt in a jar.'),
                                  (m, 1, 'Refrigerate overnight.'),
                                  (m, 2, 'Top with berries before serving.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Avocado Tomato Toast', 'BREAKFAST', 4, 2, 4, now());
INSERT INTO meal_tags VALUES (m, 'breakfast'), (m, 'quick'), (m, 'vegetarian');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Wholegrain bread', '2 slices'),
                                 (m, 'Avocado', '1/2'),
                                 (m, 'Cherry tomatoes', '6'),
                                 (m, 'Lemon juice', '1 tsp'),
                                 (m, 'Salt', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Toast the bread.'),
                                  (m, 1, 'Mash avocado with lemon and salt.'),
                                  (m, 2, 'Spread on toast and top with tomatoes.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Peanut Butter Banana Oat Bowl', 'BREAKFAST', 3, 2, 4, now());
INSERT INTO meal_tags VALUES (m, 'breakfast'), (m, 'high-energy'), (m, 'kid-friendly');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Rolled oats', '1/2 cup'),
                                 (m, 'Water or milk', '1 cup'),
                                 (m, 'Banana', '1'),
                                 (m, 'Peanut butter', '1 tbsp'),
                                 (m, 'Cinnamon', '1/4 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Cook oats with water/milk until creamy.'),
                                  (m, 1, 'Slice banana and stir in cinnamon.'),
                                  (m, 2, 'Top with peanut butter and banana.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Greek Yogurt with Nuts and Honey', 'BREAKFAST', 3, 2, 2, now());
INSERT INTO meal_tags VALUES (m, 'breakfast'), (m, 'no-cook'), (m, 'high-protein');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Greek yogurt', '200 g'),
                                 (m, 'Mixed nuts', '2 tbsp'),
                                 (m, 'Honey', '1 tsp'),
                                 (m, 'Cinnamon', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Add yogurt to a bowl.'),
                                  (m, 1, 'Top with nuts and honey.'),
                                  (m, 2, 'Finish with cinnamon.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Apple Cinnamon Oatmeal', 'BREAKFAST', 4, 2, 5, now());
INSERT INTO meal_tags VALUES (m, 'breakfast'), (m, 'high-fiber'), (m, 'warm');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Rolled oats', '1/2 cup'),
                                 (m, 'Milk or water', '1 cup'),
                                 (m, 'Apple', '1/2, diced'),
                                 (m, 'Cinnamon', '1/2 tsp'),
                                 (m, 'Walnuts', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Cook oats with milk/water.'),
                                  (m, 1, 'Stir in apple and cinnamon.'),
                                  (m, 2, 'Top with walnuts.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Veggie Omelette', 'BREAKFAST', 4, 3, 3, now());
INSERT INTO meal_tags VALUES (m, 'breakfast'), (m, 'high-protein');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Eggs', '2'),
                                 (m, 'Mushrooms', '1/2 cup'),
                                 (m, 'Bell pepper', '1/4 cup'),
                                 (m, 'Onion', '2 tbsp'),
                                 (m, 'Olive oil', '1 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Sauté veggies in olive oil until soft.'),
                                  (m, 1, 'Pour in beaten eggs.'),
                                  (m, 2, 'Cook until set and fold.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Smoked Salmon Cucumber Toast', 'BREAKFAST', 4, 3, 2, now());
INSERT INTO meal_tags VALUES (m, 'breakfast'), (m, 'high-protein');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Wholegrain bread', '2 slices'),
                                 (m, 'Smoked salmon', '60 g'),
                                 (m, 'Cucumber', '6 slices'),
                                 (m, 'Cream cheese', '1 tbsp'),
                                 (m, 'Lemon', 'wedge');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Toast bread and spread cream cheese.'),
                                  (m, 1, 'Add salmon and cucumber.'),
                                  (m, 2, 'Squeeze lemon and serve.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Berry Spinach Smoothie', 'BREAKFAST', 5, 3, 4, now());
INSERT INTO meal_tags VALUES (m, 'breakfast'), (m, 'smoothie'), (m, 'anti-inflammatory');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Spinach', '1 cup'),
                                 (m, 'Mixed berries', '1 cup'),
                                 (m, 'Banana', '1/2'),
                                 (m, 'Greek yogurt', '1/2 cup'),
                                 (m, 'Water', '1/2 cup');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Add all ingredients to blender.'),
                                  (m, 1, 'Blend until smooth.'),
                                  (m, 2, 'Adjust water to desired thickness.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Cottage Cheese and Pineapple Bowl', 'BREAKFAST', 3, 2, 2, now());
INSERT INTO meal_tags VALUES (m, 'breakfast'), (m, 'no-cook'), (m, 'high-protein');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cottage cheese', '200 g'),
                                 (m, 'Pineapple', '1/2 cup'),
                                 (m, 'Chia seeds', '1 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Add cottage cheese to a bowl.'),
                                  (m, 1, 'Top with pineapple.'),
                                  (m, 2, 'Sprinkle chia seeds.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Tomato Basil Egg Muffins', 'BREAKFAST', 4, 3, 2, now());
INSERT INTO meal_tags VALUES (m, 'breakfast'), (m, 'meal-prep');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Eggs', '4'),
                                 (m, 'Cherry tomatoes', '1/2 cup'),
                                 (m, 'Basil', '2 tbsp'),
                                 (m, 'Salt', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Whisk eggs and mix in tomatoes and basil.'),
                                  (m, 1, 'Pour into muffin cups.'),
                                  (m, 2, 'Bake at 180°C for ~15 minutes.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Warm Quinoa Breakfast Bowl', 'BREAKFAST', 4, 3, 4, now());
INSERT INTO meal_tags VALUES (m, 'breakfast'), (m, 'high-fiber');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked quinoa', '1 cup'),
                                 (m, 'Milk (or oat milk)', '1/2 cup'),
                                 (m, 'Cinnamon', '1/2 tsp'),
                                 (m, 'Blueberries', '1/2 cup'),
                                 (m, 'Almonds', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Warm quinoa with milk in a small pot.'),
                                  (m, 1, 'Stir in cinnamon.'),
                                  (m, 2, 'Top with blueberries and almonds.');

--------------------------------------------------------------------
-- 2) LUNCH (14)
--------------------------------------------------------------------
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Chickpea Salad with Lemon Dressing', 'LUNCH', 5, 4, 5, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'high-fiber'), (m, 'vegetarian');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Chickpeas', '1 can, rinsed'),
                                 (m, 'Cucumber', '1/2, diced'),
                                 (m, 'Tomatoes', '1, diced'),
                                 (m, 'Red onion', '2 tbsp'),
                                 (m, 'Lemon juice', '1 tbsp'),
                                 (m, 'Olive oil', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Combine chickpeas and chopped veggies.'),
                                  (m, 1, 'Mix lemon juice and olive oil as dressing.'),
                                  (m, 2, 'Toss and season to taste.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Tuna and White Bean Bowl', 'LUNCH', 4, 4, 4, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'high-protein');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Tuna', '1 can'),
                                 (m, 'White beans', '1/2 can'),
                                 (m, 'Parsley', '1 tbsp'),
                                 (m, 'Lemon juice', '1 tbsp'),
                                 (m, 'Olive oil', '1 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Drain tuna and beans.'),
                                  (m, 1, 'Mix with parsley, lemon, and olive oil.'),
                                  (m, 2, 'Serve as a bowl or with bread.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Turkey Hummus Wrap', 'LUNCH', 3, 3, 3, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'quick');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Wholegrain wrap', '1'),
                                 (m, 'Hummus', '2 tbsp'),
                                 (m, 'Turkey slices', '80 g'),
                                 (m, 'Lettuce', '1 cup'),
                                 (m, 'Cucumber', '1/4 sliced');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Spread hummus on wrap.'),
                                  (m, 1, 'Add turkey and veggies.'),
                                  (m, 2, 'Roll and slice.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Lentil Soup (Quick)', 'LUNCH', 5, 4, 5, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'high-fiber'), (m, 'anti-inflammatory');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked lentils', '2 cups'),
                                 (m, 'Carrot', '1, diced'),
                                 (m, 'Onion', '1/2, diced'),
                                 (m, 'Garlic', '1 clove'),
                                 (m, 'Vegetable stock', '3 cups');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Sauté onion, carrot, and garlic.'),
                                  (m, 1, 'Add lentils and stock.'),
                                  (m, 2, 'Simmer 10–15 minutes.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Quinoa Chicken Salad', 'LUNCH', 4, 4, 4, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'meal-prep'), (m, 'high-protein');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked quinoa', '1 cup'),
                                 (m, 'Cooked chicken', '120 g'),
                                 (m, 'Cucumber', '1/2'),
                                 (m, 'Olive oil', '1 tbsp'),
                                 (m, 'Lemon juice', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Combine quinoa, chicken, and chopped cucumber.'),
                                  (m, 1, 'Mix lemon and olive oil.'),
                                  (m, 2, 'Toss and season.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Salmon Rice Bowl', 'LUNCH', 4, 4, 3, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'omega-3');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked rice', '1 cup'),
                                 (m, 'Cooked salmon', '120 g'),
                                 (m, 'Avocado', '1/2'),
                                 (m, 'Cucumber', '1/3'),
                                 (m, 'Soy sauce', '1 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Add rice to bowl.'),
                                  (m, 1, 'Top with salmon and sliced veggies.'),
                                  (m, 2, 'Drizzle soy sauce.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Mediterranean Pasta Salad', 'LUNCH', 3, 3, 3, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'meal-prep');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked pasta', '1.5 cups'),
                                 (m, 'Olives', '2 tbsp'),
                                 (m, 'Feta', '40 g'),
                                 (m, 'Tomatoes', '1/2 cup'),
                                 (m, 'Olive oil', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Combine pasta with olives, tomatoes, and feta.'),
                                  (m, 1, 'Add olive oil.'),
                                  (m, 2, 'Toss and chill.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Egg Salad Lettuce Cups', 'LUNCH', 3, 3, 2, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'low-carb');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Boiled eggs', '2'),
                                 (m, 'Greek yogurt', '2 tbsp'),
                                 (m, 'Mustard', '1 tsp'),
                                 (m, 'Lettuce', '4 leaves');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Mash eggs with yogurt and mustard.'),
                                  (m, 1, 'Spoon into lettuce leaves.'),
                                  (m, 2, 'Serve immediately.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Roasted Veggie Couscous', 'LUNCH', 4, 3, 4, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'vegetarian');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked couscous', '1 cup'),
                                 (m, 'Zucchini', '1/2'),
                                 (m, 'Bell pepper', '1/2'),
                                 (m, 'Olive oil', '1 tbsp'),
                                 (m, 'Salt', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Roast chopped veggies with olive oil.'),
                                  (m, 1, 'Mix into couscous.'),
                                  (m, 2, 'Season and serve.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Sardine Toast with Lemon', 'LUNCH', 4, 4, 2, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'omega-3'), (m, 'quick');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Wholegrain bread', '2 slices'),
                                 (m, 'Sardines', '1 can'),
                                 (m, 'Lemon juice', '1 tsp'),
                                 (m, 'Black pepper', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Toast the bread.'),
                                  (m, 1, 'Top with sardines.'),
                                  (m, 2, 'Add lemon juice and pepper.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Bean and Corn Salsa Bowl', 'LUNCH', 4, 3, 5, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'high-fiber'), (m, 'vegetarian');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Black beans', '1/2 can'),
                                 (m, 'Corn', '1/2 cup'),
                                 (m, 'Tomatoes', '1/2 cup'),
                                 (m, 'Lime juice', '1 tbsp'),
                                 (m, 'Cilantro', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Mix beans, corn, and tomatoes.'),
                                  (m, 1, 'Add lime juice and cilantro.'),
                                  (m, 2, 'Serve as a bowl.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Chicken Veggie Soup', 'LUNCH', 4, 4, 3, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'comfort');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked chicken', '120 g'),
                                 (m, 'Carrot', '1'),
                                 (m, 'Celery', '1 stalk'),
                                 (m, 'Chicken stock', '3 cups'),
                                 (m, 'Salt', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Simmer carrot and celery in stock.'),
                                  (m, 1, 'Add chicken and warm through.'),
                                  (m, 2, 'Season and serve.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Tofu Stir-Fry Bowl', 'LUNCH', 4, 3, 4, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'vegetarian'), (m, 'high-protein');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Tofu', '200 g'),
                                 (m, 'Broccoli', '1 cup'),
                                 (m, 'Carrot', '1/2'),
                                 (m, 'Soy sauce', '1 tbsp'),
                                 (m, 'Olive oil', '1 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Sauté tofu until lightly browned.'),
                                  (m, 1, 'Add veggies and cook until tender.'),
                                  (m, 2, 'Add soy sauce and serve.');

--------------------------------------------------------------------
-- 3) DINNER (14)
--------------------------------------------------------------------
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Garlic Lemon Chicken with Broccoli', 'DINNER', 4, 4, 3, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'high-protein'), (m, 'easy');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Chicken breast', '180 g'),
                                 (m, 'Broccoli', '2 cups'),
                                 (m, 'Garlic', '2 cloves'),
                                 (m, 'Lemon juice', '1 tbsp'),
                                 (m, 'Olive oil', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Cook chicken in olive oil until done.'),
                                  (m, 1, 'Add garlic and broccoli, sauté until tender.'),
                                  (m, 2, 'Finish with lemon juice.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Baked Salmon with Sweet Potato', 'DINNER', 5, 4, 4, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'omega-3'), (m, 'anti-inflammatory');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Salmon', '180 g'),
                                 (m, 'Sweet potato', '1 medium'),
                                 (m, 'Olive oil', '1 tbsp'),
                                 (m, 'Salt', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Bake sweet potato until soft.'),
                                  (m, 1, 'Bake salmon with olive oil and salt.'),
                                  (m, 2, 'Serve together.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Beef and Veggie Skillet', 'DINNER', 3, 5, 3, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'iron-rich');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Lean ground beef', '200 g'),
                                 (m, 'Bell pepper', '1/2'),
                                 (m, 'Onion', '1/2'),
                                 (m, 'Spinach', '1 cup'),
                                 (m, 'Olive oil', '1 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Brown beef in a pan.'),
                                  (m, 1, 'Add onion and pepper, cook until soft.'),
                                  (m, 2, 'Stir in spinach until wilted.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Chickpea Coconut Curry', 'DINNER', 5, 3, 5, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'vegetarian'), (m, 'anti-inflammatory');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Chickpeas', '1 can'),
                                 (m, 'Coconut milk', '1 cup'),
                                 (m, 'Curry powder', '1 tbsp'),
                                 (m, 'Spinach', '2 cups'),
                                 (m, 'Onion', '1/2');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Sauté onion with curry powder.'),
                                  (m, 1, 'Add chickpeas and coconut milk, simmer 10 min.'),
                                  (m, 2, 'Stir in spinach until wilted.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Turkey Meatballs with Tomato Sauce', 'DINNER', 3, 4, 3, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'high-protein');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Ground turkey', '250 g'),
                                 (m, 'Egg', '1'),
                                 (m, 'Tomato passata', '1 cup'),
                                 (m, 'Garlic', '1 clove'),
                                 (m, 'Olive oil', '1 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Mix turkey and egg, shape into meatballs.'),
                                  (m, 1, 'Brown meatballs in olive oil.'),
                                  (m, 2, 'Simmer in passata with garlic.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Shrimp Zucchini Noodles', 'DINNER', 4, 3, 3, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'low-carb'), (m, 'quick');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Shrimp', '200 g'),
                                 (m, 'Zucchini noodles', '2 cups'),
                                 (m, 'Garlic', '1 clove'),
                                 (m, 'Olive oil', '1 tbsp'),
                                 (m, 'Lemon juice', '1 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Cook shrimp in olive oil with garlic.'),
                                  (m, 1, 'Add zucchini noodles and toss briefly.'),
                                  (m, 2, 'Finish with lemon juice.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Baked Tofu with Roasted Veggies', 'DINNER', 4, 3, 4, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'vegetarian');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Tofu', '250 g'),
                                 (m, 'Broccoli', '2 cups'),
                                 (m, 'Carrots', '1 cup'),
                                 (m, 'Olive oil', '1 tbsp'),
                                 (m, 'Soy sauce', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Roast veggies with olive oil until tender.'),
                                  (m, 1, 'Bake tofu until firm.'),
                                  (m, 2, 'Drizzle soy sauce and serve.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'One-Pan Paprika Chicken', 'DINNER', 4, 4, 3, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'easy');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Chicken thighs', '2'),
                                 (m, 'Paprika', '1 tsp'),
                                 (m, 'Onion', '1/2'),
                                 (m, 'Bell pepper', '1/2'),
                                 (m, 'Olive oil', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Season chicken with paprika and salt.'),
                                  (m, 1, 'Cook chicken then add onion and pepper.'),
                                  (m, 2, 'Cook until veggies soften.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Lentil Bolognese', 'DINNER', 5, 4, 5, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'vegetarian'), (m, 'high-fiber');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked lentils', '2 cups'),
                                 (m, 'Tomato passata', '1.5 cups'),
                                 (m, 'Onion', '1/2'),
                                 (m, 'Garlic', '1 clove'),
                                 (m, 'Olive oil', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Sauté onion and garlic in olive oil.'),
                                  (m, 1, 'Add lentils and passata, simmer 10–15 min.'),
                                  (m, 2, 'Serve with pasta or zucchini noodles.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Beef Spinach Rice Bowl', 'DINNER', 3, 5, 3, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'iron-rich');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked rice', '1 cup'),
                                 (m, 'Lean beef strips', '180 g'),
                                 (m, 'Spinach', '2 cups'),
                                 (m, 'Olive oil', '1 tbsp'),
                                 (m, 'Salt', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Cook beef in olive oil until browned.'),
                                  (m, 1, 'Add spinach until wilted.'),
                                  (m, 2, 'Serve over rice.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Tomato Basil White Bean Stew', 'DINNER', 5, 4, 5, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'vegetarian'), (m, 'high-fiber');
INSERT INTO meal_ingredients VALUES
                                 (m, 'White beans', '1 can'),
                                 (m, 'Tomato passata', '1 cup'),
                                 (m, 'Basil', '2 tbsp'),
                                 (m, 'Garlic', '1 clove'),
                                 (m, 'Olive oil', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Sauté garlic in olive oil.'),
                                  (m, 1, 'Add passata and beans, simmer 10 min.'),
                                  (m, 2, 'Stir in basil and serve.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Baked Cod with Lemon and Greens', 'DINNER', 4, 4, 3, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'light');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cod', '180 g'),
                                 (m, 'Lemon juice', '1 tbsp'),
                                 (m, 'Olive oil', '1 tbsp'),
                                 (m, 'Spinach', '2 cups'),
                                 (m, 'Salt', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Bake cod with olive oil, salt, and lemon.'),
                                  (m, 1, 'Sauté spinach until wilted.'),
                                  (m, 2, 'Serve fish with greens.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Veggie Fried Rice (Egg)', 'DINNER', 3, 3, 3, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'quick');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked rice', '2 cups'),
                                 (m, 'Eggs', '2'),
                                 (m, 'Mixed veggies', '1.5 cups'),
                                 (m, 'Soy sauce', '1 tbsp'),
                                 (m, 'Olive oil', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Sauté veggies in olive oil.'),
                                  (m, 1, 'Add rice and soy sauce, stir-fry.'),
                                  (m, 2, 'Push aside and scramble eggs, then mix.');

--------------------------------------------------------------------
-- 4) SNACK (10)
--------------------------------------------------------------------
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Hummus and Carrot Sticks', 'SNACK', 4, 2, 4, now());
INSERT INTO meal_tags VALUES (m, 'snack'), (m, 'high-fiber'), (m, 'no-cook');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Hummus', '3 tbsp'),
                                 (m, 'Carrots', '2');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Wash and cut carrots into sticks.'),
                                  (m, 1, 'Serve with hummus.'),
                                  (m, 2, 'Eat immediately.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Apple with Almond Butter', 'SNACK', 3, 2, 3, now());
INSERT INTO meal_tags VALUES (m, 'snack'), (m, 'no-cook');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Apple', '1'),
                                 (m, 'Almond butter', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Slice apple.'),
                                  (m, 1, 'Serve with almond butter.'),
                                  (m, 2, 'Eat immediately.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Greek Yogurt Snack Cup', 'SNACK', 3, 2, 2, now());
INSERT INTO meal_tags VALUES (m, 'snack'), (m, 'high-protein');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Greek yogurt', '150 g'),
                                 (m, 'Honey', '1 tsp'),
                                 (m, 'Chia seeds', '1 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Spoon yogurt into a cup.'),
                                  (m, 1, 'Add honey.'),
                                  (m, 2, 'Sprinkle chia seeds.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Cucumber Tuna Bites', 'SNACK', 3, 3, 2, now());
INSERT INTO meal_tags VALUES (m, 'snack'), (m, 'high-protein');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cucumber', '1/2'),
                                 (m, 'Tuna', '1/2 can'),
                                 (m, 'Greek yogurt', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Slice cucumber into rounds.'),
                                  (m, 1, 'Mix tuna with yogurt.'),
                                  (m, 2, 'Top cucumber rounds with tuna mix.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Roasted Chickpeas (Quick)', 'SNACK', 4, 3, 4, now());
INSERT INTO meal_tags VALUES (m, 'snack'), (m, 'high-fiber');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Chickpeas', '1 can'),
                                 (m, 'Olive oil', '1 tbsp'),
                                 (m, 'Paprika', '1 tsp'),
                                 (m, 'Salt', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Rinse and dry chickpeas.'),
                                  (m, 1, 'Toss with olive oil, paprika, and salt.'),
                                  (m, 2, 'Bake at 200°C until crisp.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Trail Mix Cup', 'SNACK', 3, 2, 3, now());
INSERT INTO meal_tags VALUES (m, 'snack'), (m, 'no-cook');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Mixed nuts', '2 tbsp'),
                                 (m, 'Pumpkin seeds', '1 tbsp'),
                                 (m, 'Dried fruit', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Measure ingredients into a cup.'),
                                  (m, 1, 'Mix.'),
                                  (m, 2, 'Snack.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Boiled Eggs with Salt', 'SNACK', 2, 3, 0, now());
INSERT INTO meal_tags VALUES (m, 'snack'), (m, 'high-protein');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Eggs', '2'),
                                 (m, 'Salt', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Boil eggs until firm.'),
                                  (m, 1, 'Peel eggs.'),
                                  (m, 2, 'Season lightly with salt.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Edamame with Sea Salt', 'SNACK', 4, 3, 4, now());
INSERT INTO meal_tags VALUES (m, 'snack'), (m, 'high-fiber');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Edamame', '1 cup'),
                                 (m, 'Salt', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Boil or steam edamame.'),
                                  (m, 1, 'Drain.'),
                                  (m, 2, 'Sprinkle salt and serve.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Banana Cinnamon Snack', 'SNACK', 2, 1, 2, now());
INSERT INTO meal_tags VALUES (m, 'snack'), (m, 'no-cook');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Banana', '1'),
                                 (m, 'Cinnamon', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Peel banana.'),
                                  (m, 1, 'Sprinkle cinnamon.'),
                                  (m, 2, 'Eat.');

m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Tomato Mozzarella Snack Plate', 'SNACK', 3, 2, 1, now());
INSERT INTO meal_tags VALUES (m, 'snack'), (m, 'quick');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Tomatoes', '1'),
                                 (m, 'Mozzarella', '60 g'),
                                 (m, 'Olive oil', '1 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Slice tomato and mozzarella.'),
                                  (m, 1, 'Arrange on a plate.'),
                                  (m, 2, 'Drizzle olive oil.');

--------------------------------------------------------------------
-- 5) EXTRA MEALS to reach 50 total (14 more mixed)
--------------------------------------------------------------------
-- (These are simple but valid, and still have ingredients + instructions.)

-- 37
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Chicken Avocado Salad', 'LUNCH', 4, 4, 4, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'high-protein');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked chicken', '150 g'),
                                 (m, 'Avocado', '1/2'),
                                 (m, 'Lettuce', '2 cups'),
                                 (m, 'Olive oil', '1 tbsp'),
                                 (m, 'Lemon juice', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Chop chicken and avocado.'),
                                  (m, 1, 'Combine with lettuce.'),
                                  (m, 2, 'Dress with olive oil and lemon.');

-- 38
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Oat Banana Pancakes (2-Ingredient)', 'BREAKFAST', 3, 2, 3, now());
INSERT INTO meal_tags VALUES (m, 'breakfast'), (m, 'quick');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Banana', '1'),
                                 (m, 'Eggs', '2'),
                                 (m, 'Oats', '2 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Mash banana and whisk in eggs and oats.'),
                                  (m, 1, 'Cook small pancakes in a non-stick pan.'),
                                  (m, 2, 'Flip once and serve.');

-- 39
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Mackerel Potato Plate', 'DINNER', 4, 4, 3, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'omega-3');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Mackerel (canned)', '1 can'),
                                 (m, 'Potatoes', '2 small, boiled'),
                                 (m, 'Olive oil', '1 tsp'),
                                 (m, 'Lemon juice', '1 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Boil potatoes until soft.'),
                                  (m, 1, 'Plate with mackerel.'),
                                  (m, 2, 'Add olive oil and lemon.');

-- 40
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Bean Chili (Quick)', 'DINNER', 5, 4, 5, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'high-fiber'), (m, 'vegetarian');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Kidney beans', '1 can'),
                                 (m, 'Black beans', '1 can'),
                                 (m, 'Tomato passata', '1 cup'),
                                 (m, 'Chili powder', '1 tsp'),
                                 (m, 'Onion', '1/2');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Sauté onion.'),
                                  (m, 1, 'Add beans and passata with chili powder.'),
                                  (m, 2, 'Simmer 10–15 minutes.');

-- 41
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Sardine Rice Bowl', 'LUNCH', 4, 4, 3, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'quick');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked rice', '1 cup'),
                                 (m, 'Sardines', '1 can'),
                                 (m, 'Lemon juice', '1 tsp'),
                                 (m, 'Cucumber', '1/3');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Add rice to bowl.'),
                                  (m, 1, 'Top with sardines and cucumber.'),
                                  (m, 2, 'Finish with lemon juice.');

-- 42
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Tomato Egg Stir Fry', 'DINNER', 3, 3, 2, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'quick');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Eggs', '3'),
                                 (m, 'Tomatoes', '2'),
                                 (m, 'Olive oil', '1 tbsp'),
                                 (m, 'Salt', 'pinch');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Scramble eggs lightly and set aside.'),
                                  (m, 1, 'Cook tomatoes until saucy.'),
                                  (m, 2, 'Return eggs, stir and serve.');

-- 43
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Cinnamon Chia Pudding', 'SNACK', 4, 2, 4, now());
INSERT INTO meal_tags VALUES (m, 'snack'), (m, 'meal-prep');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Chia seeds', '2 tbsp'),
                                 (m, 'Milk (or oat milk)', '1 cup'),
                                 (m, 'Cinnamon', '1/2 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Mix chia, milk, and cinnamon.'),
                                  (m, 1, 'Refrigerate 2+ hours.'),
                                  (m, 2, 'Stir and eat.');

-- 44
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Cucumber Feta Salad', 'LUNCH', 4, 2, 3, now());
INSERT INTO meal_tags VALUES (m, 'lunch'), (m, 'vegetarian'), (m, 'quick');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cucumber', '1'),
                                 (m, 'Feta', '60 g'),
                                 (m, 'Olive oil', '1 tbsp'),
                                 (m, 'Lemon juice', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Dice cucumber.'),
                                  (m, 1, 'Crumble feta and combine.'),
                                  (m, 2, 'Dress with olive oil and lemon.');

-- 45
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Pea Soup (Quick)', 'DINNER', 4, 3, 4, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'easy');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Frozen peas', '2 cups'),
                                 (m, 'Vegetable stock', '2 cups'),
                                 (m, 'Onion', '1/2'),
                                 (m, 'Olive oil', '1 tbsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Sauté onion in olive oil.'),
                                  (m, 1, 'Add peas and stock, simmer 8–10 min.'),
                                  (m, 2, 'Blend until smooth.');

-- 46
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Oats with Cocoa and Banana', 'BREAKFAST', 3, 2, 4, now());
INSERT INTO meal_tags VALUES (m, 'breakfast');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Rolled oats', '1/2 cup'),
                                 (m, 'Milk or water', '1 cup'),
                                 (m, 'Cocoa powder', '1 tsp'),
                                 (m, 'Banana', '1/2');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Cook oats with milk/water.'),
                                  (m, 1, 'Stir in cocoa powder.'),
                                  (m, 2, 'Top with banana.');

-- 47
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Chicken Rice Soup', 'DINNER', 4, 4, 2, now());
INSERT INTO meal_tags VALUES (m, 'dinner');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked chicken', '120 g'),
                                 (m, 'Cooked rice', '1 cup'),
                                 (m, 'Chicken stock', '3 cups'),
                                 (m, 'Carrot', '1');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Simmer carrot in stock until soft.'),
                                  (m, 1, 'Add chicken and rice.'),
                                  (m, 2, 'Warm through and serve.');

-- 48
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Bean Tuna Salad', 'LUNCH', 4, 4, 4, now());
INSERT INTO meal_tags VALUES (m, 'lunch');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Tuna', '1 can'),
                                 (m, 'Kidney beans', '1/2 can'),
                                 (m, 'Lemon juice', '1 tbsp'),
                                 (m, 'Olive oil', '1 tsp');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Drain tuna and beans.'),
                                  (m, 1, 'Mix with lemon and olive oil.'),
                                  (m, 2, 'Serve.');

-- 49
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Avocado Yogurt Dip Plate', 'SNACK', 3, 2, 2, now());
INSERT INTO meal_tags VALUES (m, 'snack');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Avocado', '1/2'),
                                 (m, 'Greek yogurt', '2 tbsp'),
                                 (m, 'Cucumber', '1/2');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Mash avocado with yogurt.'),
                                  (m, 1, 'Slice cucumber.'),
                                  (m, 2, 'Use cucumber to scoop dip.');

-- 50
m := gen_random_uuid();
INSERT INTO meals VALUES (m, 'Simple Tomato Lentil Stew', 'DINNER', 5, 4, 5, now());
INSERT INTO meal_tags VALUES (m, 'dinner'), (m, 'high-fiber');
INSERT INTO meal_ingredients VALUES
                                 (m, 'Cooked lentils', '2 cups'),
                                 (m, 'Tomato passata', '1.5 cups'),
                                 (m, 'Olive oil', '1 tbsp'),
                                 (m, 'Garlic', '1 clove');
INSERT INTO meal_instructions VALUES
                                  (m, 0, 'Sauté garlic in olive oil.'),
                                  (m, 1, 'Add lentils and passata, simmer 10–15 min.'),
                                  (m, 2, 'Serve warm.');
END $$;
