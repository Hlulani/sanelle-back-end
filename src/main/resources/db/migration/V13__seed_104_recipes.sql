-- V13__seed_104_recipes.sql
-- Seeds 104 recipes with full content: ingredients, instructions, tags,
-- dietary tags, and the richer recipe-detail fields (why it helps, vegetable
-- substitutes, fresh-or-frozen guidance, color palette, prep time).

DO $$
DECLARE
m UUID;
BEGIN
  --------------------------------------------------------------------
  -- Turmeric Ginger Oatmeal with Berries and Walnuts (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Turmeric Ginger Oatmeal with Berries and Walnuts', 'BREAKFAST', 5, 2, 4,
    'Oats provide soluble fiber; berries are high in antioxidant polyphenols; turmeric/ginger are commonly used anti-inflammatory spices; walnuts supply omega-3 (ALA).', NULL, NULL, 'Golden oats, deep red-purple berries, tan walnuts', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'breakfast'), (m, 'dairy-free'), (m, 'omega-3'), (m, 'quick'), (m, 'vegan'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'can be vegan/dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Rolled oats', '1/2 cup'), (m, 'Water or plant milk', '1 cup'), (m, 'Turmeric', '1/2 tsp'), (m, 'Fresh ginger, grated', '1 tsp'), (m, 'Mixed berries', '1/2 cup'), (m, 'Walnuts', '2 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Simmer oats in water or plant milk over medium heat, stirring occasionally, for 5-7 minutes.'), (m, 1, 'Stir in turmeric and grated ginger during the last minute of cooking.'), (m, 2, 'Transfer to a bowl and top with berries and walnuts.');

  --------------------------------------------------------------------
  -- Greek Yogurt Parfait with Blueberries, Flaxseed, Honey (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Greek Yogurt Parfait with Blueberries, Flaxseed, Honey', 'BREAKFAST', 3, 1, 3,
    'Yogurt provides probiotics linked to gut and immune health; flaxseed adds omega-3 and lignans; blueberries are antioxidant-dense.', NULL, NULL, 'Bright white yogurt layered with deep blue-purple berries, flecked brown flaxseed', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Greek yogurt', '1 cup'), (m, 'Blueberries', '1/2 cup'), (m, 'Ground flaxseed', '1 tbsp'), (m, 'Honey', '1 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Spoon a third of the yogurt into a glass.'), (m, 1, 'Layer with a portion of blueberries and flaxseed.'), (m, 2, 'Repeat the layers until the glass is full.'), (m, 3, 'Drizzle honey on top before serving.');

  --------------------------------------------------------------------
  -- Spinach and Mushroom Omelet with Olive Oil (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Spinach and Mushroom Omelet with Olive Oil', 'BREAKFAST', 3, 3, 2,
    'Spinach is rich in vitamin K and antioxidants; olive oil supplies monounsaturated fat and oleocanthal, a compound with anti-inflammatory properties.', 'Spinach -> kale or Swiss chard; Mushrooms -> zucchini or eggplant', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted. Mushrooms: Fresh is recommended; mushrooms turn watery and rubbery when frozen.', 'Sunny yellow egg, dark green spinach, earthy brown mushrooms', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'gluten-free'), (m, 'quick'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Eggs', '2'), (m, 'Spinach', '1 cup'), (m, 'Mushrooms, sliced', '1/2 cup'), (m, 'Olive oil', '1 tsp'), (m, 'Salt', 'pinch'), (m, 'Radish, thinly sliced', '2-3 slices'), (m, 'Pomegranate seeds', '1 tsp'), (m, 'Microgreens', 'small handful');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Heat olive oil in a pan over medium heat and saute mushrooms for 2-3 minutes.'), (m, 1, 'Add spinach and cook until wilted, about 1 minute.'), (m, 2, 'Pour in whisked eggs and cook on low heat until just set.'), (m, 3, 'Fold the omelet and slide onto a plate.'), (m, 4, 'Top with radish, pomegranate seeds, and microgreens before serving.');

  --------------------------------------------------------------------
  -- Chia Seed Pudding with Mango and Coconut (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Chia Seed Pudding with Mango and Coconut', 'BREAKFAST', 3, 1, 4,
    'Chia seeds are a plant source of omega-3 (ALA) and fiber; mango contributes vitamin C and carotenoids.', NULL, NULL, 'Vivid orange mango over creamy white pudding, white coconut flakes', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'gluten-free'), (m, 'meal-prep'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free (needs overnight soak)');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chia seeds', '3 tbsp'), (m, 'Coconut milk', '1 cup'), (m, 'Mango, diced', '1/2 cup'), (m, 'Coconut flakes', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Stir chia seeds into coconut milk in a jar or bowl.'), (m, 1, 'Cover and refrigerate overnight, stirring once after 30 minutes if possible.'), (m, 2, 'Top with diced mango and coconut flakes before serving.');

  --------------------------------------------------------------------
  -- Avocado Toast on Whole Grain with Hemp Seeds (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Avocado Toast on Whole Grain with Hemp Seeds', 'BREAKFAST', 4, 1, 4,
    'Avocado provides monounsaturated fat; whole grains add fiber; hemp seeds contribute omega-3 and omega-6 in a favorable ratio; tomatoes add vitamin C and lycopene.', 'Tomato -> red bell pepper or sun-dried tomato', 'Tomato: Fresh is better for salads and raw preparations; frozen or canned diced tomato is fine in anything cooked (sauces, soups, stews).', 'Bright green avocado, red cherry tomato halves, golden-brown toast', 8,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Whole grain bread', '2 slices'), (m, 'Avocado', '1/2'), (m, 'Lemon juice', '1 tsp'), (m, 'Salt', 'pinch'), (m, 'Cherry tomatoes, halved', '6'), (m, 'Hemp seeds', '1 tbsp'), (m, 'Chili flakes', 'pinch');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Toast the bread.'), (m, 1, 'Mash avocado with lemon juice and salt.'), (m, 2, 'Spread avocado mixture onto the toast.'), (m, 3, 'Top with halved cherry tomatoes, hemp seeds, and a pinch of chili flakes.');

  --------------------------------------------------------------------
  -- Salmon and Avocado Breakfast Bowl (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Salmon and Avocado Breakfast Bowl', 'BREAKFAST', 5, 4, 3,
    'Salmon is a primary dietary source of long-chain omega-3s (EPA/DHA), the most studied anti-inflammatory fatty acids.', 'Cucumber -> zucchini or celery; Onion -> shallot or leek', 'Cucumber: Fresh only, cucumber breaks down and turns watery once frozen. Onion: Frozen diced onion works fine in any cooked dish; use fresh for raw uses like salads or garnish.', 'Deep pink-orange salmon, green avocado and cucumber, magenta pickled onion', 15,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'breakfast'), (m, 'dairy-free'), (m, 'gluten-free'), (m, 'iron-rich'), (m, 'omega-3');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Cooked quinoa', '3/4 cup'), (m, 'Salmon, cooked and flaked', '100 g'), (m, 'Avocado, sliced', '1/2'), (m, 'Cucumber, sliced', '1/4 cup'), (m, 'Pickled red onion', '1 tbsp'), (m, 'Sesame seeds', '1 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Spoon cooked quinoa into a bowl.'), (m, 1, 'Flake salmon over the quinoa.'), (m, 2, 'Arrange avocado and cucumber slices on top.'), (m, 3, 'Scatter pickled red onion and sesame seeds before serving.');

  --------------------------------------------------------------------
  -- Green Smoothie Bowl (Spinach, Pineapple, Ginger, Flaxseed) (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Green Smoothie Bowl (Spinach, Pineapple, Ginger, Flaxseed)', 'BREAKFAST', 4, 2, 4,
    'Pineapple contains bromelain, an enzyme studied for anti-inflammatory effects; spinach adds folate and antioxidants.', 'Spinach -> kale or Swiss chard', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted.', 'Vibrant green base, bright yellow pineapple, lime-green kiwi slices on top', 8,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'gluten-free'), (m, 'omega-3'), (m, 'quick'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Spinach', '1 cup'), (m, 'Frozen pineapple', '1 cup'), (m, 'Fresh ginger', '1 tsp'), (m, 'Ground flaxseed', '1 tbsp'), (m, 'Kiwi, sliced', '1'), (m, 'Granola', '2 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Blend spinach, frozen pineapple, ginger, and flaxseed with a small splash of water until thick and smooth.'), (m, 1, 'Pour into a bowl.'), (m, 2, 'Top with sliced kiwi and granola.');

  --------------------------------------------------------------------
  -- Sweet Potato and Black Bean Breakfast Hash (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Sweet Potato and Black Bean Breakfast Hash', 'BREAKFAST', 4, 3, 4,
    'Sweet potatoes provide beta-carotene; black beans add fiber and plant protein; bell peppers are high in vitamin C.', 'Sweet potato -> butternut squash or regular potato; Bell pepper -> poblano pepper or zucchini', 'Sweet potato: Both work. Frozen cubes or fries are convenient for roasting; fresh gives a better texture for rounds or slices you want to hold their shape. Bell pepper: Frozen sliced peppers work well in any cooked dish (stir-fries, curries, stews, roasting); use fresh if it needs to stay raw or crisp.', 'Orange sweet potato, red and yellow peppers, black beans, green cilantro, golden egg yolk', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'gluten-free'), (m, 'high-protein'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Sweet potato, diced', '1 cup'), (m, 'Black beans', '1/2 cup'), (m, 'Bell pepper, diced', '1/2'), (m, 'Olive oil', '1 tbsp'), (m, 'Egg', '1'), (m, 'Cilantro, chopped', '1 tbsp'), (m, 'Salt and pepper', 'to taste');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Roast diced sweet potato with a little olive oil at 200C/400F for 20 minutes, until tender.'), (m, 1, 'Heat remaining olive oil in a pan and saute bell pepper for 2-3 minutes.'), (m, 2, 'Add roasted sweet potato and black beans, cook until warmed through.'), (m, 3, 'Fry an egg in a separate pan to your preference.'), (m, 4, 'Top the hash with the fried egg and fresh cilantro.');

  --------------------------------------------------------------------
  -- Overnight Oats with Cinnamon, Walnuts, and Raspberries (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Overnight Oats with Cinnamon, Walnuts, and Raspberries', 'BREAKFAST', 4, 2, 4,
    'Cinnamon and raspberries add polyphenols; walnuts contribute omega-3; oats provide soluble fiber (beta-glucan).', NULL, NULL, 'Creamy oats, ruby-red raspberries and pomegranate jewels, warm brown walnuts', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'meal-prep'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan (with plant milk)');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Rolled oats', '1/2 cup'), (m, 'Milk or plant milk', '3/4 cup'), (m, 'Cinnamon', '1/2 tsp'), (m, 'Walnuts, chopped', '2 tbsp'), (m, 'Raspberries', '1/2 cup'), (m, 'Pomegranate seeds', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Combine oats, milk, and cinnamon in a jar.'), (m, 1, 'Stir well, cover, and refrigerate overnight.'), (m, 2, 'Top with walnuts, raspberries, and pomegranate seeds just before eating.');

  --------------------------------------------------------------------
  -- Turmeric Scrambled Eggs with Spinach and Roasted Tomatoes (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Turmeric Scrambled Eggs with Spinach and Roasted Tomatoes', 'BREAKFAST', 4, 3, 2,
    'Black pepper contains piperine, which research suggests improves absorption of curcumin (the active compound in turmeric).', 'Spinach -> kale or Swiss chard; Tomato -> red bell pepper or sun-dried tomato', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted. Tomato: Fresh is better for salads and raw preparations; frozen or canned diced tomato is fine in anything cooked (sauces, soups, stews).', 'Golden-yellow eggs, dark green spinach, blistered red tomatoes', 12,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'gluten-free'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Eggs', '2'), (m, 'Turmeric', '1/2 tsp'), (m, 'Black pepper', 'pinch'), (m, 'Spinach', '1 cup'), (m, 'Olive oil', '1 tsp'), (m, 'Cherry tomatoes', '6'), (m, 'Microgreens', 'small handful'), (m, 'Pomegranate seeds', '1 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Roast cherry tomatoes with a little olive oil at 200C/400F for 10 minutes.'), (m, 1, 'Whisk eggs with turmeric and black pepper.'), (m, 2, 'Heat olive oil in a pan and wilt spinach for 1 minute.'), (m, 3, 'Pour in the egg mixture and scramble gently until just set.'), (m, 4, 'Plate with roasted tomatoes, then finish with microgreens and pomegranate seeds.');

  --------------------------------------------------------------------
  -- Buckwheat Pancakes with Blueberry Compote (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Buckwheat Pancakes with Blueberry Compote', 'BREAKFAST', 4, 2, 3,
    'Buckwheat is a gluten-free whole grain containing rutin, a flavonoid antioxidant; blueberries add anthocyanins.', NULL, NULL, 'Deep purple-blue compote against golden pancakes, pale yellow banana', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'gluten-free'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Buckwheat flour', '1/2 cup'), (m, 'Egg', '1'), (m, 'Milk', '1/2 cup'), (m, 'Blueberries', '1/2 cup'), (m, 'Cinnamon', '1/4 tsp'), (m, 'Banana, sliced', '1/2');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Whisk buckwheat flour, egg, and milk into a smooth batter.'), (m, 1, 'Cook spoonfuls of batter on a lightly oiled pan over medium heat, about 2 minutes per side.'), (m, 2, 'Meanwhile, simmer blueberries with a splash of water and cinnamon for 5 minutes until saucy.'), (m, 3, 'Serve pancakes topped with blueberry compote and banana slices.');

  --------------------------------------------------------------------
  -- Anti-Inflammatory Golden Milk Smoothie Bowl (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Anti-Inflammatory Golden Milk Smoothie Bowl', 'BREAKFAST', 5, 1, 4,
    'Combines turmeric with healthy fats (coconut milk) which may improve curcumin absorption; banana adds potassium and prebiotic fiber.', NULL, NULL, 'Golden-orange base with a rainbow of mango, blueberry, and chia toppings', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'breakfast'), (m, 'gluten-free'), (m, 'omega-3'), (m, 'quick'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Frozen banana', '1'), (m, 'Coconut milk', '3/4 cup'), (m, 'Turmeric', '1/2 tsp'), (m, 'Cinnamon', '1/4 tsp'), (m, 'Chia seeds', '1 tsp'), (m, 'Mango, diced', '2 tbsp'), (m, 'Blueberries', '2 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Blend frozen banana, coconut milk, turmeric, and cinnamon until thick and smooth.'), (m, 1, 'Pour into a bowl.'), (m, 2, 'Arrange diced mango, blueberries, and chia seeds in rows on top.');

  --------------------------------------------------------------------
  -- Kefir Berry Smoothie with Flaxseed (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Kefir Berry Smoothie with Flaxseed', 'BREAKFAST', 3, 1, 3,
    'Kefir carries a broader range of probiotic strains than yogurt and has a thin, drinkable texture and sharper tang, which some people who dislike yogurt''s thickness or mouthfeel tolerate better; berries add antioxidants and banana adds potassium.', NULL, NULL, 'Pink-purple smoothie flecked with brown flax', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'gluten-free'), (m, 'omega-3'), (m, 'quick'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free (contains dairy)');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Kefir', '1 cup'), (m, 'Frozen mixed berries', '1/2 cup'), (m, 'Banana', '1/2'), (m, 'Ground flaxseed', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Combine kefir, frozen berries, banana, and flaxseed in a blender.'), (m, 1, 'Blend until smooth.'), (m, 2, 'If the tang is too strong, blend in a little extra banana or a splash of oat milk.');

  --------------------------------------------------------------------
  -- Silken Tofu Berry Parfait (Yogurt-Free) (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Silken Tofu Berry Parfait (Yogurt-Free)', 'BREAKFAST', 3, 2, 3,
    'Blended silken tofu gives a smooth, creamy parfait base with none of yogurt''s tang, for people who dislike yogurt''s taste or texture specifically rather than just avoiding dairy; still delivers a solid protein hit plus the same berries and flaxseed as the yogurt version.', NULL, NULL, 'Creamy white tofu base, deep blue-purple berries, brown flax flecks', 8,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'dairy-free'), (m, 'gluten-free'), (m, 'omega-3'), (m, 'quick'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Silken tofu', '1/2 cup'), (m, 'Maple syrup', '1 tsp'), (m, 'Vanilla extract', '1/4 tsp'), (m, 'Blueberries', '1/2 cup'), (m, 'Ground flaxseed', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Blend silken tofu with maple syrup and vanilla until completely smooth.'), (m, 1, 'Spoon a layer of the tofu mixture into a glass.'), (m, 2, 'Add a layer of blueberries and flaxseed.'), (m, 3, 'Repeat layers until the glass is full.');

  --------------------------------------------------------------------
  -- Turkey Sausage and Spinach Scramble (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Turkey Sausage and Spinach Scramble', 'BREAKFAST', 3, 3, 1,
    'Lean ground turkey provides protein with less saturated fat than pork sausage; eggs add complete protein; spinach contributes antioxidants and vitamin K.', 'Spinach -> kale or Swiss chard', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted.', 'Golden scrambled egg, browned turkey, dark green spinach', 15,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'dairy-free'), (m, 'gluten-free'), (m, 'high-protein');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Ground turkey sausage', '100 g'), (m, 'Olive oil', '1 tsp'), (m, 'Spinach', '1 cup'), (m, 'Eggs', '2');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Heat olive oil in a pan and brown the turkey sausage, breaking it into crumbles, about 5 minutes.'), (m, 1, 'Add spinach and cook until wilted.'), (m, 2, 'Pour in whisked eggs and scramble until just set.');

  --------------------------------------------------------------------
  -- Smoked Salmon and Avocado Toast with Everything Seasoning (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Smoked Salmon and Avocado Toast with Everything Seasoning', 'BREAKFAST', 5, 3, 3,
    'Smoked salmon is a ready-to-eat source of long-chain omega-3s (EPA/DHA); whole grain bread adds fiber; avocado contributes monounsaturated fat.', NULL, NULL, 'Deep pink-orange salmon, green avocado, golden toast', 8,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'breakfast'), (m, 'dairy-free'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Whole grain bread', '1 slice'), (m, 'Avocado', '1/2'), (m, 'Lemon juice', '1 tsp'), (m, 'Smoked salmon', '40 g'), (m, 'Everything bagel seasoning', '1/2 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Toast the bread.'), (m, 1, 'Mash avocado with lemon juice and spread onto the toast.'), (m, 2, 'Layer smoked salmon on top.'), (m, 3, 'Finish with a sprinkle of everything seasoning.');

  --------------------------------------------------------------------
  -- Soft-Boiled Eggs with Turmeric Roasted Asparagus (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Soft-Boiled Eggs with Turmeric Roasted Asparagus', 'BREAKFAST', 4, 3, 2,
    'Eggs provide complete protein and choline; asparagus adds fiber and antioxidant compounds; turmeric and black pepper pairing may aid curcumin absorption.', 'Asparagus -> green beans or broccolini', 'Asparagus: Fresh is better for texture, especially roasted; frozen asparagus goes soft and is more suited to soups.', 'Golden yolk, green asparagus', 12,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'dairy-free'), (m, 'gluten-free'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Asparagus', '8 spears'), (m, 'Olive oil', '1 tsp'), (m, 'Turmeric', '1/4 tsp'), (m, 'Black pepper', 'pinch'), (m, 'Eggs', '2');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Toss asparagus with olive oil, turmeric, and black pepper.'), (m, 1, 'Roast at 200C/400F for 10-12 minutes until tender.'), (m, 2, 'Meanwhile, soft-boil eggs for 6-7 minutes, then transfer to cold water.'), (m, 3, 'Peel and halve the eggs, serve alongside the roasted asparagus.');

  --------------------------------------------------------------------
  -- Chicken Sausage and Sweet Potato Breakfast Skillet (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Chicken Sausage and Sweet Potato Breakfast Skillet', 'BREAKFAST', 4, 3, 3,
    'Chicken sausage is leaner than traditional pork sausage; sweet potato adds beta-carotene; peppers add vitamin C.', 'Sweet potato -> butternut squash or regular potato; Bell pepper -> poblano pepper or zucchini', 'Sweet potato: Both work. Frozen cubes or fries are convenient for roasting; fresh gives a better texture for rounds or slices you want to hold their shape. Bell pepper: Frozen sliced peppers work well in any cooked dish (stir-fries, curries, stews, roasting); use fresh if it needs to stay raw or crisp.', 'Browned chicken sausage, orange sweet potato, red pepper, green spinach', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'dairy-free'), (m, 'gluten-free');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chicken sausage, sliced', '100 g'), (m, 'Sweet potato, diced', '1 cup'), (m, 'Bell pepper, diced', '1/2'), (m, 'Olive oil', '1 tbsp'), (m, 'Spinach', '1 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Heat olive oil in a skillet and brown the sliced chicken sausage, about 4 minutes.'), (m, 1, 'Add diced sweet potato and bell pepper, cook covered for 10-12 minutes, stirring occasionally, until tender.'), (m, 2, 'Stir in spinach and cook until just wilted.');

  --------------------------------------------------------------------
  -- Ham and Spinach Frittata Muffins (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Ham and Spinach Frittata Muffins', 'BREAKFAST', 2, 3, 1,
    'A portable, make-ahead source of protein combining eggs and lean ham with spinach for fiber and antioxidants.', 'Spinach -> kale or Swiss chard', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted.', 'Golden egg, pink ham flecks, green spinach', 25,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'gluten-free'), (m, 'meal-prep');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Eggs', '6'), (m, 'Lean deli ham, chopped', '1/2 cup'), (m, 'Spinach, chopped', '1 cup'), (m, 'Olive oil (for greasing)', '1 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 180C/350F and grease a 6-cup muffin tin with olive oil.'), (m, 1, 'Whisk eggs in a bowl, then stir in chopped ham and spinach.'), (m, 2, 'Divide the mixture evenly among the muffin cups.'), (m, 3, 'Bake for 18-20 minutes until set.'), (m, 4, 'Cool slightly before removing; makes 6 muffins. Refrigerate extras and reheat through the week.');

  --------------------------------------------------------------------
  -- Fried Egg Toast with Sauteed Greens, Radish, and Pomegranate (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Fried Egg Toast with Sauteed Greens, Radish, and Pomegranate', 'BREAKFAST', 4, 3, 3,
    'A fried egg on toast becomes a fuller plate once wilted greens, thin radish, and pomegranate are added; radish and microgreens contribute additional plant compounds beyond what a plain fried egg on toast would offer.', 'Spinach -> kale or Swiss chard; Kale -> spinach or collard greens', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted. Kale: Fresh is better, especially for raw or massaged-salad uses; frozen chopped kale exists but turns soft, only really suited to soups.', 'Golden fried egg, dark green sauteed greens, magenta-pink radish, ruby pomegranate, bright green microgreens', 15,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Whole grain sourdough bread', '1 slice'), (m, 'Olive oil', '1 tsp'), (m, 'Garlic, minced', '1/2 clove'), (m, 'Spinach or kale', '1 cup'), (m, 'Egg', '1'), (m, 'Radish, thinly sliced', '2-3 slices'), (m, 'Pomegranate seeds', '1 tsp'), (m, 'Microgreens', 'small handful'), (m, 'Chives, chopped', '1 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Heat olive oil in a pan and saute garlic for 30 seconds.'), (m, 1, 'Add greens and cook until wilted, then pile onto toasted sourdough.'), (m, 2, 'In the same pan, fry an egg to your preference.'), (m, 3, 'Place the fried egg on top of the greens.'), (m, 4, 'Finish with radish, pomegranate seeds, microgreens, and chives.');

  --------------------------------------------------------------------
  -- Chia Seed Pudding with Mango and Greek Yogurt (Non-Vegan Alt) (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Chia Seed Pudding with Mango and Greek Yogurt (Non-Vegan Alt)', 'BREAKFAST', 3, 1, 4,
    'Same chia and mango base as the vegan version, with whole milk and a swirl of Greek yogurt in place of coconut milk for a thicker, tangier pudding and added protein.', NULL, NULL, 'Vivid orange mango over creamy white pudding swirled with yogurt, white coconut flakes', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'gluten-free'), (m, 'meal-prep'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chia seeds', '3 tbsp'), (m, 'Whole milk', '1 cup'), (m, 'Greek yogurt', '2 tbsp'), (m, 'Mango, diced', '1/2 cup'), (m, 'Coconut flakes', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Stir chia seeds into whole milk in a jar.'), (m, 1, 'Cover and refrigerate overnight.'), (m, 2, 'Swirl in Greek yogurt before serving.'), (m, 3, 'Top with diced mango and coconut flakes.');

  --------------------------------------------------------------------
  -- Avocado Toast with Fried Egg and Feta (Non-Vegan Alt) (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Avocado Toast with Fried Egg and Feta (Non-Vegan Alt)', 'BREAKFAST', 4, 3, 3,
    'Same avocado toast base as the vegan version, with a fried egg and crumbled feta added for a substantial protein boost.', 'Tomato -> red bell pepper or sun-dried tomato', 'Tomato: Fresh is better for salads and raw preparations; frozen or canned diced tomato is fine in anything cooked (sauces, soups, stews).', 'Bright green avocado, golden fried egg, white feta, red cherry tomatoes', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'no-cook'), (m, 'quick'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Whole grain bread', '1 slice'), (m, 'Avocado', '1/2'), (m, 'Lemon juice', '1 tsp'), (m, 'Egg', '1'), (m, 'Feta, crumbled', '20 g'), (m, 'Cherry tomatoes, halved', '6'), (m, 'Chili flakes', 'pinch');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Toast the bread.'), (m, 1, 'Mash avocado with lemon juice and spread onto the toast.'), (m, 2, 'Fry the egg to your preference.'), (m, 3, 'Top toast with the fried egg and crumbled feta.'), (m, 4, 'Finish with halved cherry tomatoes and chili flakes.');

  --------------------------------------------------------------------
  -- Green Smoothie Bowl with Greek Yogurt (Non-Vegan Alt) (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Green Smoothie Bowl with Greek Yogurt (Non-Vegan Alt)', 'BREAKFAST', 4, 2, 3,
    'Greek yogurt in place of a purely plant base thickens the smoothie and adds a substantial protein boost alongside the same spinach and pineapple.', 'Spinach -> kale or Swiss chard', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted.', 'Vibrant green base, bright yellow pineapple, lime-green kiwi', 8,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'gluten-free'), (m, 'quick'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Spinach', '1 cup'), (m, 'Frozen pineapple', '1 cup'), (m, 'Fresh ginger', '1 tsp'), (m, 'Greek yogurt', '1/2 cup'), (m, 'Kiwi, sliced', '1'), (m, 'Granola', '2 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Blend spinach, frozen pineapple, ginger, and Greek yogurt until thick and smooth.'), (m, 1, 'Pour into a bowl.'), (m, 2, 'Top with sliced kiwi and granola.');

  --------------------------------------------------------------------
  -- Overnight Oats with Milk, Honey, Walnuts, and Raspberries (Non-Vegan Alt) (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Overnight Oats with Milk, Honey, Walnuts, and Raspberries (Non-Vegan Alt)', 'BREAKFAST', 4, 2, 4,
    'Whole milk and honey in place of plant milk and a vegan sweetener, keeping the same fiber and antioxidant profile from the oats, walnuts, and berries.', NULL, NULL, 'Creamy oats, ruby-red raspberries and pomegranate, warm brown walnuts', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'meal-prep'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Rolled oats', '1/2 cup'), (m, 'Whole milk', '3/4 cup'), (m, 'Honey', '1 tsp'), (m, 'Cinnamon', '1/2 tsp'), (m, 'Walnuts, chopped', '2 tbsp'), (m, 'Raspberries', '1/2 cup'), (m, 'Pomegranate seeds', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Combine oats, whole milk, honey, and cinnamon in a jar.'), (m, 1, 'Stir well, cover, and refrigerate overnight.'), (m, 2, 'Top with walnuts, raspberries, and pomegranate seeds before eating.');

  --------------------------------------------------------------------
  -- Golden Milk Smoothie Bowl with Dairy Milk and Honey (Non-Vegan Alt) (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Golden Milk Smoothie Bowl with Dairy Milk and Honey (Non-Vegan Alt)', 'BREAKFAST', 5, 1, 4,
    'Whole milk and honey stand in for coconut milk and a vegan sweetener; the fat in dairy milk still helps with curcumin absorption the same way coconut milk does.', NULL, NULL, 'Golden-orange base with mango, blueberry, and chia toppings', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'breakfast'), (m, 'gluten-free'), (m, 'omega-3'), (m, 'quick'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Frozen banana', '1'), (m, 'Whole milk', '3/4 cup'), (m, 'Turmeric', '1/2 tsp'), (m, 'Cinnamon', '1/4 tsp'), (m, 'Honey', '1 tsp'), (m, 'Chia seeds', '1 tsp'), (m, 'Mango, diced', '2 tbsp'), (m, 'Blueberries', '2 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Blend frozen banana, whole milk, turmeric, and cinnamon until thick and smooth.'), (m, 1, 'Sweeten with honey and blend briefly to combine.'), (m, 2, 'Pour into a bowl.'), (m, 3, 'Top with diced mango, blueberries, and chia seeds.');

  --------------------------------------------------------------------
  -- Cottage Cheese and Egg Scramble with Chives (BREAKFAST)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Cottage Cheese and Egg Scramble with Chives', 'BREAKFAST', 2, 3, 0,
    'Folding cottage cheese into scrambled eggs adds extra protein and a creamy texture without needing cream or extra cheese; a simple, high-protein start to the day.', NULL, NULL, 'Golden scrambled egg flecked with white cottage cheese and green chives', 8,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'breakfast'), (m, 'gluten-free'), (m, 'high-protein'), (m, 'no-cook'), (m, 'quick'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Eggs', '2'), (m, 'Cottage cheese', '2 tbsp'), (m, 'Black pepper', 'pinch'), (m, 'Olive oil', '1 tsp'), (m, 'Chives, chopped', '1 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Whisk eggs with cottage cheese and black pepper.'), (m, 1, 'Heat olive oil in a pan over low heat.'), (m, 2, 'Pour in the egg mixture and scramble gently until soft curds form.'), (m, 3, 'Finish with chopped chives.');

  --------------------------------------------------------------------
  -- Loaded Quinoa Power Salad with Chickpeas, Roasted Vegetables, and Feta (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Loaded Quinoa Power Salad with Chickpeas, Roasted Vegetables, and Feta', 'LUNCH', 5, 3, 5,
    'Quinoa is a complete-protein whole grain; chickpeas add fiber and plant protein; feta adds an additional protein/dairy boost; olive oil and turmeric-lemon dressing supply healthy fat and polyphenols.', 'Bell pepper -> poblano pepper or zucchini; Cucumber -> zucchini or celery', 'Bell pepper: Frozen sliced peppers work well in any cooked dish (stir-fries, curries, stews, roasting); use fresh if it needs to stay raw or crisp. Cucumber: Fresh only, cucumber breaks down and turns watery once frozen.', 'Golden quinoa, red roasted pepper, green cucumber, white feta crumbles', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'lunch'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Cooked quinoa', '3/4 cup'), (m, 'Chickpeas', '1/2 cup'), (m, 'Roasted red pepper, sliced', '1/4 cup'), (m, 'Cucumber, diced', '1/2 cup'), (m, 'Feta, crumbled', '30 g'), (m, 'Olive oil', '1 tbsp'), (m, 'Lemon juice', '1 tbsp'), (m, 'Turmeric', '1/4 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Combine cooked quinoa, chickpeas, roasted red pepper, and cucumber in a bowl.'), (m, 1, 'Whisk olive oil, lemon juice, and turmeric together for the dressing.'), (m, 2, 'Pour dressing over the salad and toss to combine.'), (m, 3, 'Top with crumbled feta before serving.');

  --------------------------------------------------------------------
  -- Grilled Salmon Salad with Sweet Potato, Mixed Greens, and Walnuts (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Grilled Salmon Salad with Sweet Potato, Mixed Greens, and Walnuts', 'LUNCH', 5, 4, 4,
    'Combines EPA/DHA from salmon with ALA from walnuts and polyphenols from leafy greens; roasted sweet potato adds substance and beta-carotene so the salad eats like a full meal.', 'Sweet potato -> butternut squash or regular potato; Mixed greens -> baby spinach or arugula', 'Sweet potato: Both work. Frozen cubes or fries are convenient for roasting; fresh gives a better texture for rounds or slices you want to hold their shape. Mixed greens: Fresh only, salad greens don''t freeze.', 'Deep orange salmon and sweet potato, dark leafy greens, tan walnuts', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'dairy-free'), (m, 'gluten-free'), (m, 'iron-rich'), (m, 'lunch'), (m, 'omega-3');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Salmon fillet', '150 g'), (m, 'Sweet potato, diced and roasted', '1/2 cup'), (m, 'Mixed greens', '2 cups'), (m, 'Walnuts', '2 tbsp'), (m, 'Olive oil', '1 tbsp'), (m, 'Lemon juice', '1 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Grill or pan-sear the salmon fillet, about 4 minutes per side.'), (m, 1, 'Toss mixed greens with olive oil and lemon juice.'), (m, 2, 'Arrange greens on a plate, top with roasted sweet potato and walnuts.'), (m, 3, 'Place the salmon on top and serve.');

  --------------------------------------------------------------------
  -- Lentil Soup with Turmeric and Ginger (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Lentil Soup with Turmeric and Ginger', 'LUNCH', 5, 4, 5,
    'Lentils are high in fiber and plant protein; turmeric and ginger are traditional anti-inflammatory spices used in many cuisines.', 'Carrot -> parsnip or sweet potato; Onion -> shallot or leek', 'Carrot: Both work. Frozen sliced or diced carrot is fine in soups, stews, and curries; fresh is better for raw or roasted dishes where texture matters. Onion: Frozen diced onion works fine in any cooked dish; use fresh for raw uses like salads or garnish.', 'Golden-orange broth, orange carrots, green parsley garnish', 30,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'iron-rich'), (m, 'lunch'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Lentils', '1/2 cup'), (m, 'Onion, diced', '1/4'), (m, 'Carrot, diced', '1/2'), (m, 'Fresh ginger, grated', '1 tsp'), (m, 'Turmeric', '1/2 tsp'), (m, 'Vegetable broth', '2 cups'), (m, 'Parsley, chopped', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Saute onion, carrot, and ginger in a pot over medium heat for 3-4 minutes.'), (m, 1, 'Add lentils, turmeric, and broth.'), (m, 2, 'Simmer for 20-25 minutes, until lentils are soft.'), (m, 3, 'Finish with chopped parsley before serving.');

  --------------------------------------------------------------------
  -- Mediterranean Loaded Chickpea Salad with Grilled Chicken and Feta (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Mediterranean Loaded Chickpea Salad with Grilled Chicken and Feta', 'LUNCH', 4, 3, 4,
    'Reflects a Mediterranean-style eating pattern, associated in observational research with lower inflammatory markers; grilled chicken and feta add substantial protein so this reads as a full meal.', 'Tomato -> red bell pepper or sun-dried tomato; Cucumber -> zucchini or celery', 'Tomato: Fresh is better for salads and raw preparations; frozen or canned diced tomato is fine in anything cooked (sauces, soups, stews). Cucumber: Fresh only, cucumber breaks down and turns watery once frozen.', 'Red tomato, green cucumber, purple red onion, white feta against golden chicken', 15,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'high-protein'), (m, 'lunch');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chickpeas', '1/2 cup'), (m, 'Grilled chicken breast, sliced', '100 g'), (m, 'Tomato, diced', '1/2 cup'), (m, 'Cucumber, diced', '1/2 cup'), (m, 'Red onion, sliced', '2 tbsp'), (m, 'Olive oil', '1 tbsp'), (m, 'Lemon juice', '1 tbsp'), (m, 'Feta, crumbled', '30 g'), (m, 'Parsley, chopped', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Combine chickpeas, tomato, cucumber, and red onion in a bowl.'), (m, 1, 'Dress with olive oil, lemon juice, and parsley.'), (m, 2, 'Top with sliced grilled chicken and crumbled feta.');

  --------------------------------------------------------------------
  -- Kale and White Bean Salad with Roasted Sweet Potato and Soft Egg (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Kale and White Bean Salad with Roasted Sweet Potato and Soft Egg', 'LUNCH', 5, 3, 5,
    'Kale is dense in vitamin K and antioxidants; massaging with olive oil and lemon softens the leaves; white beans and a soft egg add enough protein and heft to make this a standalone meal.', 'Kale -> spinach or collard greens; Sweet potato -> butternut squash or regular potato', 'Kale: Fresh is better, especially for raw or massaged-salad uses; frozen chopped kale exists but turns soft, only really suited to soups. Sweet potato: Both work. Frozen cubes or fries are convenient for roasting; fresh gives a better texture for rounds or slices you want to hold their shape.', 'Dark green kale, orange sweet potato, golden egg yolk', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'high-protein'), (m, 'lunch'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Kale, chopped', '2 cups'), (m, 'Olive oil', '1 tbsp'), (m, 'Lemon juice', '1 tbsp'), (m, 'White beans', '1/2 cup'), (m, 'Sweet potato, diced and roasted', '1/2 cup'), (m, 'Egg', '1');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Massage chopped kale with olive oil and lemon juice for 1-2 minutes until softened.'), (m, 1, 'Toss in white beans and roasted sweet potato.'), (m, 2, 'Soft-boil the egg for 6-7 minutes, then halve.'), (m, 3, 'Top the salad with the soft-boiled egg.');

  --------------------------------------------------------------------
  -- Turkey and Avocado Wrap on Whole Grain Tortilla with Roasted Peppers (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Turkey and Avocado Wrap on Whole Grain Tortilla with Roasted Peppers', 'LUNCH', 3, 3, 3,
    'Lean turkey provides protein without the saturated fat load of processed or fatty red meats; avocado adds healthy fat.', 'Spinach -> kale or Swiss chard; Bell pepper -> poblano pepper or zucchini', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted. Bell pepper: Frozen sliced peppers work well in any cooked dish (stir-fries, curries, stews, roasting); use fresh if it needs to stay raw or crisp.', 'Red roasted pepper, green avocado and spinach, warm tortilla', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'lunch'), (m, 'quick');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Whole grain tortilla', '1'), (m, 'Turkey breast, sliced', '80 g'), (m, 'Avocado, mashed', '1/2'), (m, 'Spinach', '1/2 cup'), (m, 'Roasted red pepper, sliced', '1/4 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Spread mashed avocado over the tortilla.'), (m, 1, 'Layer sliced turkey, spinach, and roasted red pepper on top.'), (m, 2, 'Roll the tortilla tightly, tucking in the sides.'), (m, 3, 'Slice in half to serve.');

  --------------------------------------------------------------------
  -- Roasted Vegetable and Farro Bowl with Chickpeas and Tahini (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Roasted Vegetable and Farro Bowl with Chickpeas and Tahini', 'LUNCH', 4, 3, 5,
    'Farro is a fiber-rich whole grain; roasted vegetables retain antioxidants; chickpeas and tahini add plant protein and healthy fat.', 'Zucchini -> yellow squash or eggplant; Bell pepper -> poblano pepper or zucchini', 'Zucchini: Fresh is better, since zucchini gets watery when frozen; frozen is still fine in soups or blended dishes. Bell pepper: Frozen sliced peppers work well in any cooked dish (stir-fries, curries, stews, roasting); use fresh if it needs to stay raw or crisp.', 'Red and yellow peppers, green zucchini, golden chickpeas, cream tahini drizzle', 30,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'high-fiber'), (m, 'lunch'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Farro, cooked', '3/4 cup'), (m, 'Zucchini, diced', '1/2 cup'), (m, 'Bell pepper, diced', '1/2 cup'), (m, 'Chickpeas', '1/2 cup'), (m, 'Olive oil', '1 tbsp'), (m, 'Tahini', '1 tbsp'), (m, 'Fresh herbs, chopped', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Toss zucchini, bell pepper, and chickpeas with olive oil.'), (m, 1, 'Roast at 200C/400F for 20 minutes, until vegetables are tender.'), (m, 2, 'Spoon cooked farro into a bowl and top with the roasted vegetables and chickpeas.'), (m, 3, 'Drizzle with tahini and finish with fresh herbs.');

  --------------------------------------------------------------------
  -- Sardine and Arugula Salad with White Beans and Olive Oil (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Sardine and Arugula Salad with White Beans and Olive Oil', 'LUNCH', 5, 4, 4,
    'Sardines are a low-mercury, high omega-3 fish option; white beans add fiber and additional plant protein so the salad is filling; arugula and tomatoes add antioxidants.', 'Arugula -> baby spinach or watercress; Tomato -> red bell pepper or sun-dried tomato', 'Arugula: Fresh only, salad greens don''t freeze. Tomato: Fresh is better for salads and raw preparations; frozen or canned diced tomato is fine in anything cooked (sauces, soups, stews).', 'Silver-pink sardines, peppery dark green arugula, red cherry tomatoes', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'dairy-free'), (m, 'gluten-free'), (m, 'high-protein'), (m, 'iron-rich'), (m, 'lunch'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Canned sardines', '1 can (about 90 g)'), (m, 'Arugula', '2 cups'), (m, 'White beans', '1/2 cup'), (m, 'Cherry tomatoes, halved', '6'), (m, 'Olive oil', '1 tbsp'), (m, 'Lemon juice', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Combine arugula, white beans, and halved cherry tomatoes in a bowl.'), (m, 1, 'Add sardines on top.'), (m, 2, 'Dress with olive oil and lemon juice, then toss gently.');

  --------------------------------------------------------------------
  -- Sweet Potato, Black Bean, and Grilled Chicken Buddha Bowl (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Sweet Potato, Black Bean, and Grilled Chicken Buddha Bowl', 'LUNCH', 4, 3, 5,
    'Combines a fiber-rich whole grain, legumes, and beta-carotene-rich sweet potato with grilled chicken for a complete, substantial meal.', 'Sweet potato -> butternut squash or regular potato; Red cabbage -> green cabbage or shredded carrot', 'Sweet potato: Both work. Frozen cubes or fries are convenient for roasting; fresh gives a better texture for rounds or slices you want to hold their shape. Red cabbage: Fresh is better for crunch in a salad; frozen shredded cabbage exists but only really works in cooked dishes.', 'Orange sweet potato, black beans, green avocado, magenta red cabbage', 25,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'high-protein'), (m, 'lunch');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Sweet potato, diced and roasted', '1 cup'), (m, 'Brown rice, cooked', '3/4 cup'), (m, 'Black beans', '1/2 cup'), (m, 'Grilled chicken, sliced', '100 g'), (m, 'Avocado, sliced', '1/2'), (m, 'Red cabbage, shredded', '1/4 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Spoon cooked brown rice into a bowl.'), (m, 1, 'Arrange roasted sweet potato, black beans, and sliced grilled chicken on top.'), (m, 2, 'Add avocado slices and shredded red cabbage.'), (m, 3, 'Serve warm.');

  --------------------------------------------------------------------
  -- Miso Ginger Soup with Tofu, Bok Choy, and Soba Noodles (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Miso Ginger Soup with Tofu, Bok Choy, and Soba Noodles', 'LUNCH', 4, 3, 3,
    'Miso is a fermented food linked to gut health; ginger and bok choy add anti-inflammatory compounds and vitamin C; soba noodles make this a full meal rather than a starter soup.', 'Bok choy -> napa cabbage or Swiss chard', 'Bok choy: Fresh is better; frozen bok choy goes soft, more suited to soups than a quick saute.', 'Pale golden broth, white tofu, bright green bok choy and scallion', 15,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'lunch'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free (check miso and soba labels)');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Vegetable broth', '2 cups'), (m, 'Fresh ginger, grated', '1 tsp'), (m, 'Firm tofu, diced', '1/2 cup'), (m, 'Bok choy, chopped', '1 cup'), (m, 'Soba noodles, cooked', '1/2 cup'), (m, 'Miso paste', '1 tbsp'), (m, 'Scallion, sliced', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Simmer broth with ginger for 5 minutes.'), (m, 1, 'Add tofu, bok choy, and cooked soba noodles, and simmer for 2-3 minutes.'), (m, 2, 'Remove from heat and stir in miso paste until dissolved.'), (m, 3, 'Top with sliced scallion before serving.');

  --------------------------------------------------------------------
  -- Grilled Chicken and Broccoli Bowl with Turmeric Rice (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Grilled Chicken and Broccoli Bowl with Turmeric Rice', 'LUNCH', 4, 2, 4,
    'Broccoli contains sulforaphane, a compound studied for antioxidant activity; turmeric rice adds curcumin.', 'Broccoli -> cauliflower or Brussels sprouts; Carrot -> parsnip or sweet potato', 'Broccoli: Frozen works very well, especially steamed or in stir-fries; fresh gives a firmer texture if you''re roasting it. Carrot: Both work. Frozen sliced or diced carrot is fine in soups, stews, and curries; fresh is better for raw or roasted dishes where texture matters.', 'Golden turmeric rice, deep green broccoli, orange shredded carrot', 25,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'gluten-free'), (m, 'lunch');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chicken breast', '120 g'), (m, 'Broccoli florets', '1 cup'), (m, 'Brown rice, cooked', '3/4 cup'), (m, 'Turmeric', '1/4 tsp'), (m, 'Carrot, shredded', '2 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Grill or pan-sear the chicken breast until cooked through, about 6 minutes per side.'), (m, 1, 'Steam broccoli florets for 4-5 minutes until tender.'), (m, 2, 'Stir turmeric through the cooked brown rice.'), (m, 3, 'Slice the chicken and serve over the turmeric rice with broccoli and shredded carrot.');

  --------------------------------------------------------------------
  -- Beet, Walnut, and Chickpea Salad with Goat Cheese (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Beet, Walnut, and Chickpea Salad with Goat Cheese', 'LUNCH', 5, 3, 4,
    'Beets contain betalains and nitrates studied for antioxidant properties; walnuts add omega-3; chickpeas boost the protein and fiber so this eats as a main, not a starter.', 'Beets -> carrots or radishes; Mixed greens -> baby spinach or arugula', 'Beets: Fresh, or pre-cooked vacuum-packed beets, is standard; frozen beets are uncommon and not necessary here. Mixed greens: Fresh only, salad greens don''t freeze.', 'Deep magenta-red beets, white goat cheese, tan walnuts, dark greens', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'gluten-free'), (m, 'high-protein'), (m, 'lunch'), (m, 'omega-3'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Beets, roasted and sliced', '1/2 cup'), (m, 'Mixed greens', '2 cups'), (m, 'Walnuts', '2 tbsp'), (m, 'Chickpeas', '1/2 cup'), (m, 'Goat cheese, crumbled', '30 g'), (m, 'Orange segments', '1/4 cup'), (m, 'Olive oil', '1 tbsp'), (m, 'Lemon juice', '1 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Arrange mixed greens on a plate.'), (m, 1, 'Top with roasted beet slices, chickpeas, and orange segments.'), (m, 2, 'Scatter walnuts and crumbled goat cheese on top.'), (m, 3, 'Drizzle with olive oil and lemon juice before serving.');

  --------------------------------------------------------------------
  -- Chickpea and Spinach Curry with Brown Rice (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Chickpea and Spinach Curry with Brown Rice', 'LUNCH', 5, 3, 5,
    'Legumes and leafy greens combined with turmeric-based curry spices, a pattern common in traditional anti-inflammatory diets.', 'Spinach -> kale or Swiss chard; Tomato -> red bell pepper or sun-dried tomato', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted. Tomato: Fresh is better for salads and raw preparations; frozen or canned diced tomato is fine in anything cooked (sauces, soups, stews).', 'Golden-orange curry, dark green spinach, red cherry tomato pieces', 25,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'lunch'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chickpeas', '1 cup'), (m, 'Spinach', '1 cup'), (m, 'Cherry tomatoes, halved', '1/2 cup'), (m, 'Coconut milk', '1/2 cup'), (m, 'Turmeric', '1/2 tsp'), (m, 'Cumin', '1/4 tsp'), (m, 'Brown rice, cooked', '3/4 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Simmer chickpeas, cherry tomatoes, coconut milk, turmeric, and cumin in a pan for 8-10 minutes.'), (m, 1, 'Stir in spinach and cook until wilted, about 2 minutes.'), (m, 2, 'Serve over cooked brown rice.');

  --------------------------------------------------------------------
  -- Grilled Chicken and Kale Bowl with Lemon-Anchovy Dressing (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Grilled Chicken and Kale Bowl with Lemon-Anchovy Dressing', 'LUNCH', 4, 3, 2,
    'A Caesar-inspired bowl using grilled chicken for lean protein and kale in place of romaine for more fiber and vitamin K; anchovies add omega-3s.', 'Kale -> spinach or collard greens', 'Kale: Fresh is better, especially for raw or massaged-salad uses; frozen chopped kale exists but turns soft, only really suited to soups.', 'Golden chicken, dark green kale, pale parmesan shavings', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'lunch');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chicken breast', '120 g'), (m, 'Kale, chopped', '2 cups'), (m, 'Olive oil', '2 tbsp'), (m, 'Lemon juice', '1 tbsp'), (m, 'Anchovy fillet, mashed', '1'), (m, 'Parmesan, shaved', '15 g');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Grill or pan-sear the chicken breast until cooked through, about 6 minutes per side.'), (m, 1, 'Massage chopped kale with 1 tablespoon of olive oil and half the lemon juice.'), (m, 2, 'Whisk remaining olive oil, lemon juice, and mashed anchovy for the dressing.'), (m, 3, 'Slice the chicken and place over the kale.'), (m, 4, 'Drizzle with dressing and top with shaved parmesan.');

  --------------------------------------------------------------------
  -- Tuna and White Bean Salad with Olive Oil (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Tuna and White Bean Salad with Olive Oil', 'LUNCH', 4, 3, 4,
    'Tuna is a convenient source of lean protein and omega-3s; white beans add fiber and additional plant protein for a filling lunch.', 'Onion -> shallot or leek', 'Onion: Frozen diced onion works fine in any cooked dish; use fresh for raw uses like salads or garnish.', 'Pale tuna and beans, purple-red onion, green parsley', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'gluten-free'), (m, 'high-protein'), (m, 'lunch'), (m, 'no-cook'), (m, 'quick');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Canned tuna, drained', '1 can (about 120 g)'), (m, 'White beans', '1/2 cup'), (m, 'Red onion, thinly sliced', '2 tbsp'), (m, 'Parsley, chopped', '1 tbsp'), (m, 'Olive oil', '1 tbsp'), (m, 'Lemon juice', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Combine drained tuna, white beans, red onion, and parsley in a bowl.'), (m, 1, 'Dress with olive oil and lemon juice.'), (m, 2, 'Toss gently to combine and serve.');

  --------------------------------------------------------------------
  -- Shrimp and Avocado Rice Bowl with Lime (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Shrimp and Avocado Rice Bowl with Lime', 'LUNCH', 3, 2, 3,
    'Shrimp is a lean, low-calorie protein; avocado adds healthy fat; brown rice provides fiber for a balanced, filling bowl.', 'Cucumber -> zucchini or celery', 'Cucumber: Fresh only, cucumber breaks down and turns watery once frozen.', 'Pink-orange shrimp, green avocado and cucumber, white rice', 15,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'gluten-free'), (m, 'lunch');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Shrimp, peeled', '150 g'), (m, 'Olive oil', '1 tsp'), (m, 'Lime juice', '1 tbsp'), (m, 'Brown rice, cooked', '3/4 cup'), (m, 'Avocado, diced', '1/2'), (m, 'Cucumber, diced', '1/2 cup'), (m, 'Cilantro, chopped', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Saute shrimp in olive oil with half the lime juice until pink and cooked through, about 4 minutes.'), (m, 1, 'Spoon cooked brown rice into a bowl.'), (m, 2, 'Top with shrimp, diced avocado, and cucumber.'), (m, 3, 'Finish with cilantro and remaining lime juice.');

  --------------------------------------------------------------------
  -- Roasted Beet, Orange, and Avocado Salad with Feta and Walnuts (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Roasted Beet, Orange, and Avocado Salad with Feta and Walnuts', 'LUNCH', 5, 2, 4,
    'Pairing roasted beets with citrus and avocado works because the acidity in the orange cuts through the earthiness of the beet; feta and walnuts add the protein and healthy fat needed to make this a full lunch rather than a side salad.', 'Beets -> carrots or radishes; Onion -> shallot or leek', 'Beets: Fresh, or pre-cooked vacuum-packed beets, is standard; frozen beets are uncommon and not necessary here. Onion: Frozen diced onion works fine in any cooked dish; use fresh for raw uses like salads or garnish.', 'Magenta-red beets, bright orange segments, green avocado, white feta, purple-red onion', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'gluten-free'), (m, 'lunch'), (m, 'omega-3'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Mixed greens', '2 cups'), (m, 'Beets, roasted and sliced', '1/2 cup'), (m, 'Orange segments', '1/2 cup'), (m, 'Avocado, sliced', '1/2'), (m, 'Red onion, thinly sliced', '2 tbsp'), (m, 'Olive oil', '1 tbsp'), (m, 'Apple cider vinegar', '1 tsp'), (m, 'Honey', '1/2 tsp'), (m, 'Feta, crumbled', '30 g'), (m, 'Walnuts, toasted', '2 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Lay mixed greens in a wide bowl.'), (m, 1, 'Arrange roasted beet slices, orange segments, and avocado wedges on top.'), (m, 2, 'Scatter thin red onion over the salad.'), (m, 3, 'Whisk olive oil, apple cider vinegar, and honey, then drizzle over the salad.'), (m, 4, 'Finish with crumbled feta and toasted walnuts.');

  --------------------------------------------------------------------
  -- Cucumber, Red Onion, and Corn Salad with Herbed Yogurt Dressing (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Cucumber, Red Onion, and Corn Salad with Herbed Yogurt Dressing', 'LUNCH', 3, 1, 2,
    'A light, creamy dressing built mostly on yogurt rather than a heavier mayonnaise-based one keeps this closer to the rest of the set''s nutrition profile while still tasting rich; corn and cucumber add crunch and hydration.', 'Cucumber -> zucchini or celery; Onion -> shallot or leek', 'Cucumber: Fresh only, cucumber breaks down and turns watery once frozen. Onion: Frozen diced onion works fine in any cooked dish; use fresh for raw uses like salads or garnish.', 'Green cucumber, purple-red onion, golden corn, green dill and mint', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'lunch'), (m, 'no-cook'), (m, 'quick'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Cucumber, thinly sliced', '1 cup'), (m, 'Red onion, thinly sliced', '2 tbsp'), (m, 'Corn kernels', '1/2 cup'), (m, 'Plain yogurt', '1/4 cup'), (m, 'Mayonnaise', '1 tsp'), (m, 'Mustard', '1/2 tsp'), (m, 'Olive oil', '1 tsp'), (m, 'Lemon juice', '1 tsp'), (m, 'Fresh mint, chopped', '1 tsp'), (m, 'Dill, chopped', '1 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Combine cucumber, red onion, and corn in a bowl.'), (m, 1, 'Whisk yogurt, mayonnaise, mustard, olive oil, lemon juice, mint, and dill for the dressing.'), (m, 2, 'Toss the dressing through the vegetables just before serving.');

  --------------------------------------------------------------------
  -- Grilled Peach, Burrata, and Tomato Salad with Basil and Pistachios (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Grilled Peach, Burrata, and Tomato Salad with Basil and Pistachios', 'LUNCH', 3, 1, 2,
    'Grilling the peaches concentrates their sweetness against the acidity of the tomatoes; burrata adds a substantial, creamy protein and fat source that makes this a full lunch rather than a fruit salad.', 'Tomato -> red bell pepper or sun-dried tomato; Arugula -> baby spinach or watercress', 'Tomato: Fresh is better for salads and raw preparations; frozen or canned diced tomato is fine in anything cooked (sauces, soups, stews). Arugula: Fresh only, salad greens don''t freeze.', 'Charred orange-yellow peach, creamy white burrata, red cherry tomatoes, dark green arugula', 15,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'lunch'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Peaches, halved', '2'), (m, 'Arugula or spinach', '2 cups'), (m, 'Cherry tomatoes, halved', '1/2 cup'), (m, 'Olive oil', '1 tbsp'), (m, 'Burrata', '100 g'), (m, 'Basil leaves, torn', '2 tbsp'), (m, 'Pistachios, toasted and chopped', '2 tbsp'), (m, 'Balsamic glaze', '1 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Grill peach halves cut-side down for 2-3 minutes until charred, then let cool slightly and slice.'), (m, 1, 'Toss greens with cherry tomatoes and olive oil.'), (m, 2, 'Arrange peaches and torn burrata on top of the greens.'), (m, 3, 'Scatter basil and pistachios over the salad.'), (m, 4, 'Finish with a drizzle of balsamic glaze.');

  --------------------------------------------------------------------
  -- Chicken and Lentil Soup with Turmeric and Ginger (Non-Vegan Alt) (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Chicken and Lentil Soup with Turmeric and Ginger (Non-Vegan Alt)', 'LUNCH', 5, 4, 5,
    'Shredded chicken added to the same lentil, turmeric, and ginger base for extra protein and a heartier bowl.', 'Carrot -> parsnip or sweet potato; Onion -> shallot or leek', 'Carrot: Both work. Frozen sliced or diced carrot is fine in soups, stews, and curries; fresh is better for raw or roasted dishes where texture matters. Onion: Frozen diced onion works fine in any cooked dish; use fresh for raw uses like salads or garnish.', 'Golden-orange broth, orange carrots, shredded chicken, green parsley', 30,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'dairy-free'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'high-protein'), (m, 'iron-rich'), (m, 'lunch');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Lentils', '1/2 cup'), (m, 'Onion, diced', '1/4'), (m, 'Carrot, diced', '1/2'), (m, 'Fresh ginger, grated', '1 tsp'), (m, 'Turmeric', '1/2 tsp'), (m, 'Vegetable broth', '2 cups'), (m, 'Cooked chicken, shredded', '1/2 cup'), (m, 'Parsley, chopped', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Saute onion, carrot, and ginger in a pot for 3-4 minutes.'), (m, 1, 'Add lentils, turmeric, and broth, and simmer for 20-25 minutes until lentils are soft.'), (m, 2, 'Stir in shredded cooked chicken and warm through, about 2 minutes.'), (m, 3, 'Finish with chopped parsley before serving.');

  --------------------------------------------------------------------
  -- Roasted Vegetable and Farro Bowl with Grilled Chicken and Tahini (Non-Vegan Alt) (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Roasted Vegetable and Farro Bowl with Grilled Chicken and Tahini (Non-Vegan Alt)', 'LUNCH', 4, 2, 4,
    'Grilled chicken in place of chickpeas as the main protein, keeping the same roasted vegetables and tahini drizzle.', 'Zucchini -> yellow squash or eggplant; Bell pepper -> poblano pepper or zucchini', 'Zucchini: Fresh is better, since zucchini gets watery when frozen; frozen is still fine in soups or blended dishes. Bell pepper: Frozen sliced peppers work well in any cooked dish (stir-fries, curries, stews, roasting); use fresh if it needs to stay raw or crisp.', 'Red and yellow peppers, green zucchini, golden chicken, cream tahini', 30,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'gluten-free'), (m, 'lunch');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Farro, cooked', '3/4 cup'), (m, 'Zucchini, diced', '1/2 cup'), (m, 'Bell pepper, diced', '1/2 cup'), (m, 'Olive oil', '1 tbsp'), (m, 'Grilled chicken, sliced', '100 g'), (m, 'Tahini', '1 tbsp'), (m, 'Fresh herbs, chopped', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Toss zucchini and bell pepper with olive oil and roast at 200C/400F for 20 minutes.'), (m, 1, 'Spoon cooked farro into a bowl and top with roasted vegetables.'), (m, 2, 'Add sliced grilled chicken on top.'), (m, 3, 'Drizzle with tahini and finish with fresh herbs.');

  --------------------------------------------------------------------
  -- Miso Ginger Soup with Shrimp, Bok Choy, and Soba Noodles (Non-Vegan Alt) (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Miso Ginger Soup with Shrimp, Bok Choy, and Soba Noodles (Non-Vegan Alt)', 'LUNCH', 4, 2, 3,
    'Shrimp in place of tofu as the protein, keeping the same miso and ginger base and fermented-food gut benefit.', 'Bok choy -> napa cabbage or Swiss chard', 'Bok choy: Fresh is better; frozen bok choy goes soft, more suited to soups than a quick saute.', 'Pale golden broth, pink shrimp, bright green bok choy and scallion', 15,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'gluten-free'), (m, 'lunch');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free (check miso and soba labels)'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Vegetable broth', '2 cups'), (m, 'Fresh ginger, grated', '1 tsp'), (m, 'Shrimp, peeled', '100 g'), (m, 'Bok choy, chopped', '1 cup'), (m, 'Soba noodles, cooked', '1/2 cup'), (m, 'Miso paste', '1 tbsp'), (m, 'Scallion, sliced', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Simmer broth with ginger for 5 minutes.'), (m, 1, 'Add shrimp, bok choy, and cooked soba noodles, and simmer for 3-4 minutes until shrimp is pink.'), (m, 2, 'Remove from heat and stir in miso paste until dissolved.'), (m, 3, 'Top with sliced scallion before serving.');

  --------------------------------------------------------------------
  -- Chicken and Spinach Curry with Brown Rice (Non-Vegan Alt) (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Chicken and Spinach Curry with Brown Rice (Non-Vegan Alt)', 'LUNCH', 5, 4, 5,
    'Chicken added alongside the chickpeas for extra protein in the same turmeric curry base.', 'Spinach -> kale or Swiss chard; Tomato -> red bell pepper or sun-dried tomato', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted. Tomato: Fresh is better for salads and raw preparations; frozen or canned diced tomato is fine in anything cooked (sauces, soups, stews).', 'Golden-orange curry, dark green spinach, red cherry tomato pieces', 30,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'dairy-free'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'high-protein'), (m, 'iron-rich'), (m, 'lunch');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chicken thighs, diced', '150 g'), (m, 'Chickpeas', '1/2 cup'), (m, 'Spinach', '1 cup'), (m, 'Cherry tomatoes, halved', '1/2 cup'), (m, 'Coconut milk', '1/2 cup'), (m, 'Turmeric', '1/2 tsp'), (m, 'Cumin', '1/4 tsp'), (m, 'Brown rice, cooked', '3/4 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Simmer chicken thighs, chickpeas, cherry tomatoes, coconut milk, turmeric, and cumin in a pan for 12-15 minutes, until chicken is cooked through.'), (m, 1, 'Stir in spinach and cook until wilted, about 2 minutes.'), (m, 2, 'Serve over cooked brown rice.');

  --------------------------------------------------------------------
  -- Braised Cabbage and Apple with Soft-Boiled Egg (LUNCH)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Braised Cabbage and Apple with Soft-Boiled Egg', 'LUNCH', 3, 2, 3,
    'Cabbage is a cruciferous vegetable providing fiber and sulfur-containing compounds studied for antioxidant activity; apple adds sweetness and fiber; a soft-boiled egg adds the protein needed to make this a full lunch rather than a side dish.', 'Cabbage -> Brussels sprouts or bok choy', 'Cabbage: Both work for cooked dishes like braising or soup; fresh is better if you want it to hold some crunch.', 'Pale green braised cabbage, red-green apple slices, golden egg yolk', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'lunch'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Cabbage, shredded', '2 cups'), (m, 'Apple, sliced', '1/2'), (m, 'Olive oil', '1 tbsp'), (m, 'Caraway seeds', '1/2 tsp'), (m, 'Egg', '1'), (m, 'Salt and pepper', 'to taste');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Heat olive oil in a pan over low-medium heat.'), (m, 1, 'Add shredded cabbage, apple, and caraway seeds.'), (m, 2, 'Cover and braise for about 15 minutes, stirring occasionally, until soft.'), (m, 3, 'Season to taste with salt and pepper.'), (m, 4, 'Soft-boil the egg for 6-7 minutes, halve, and place on top of the braised cabbage.');

  --------------------------------------------------------------------
  -- Baked Salmon with Roasted Brussels Sprouts and Sweet Potato (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Baked Salmon with Roasted Brussels Sprouts and Sweet Potato', 'DINNER', 5, 4, 4,
    'Combines omega-3-rich salmon with cruciferous vegetables and beta-carotene from sweet potato.', 'Brussels sprouts -> broccoli or cabbage; Sweet potato -> butternut squash or regular potato', 'Brussels sprouts: Frozen works fine for roasting, though fresh caramelizes better; both are reasonable choices. Sweet potato: Both work. Frozen cubes or fries are convenient for roasting; fresh gives a better texture for rounds or slices you want to hold their shape.', 'Deep pink-orange salmon, charred green sprouts, orange sweet potato, ruby pomegranate', 30,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free'), (m, 'iron-rich'), (m, 'omega-3');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Salmon fillet', '150 g'), (m, 'Brussels sprouts, halved', '1 cup'), (m, 'Sweet potato, diced', '1 cup'), (m, 'Olive oil', '1 tbsp'), (m, 'Pomegranate seeds', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 200C/400F.'), (m, 1, 'Toss Brussels sprouts and sweet potato with olive oil, spread on a baking sheet, and roast for 15 minutes.'), (m, 2, 'Add the salmon fillet to the sheet and roast for another 12-15 minutes, until the salmon is cooked through.'), (m, 3, 'Scatter pomegranate seeds over the plate before serving.');

  --------------------------------------------------------------------
  -- Turmeric Chicken Thighs with Steamed Broccoli and Charred Lemon (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Turmeric Chicken Thighs with Steamed Broccoli and Charred Lemon', 'DINNER', 4, 3, 2,
    'Turmeric and garlic are traditional anti-inflammatory seasonings; broccoli adds fiber and sulforaphane.', 'Broccoli -> cauliflower or Brussels sprouts', 'Broccoli: Frozen works very well, especially steamed or in stir-fries; fresh gives a firmer texture if you''re roasting it.', 'Golden turmeric-marinated chicken, deep green broccoli, charred yellow lemon', 35,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chicken thighs', '2'), (m, 'Turmeric', '1/2 tsp'), (m, 'Garlic, minced', '1 clove'), (m, 'Olive oil', '1 tbsp'), (m, 'Broccoli florets', '1 cup'), (m, 'Lemon, halved', '1');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Marinate chicken thighs in turmeric, garlic, and olive oil for at least 10 minutes.'), (m, 1, 'Pan-sear or bake the chicken until cooked through, about 6-8 minutes per side if pan-searing.'), (m, 2, 'Steam broccoli florets for 4-5 minutes until tender.'), (m, 3, 'In the same pan used for the chicken, char the lemon halves cut-side down for 1-2 minutes.'), (m, 4, 'Serve the chicken with broccoli and charred lemon.');

  --------------------------------------------------------------------
  -- Lentil and Vegetable Curry with Brown Rice (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Lentil and Vegetable Curry with Brown Rice', 'DINNER', 5, 4, 5,
    'Plant-based protein and fiber from lentils, paired with curry spices commonly studied for anti-inflammatory properties.', 'Carrot -> parsnip or sweet potato; Spinach -> kale or Swiss chard', 'Carrot: Both work. Frozen sliced or diced carrot is fine in soups, stews, and curries; fresh is better for raw or roasted dishes where texture matters. Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted.', 'Golden-orange curry with flecks of green spinach and red pepper', 30,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'dinner'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'iron-rich'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Lentils', '1/2 cup'), (m, 'Carrot, diced', '1/2 cup'), (m, 'Spinach', '1 cup'), (m, 'Bell pepper, diced', '1/2 cup'), (m, 'Turmeric', '1/2 tsp'), (m, 'Cumin', '1/4 tsp'), (m, 'Fresh ginger, grated', '1 tsp'), (m, 'Vegetable broth', '1 cup'), (m, 'Brown rice, cooked', '3/4 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Simmer lentils, carrot, and bell pepper with turmeric, cumin, ginger, and broth for 20 minutes, until lentils are soft.'), (m, 1, 'Stir in spinach and cook until wilted, about 2 minutes.'), (m, 2, 'Serve over cooked brown rice.');

  --------------------------------------------------------------------
  -- Grilled Mackerel with Sauteed Spinach, Garlic, and Roasted Tomatoes (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Grilled Mackerel with Sauteed Spinach, Garlic, and Roasted Tomatoes', 'DINNER', 5, 4, 2,
    'Mackerel is one of the highest dietary sources of omega-3 fatty acids; garlic contains allicin, studied for anti-inflammatory activity.', 'Spinach -> kale or Swiss chard; Tomato -> red bell pepper or sun-dried tomato', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted. Tomato: Fresh is better for salads and raw preparations; frozen or canned diced tomato is fine in anything cooked (sauces, soups, stews).', 'Silvery-blue mackerel skin, dark green spinach, blistered red tomatoes', 15,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free'), (m, 'iron-rich'), (m, 'omega-3');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Mackerel fillet', '150 g'), (m, 'Olive oil', '1 tbsp'), (m, 'Garlic, minced', '1 clove'), (m, 'Spinach', '1 cup'), (m, 'Cherry tomatoes, halved', '1/2 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Roast cherry tomatoes with a little olive oil at 200C/400F for 10 minutes.'), (m, 1, 'Grill or pan-sear the mackerel fillet, about 3-4 minutes per side.'), (m, 2, 'Heat remaining olive oil in a pan and saute garlic for 30 seconds, then add spinach and cook until wilted.'), (m, 3, 'Serve the mackerel with sauteed spinach and roasted tomatoes.');

  --------------------------------------------------------------------
  -- Stuffed Bell Peppers with Quinoa, Black Beans, and Corn (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Stuffed Bell Peppers with Quinoa, Black Beans, and Corn', 'DINNER', 4, 3, 5,
    'Bell peppers are high in vitamin C; quinoa and black beans provide complete plant protein and fiber; using a mix of pepper colors makes the dish naturally vibrant.', 'Bell pepper -> poblano pepper or zucchini; Corn -> edamame or peas', 'Bell pepper: Frozen sliced peppers work well in any cooked dish (stir-fries, curries, stews, roasting); use fresh if it needs to stay raw or crisp. Corn: Frozen kernels work great and are often more convenient than fresh corn; canned is a fine substitute too.', 'Red, yellow, and orange peppers, golden corn, black beans against white quinoa', 35,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dinner'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Bell peppers, halved', '2'), (m, 'Cooked quinoa', '1 cup'), (m, 'Black beans', '1/2 cup'), (m, 'Corn kernels', '1/2 cup'), (m, 'Tomato, diced', '1/2 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 190C/375F.'), (m, 1, 'Mix cooked quinoa with black beans, corn, and diced tomato.'), (m, 2, 'Spoon the mixture into the halved bell peppers.'), (m, 3, 'Place peppers in a baking dish and bake for 25-30 minutes, until peppers soften.');

  --------------------------------------------------------------------
  -- Ginger Turmeric Stir-Fry with Tofu, Bell Pepper, and Snap Peas (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Ginger Turmeric Stir-Fry with Tofu, Bell Pepper, and Snap Peas', 'DINNER', 5, 3, 3,
    'Stir-fried vegetables retain water-soluble vitamins when cooked quickly; ginger and turmeric add characteristic anti-inflammatory spice compounds.', 'Bell pepper -> poblano pepper or zucchini; Peas -> edamame or green beans', 'Bell pepper: Frozen sliced peppers work well in any cooked dish (stir-fries, curries, stews, roasting); use fresh if it needs to stay raw or crisp. Peas: Frozen is actually the standard choice here, often better than fresh since they''re flash-frozen at peak sweetness; no need to seek out fresh.', 'Golden tofu, red pepper, bright green snap peas, orange carrot', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'dinner'), (m, 'gluten-free'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free (use tamari not soy sauce)');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Firm tofu, cubed', '150 g'), (m, 'Bell pepper, sliced', '1/2'), (m, 'Snap peas', '1/2 cup'), (m, 'Carrot, sliced', '1/2'), (m, 'Fresh ginger, grated', '1 tsp'), (m, 'Turmeric', '1/4 tsp'), (m, 'Tamari', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Pan-fry tofu cubes until golden on most sides, about 5-6 minutes, then remove from the pan.'), (m, 1, 'Stir-fry bell pepper, snap peas, and carrot in the same pan for 3-4 minutes.'), (m, 2, 'Add ginger and turmeric, and stir-fry for 30 seconds.'), (m, 3, 'Return tofu to the pan with tamari and toss to combine.');

  --------------------------------------------------------------------
  -- Baked Cod with Roasted Cauliflower, Olive Oil, and Turmeric (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Baked Cod with Roasted Cauliflower, Olive Oil, and Turmeric', 'DINNER', 4, 2, 2,
    'Cod is a lean white fish providing protein with lower fat than oily fish; cauliflower is a cruciferous vegetable with antioxidant compounds.', 'Cauliflower -> broccoli or Romanesco', 'Cauliflower: Frozen works well for curries, rice, or roasting if patted dry first; fresh gives a better roasted texture.', 'White cod, golden turmeric-roasted cauliflower, green parsley', 30,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Cod fillet', '150 g'), (m, 'Cauliflower florets', '1 cup'), (m, 'Olive oil', '1 tbsp'), (m, 'Turmeric', '1/2 tsp'), (m, 'Lemon', '1/2'), (m, 'Parsley, chopped', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 200C/400F.'), (m, 1, 'Toss cauliflower florets with olive oil and turmeric, spread on a baking sheet, and roast for 15 minutes.'), (m, 2, 'Place cod fillet on a separate sheet with a squeeze of lemon and bake for 12-15 minutes until cooked through.'), (m, 3, 'Plate the cod with the roasted cauliflower and finish with parsley.');

  --------------------------------------------------------------------
  -- Slow-Cooked Beef and Vegetable Stew with Turmeric (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Slow-Cooked Beef and Vegetable Stew with Turmeric', 'DINNER', 4, 5, 4,
    'Using lean cuts and long, moist cooking reduces saturated fat exposure compared to fattier cuts; root vegetables add fiber and antioxidants.', 'Carrot -> parsnip or sweet potato; Celery -> fennel or celeriac', 'Carrot: Both work. Frozen sliced or diced carrot is fine in soups, stews, and curries; fresh is better for raw or roasted dishes where texture matters. Celery: Fresh is standard; frozen celery is uncommon but fine in soups if that''s what you have.', 'Golden-orange broth, orange carrots, green peas and celery', 90,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free'), (m, 'iron-rich');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Lean beef, cubed', '200 g'), (m, 'Carrot, diced', '1/2 cup'), (m, 'Celery, diced', '1/2 cup'), (m, 'Turmeric', '1/2 tsp'), (m, 'Tomato, diced', '1/2 cup'), (m, 'Beef or vegetable broth', '1 1/2 cups'), (m, 'Peas', '1/4 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Brown the beef cubes in a pot over medium-high heat, about 5 minutes.'), (m, 1, 'Add carrot, celery, turmeric, tomato, and broth.'), (m, 2, 'Cover and simmer for 45-60 minutes (or slow-cook for longer), until the beef is tender.'), (m, 3, 'Stir in peas during the last 5 minutes to keep their color.');

  --------------------------------------------------------------------
  -- Chickpea and Spinach Stew with Whole Grain Bread (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Chickpea and Spinach Stew with Whole Grain Bread', 'DINNER', 5, 3, 5,
    'A legume- and vegetable-forward dinner consistent with Mediterranean-style eating patterns.', 'Spinach -> kale or Swiss chard; Tomato -> red bell pepper or sun-dried tomato', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted. Tomato: Fresh is better for salads and raw preparations; frozen or canned diced tomato is fine in anything cooked (sauces, soups, stews).', 'Deep red tomato broth, dark green spinach, golden chickpeas', 25,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'dinner'), (m, 'high-fiber'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chickpeas', '1 cup'), (m, 'Spinach', '1 cup'), (m, 'Tomato, diced', '1 cup'), (m, 'Garlic, minced', '1 clove'), (m, 'Cumin', '1/4 tsp'), (m, 'Smoked paprika', '1/4 tsp'), (m, 'Whole grain bread', '1 slice');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Simmer chickpeas, tomato, garlic, cumin, and smoked paprika in a pot for 10-12 minutes.'), (m, 1, 'Stir in spinach and cook until wilted, about 2 minutes.'), (m, 2, 'Serve with a slice of whole grain bread.');

  --------------------------------------------------------------------
  -- Grilled Shrimp with Asparagus, Lemon, and Cherry Tomatoes (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Grilled Shrimp with Asparagus, Lemon, and Cherry Tomatoes', 'DINNER', 3, 2, 2,
    'Shrimp is a lean protein source; asparagus provides fiber and antioxidant compounds; olive oil and lemon add healthy fat and vitamin C.', 'Asparagus -> green beans or broccolini; Tomato -> red bell pepper or sun-dried tomato', 'Asparagus: Fresh is better for texture, especially roasted; frozen asparagus goes soft and is more suited to soups. Tomato: Fresh is better for salads and raw preparations; frozen or canned diced tomato is fine in anything cooked (sauces, soups, stews).', 'Pink-orange shrimp, green asparagus, red cherry tomatoes', 15,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Shrimp, peeled', '150 g'), (m, 'Asparagus', '8 spears'), (m, 'Cherry tomatoes, halved', '1/2 cup'), (m, 'Olive oil', '1 tbsp'), (m, 'Lemon juice', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Toss shrimp, asparagus, and cherry tomatoes with olive oil.'), (m, 1, 'Grill for 3-4 minutes, turning once, until shrimp is pink and asparagus is tender.'), (m, 2, 'Finish with a squeeze of fresh lemon juice before serving.');

  --------------------------------------------------------------------
  -- Turkey Chili with Kidney Beans, Bell Peppers, and Avocado (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Turkey Chili with Kidney Beans, Bell Peppers, and Avocado', 'DINNER', 4, 3, 5,
    'Lean ground turkey combined with fiber-rich beans and vitamin-C-rich peppers.', 'Bell pepper -> poblano pepper or zucchini; Tomato -> red bell pepper or sun-dried tomato', 'Bell pepper: Frozen sliced peppers work well in any cooked dish (stir-fries, curries, stews, roasting); use fresh if it needs to stay raw or crisp. Tomato: Fresh is better for salads and raw preparations; frozen or canned diced tomato is fine in anything cooked (sauces, soups, stews).', 'Deep red chili, red and yellow peppers, green avocado and cilantro garnish', 35,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'high-protein');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Ground turkey', '150 g'), (m, 'Kidney beans', '1/2 cup'), (m, 'Bell peppers, diced', '1/2 cup'), (m, 'Tomato, diced', '1 cup'), (m, 'Chili powder', '1 tsp'), (m, 'Cumin', '1/2 tsp'), (m, 'Avocado, diced', '1/2'), (m, 'Cilantro, chopped', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Brown ground turkey in a pot over medium heat, about 5 minutes.'), (m, 1, 'Add kidney beans, bell peppers, tomato, chili powder, and cumin.'), (m, 2, 'Simmer for 20 minutes, until thickened.'), (m, 3, 'Top with diced avocado and cilantro before serving.');

  --------------------------------------------------------------------
  -- Roasted Vegetable and Chickpea Curry (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Roasted Vegetable and Chickpea Curry', 'DINNER', 5, 3, 4,
    'Roasting vegetables before adding to curry preserves texture and adds variety of plant compounds alongside turmeric-based spices.', 'Carrot -> parsnip or sweet potato; Cauliflower -> broccoli or Romanesco', 'Carrot: Both work. Frozen sliced or diced carrot is fine in soups, stews, and curries; fresh is better for raw or roasted dishes where texture matters. Cauliflower: Frozen works well for curries, rice, or roasting if patted dry first; fresh gives a better roasted texture.', 'Golden curry, orange carrot, white cauliflower, red pepper', 35,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'dinner'), (m, 'gluten-free'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chickpeas', '1 cup'), (m, 'Carrot, diced', '1/2 cup'), (m, 'Cauliflower florets', '1/2 cup'), (m, 'Red pepper, diced', '1/2 cup'), (m, 'Turmeric', '1/2 tsp'), (m, 'Coconut milk', '1/2 cup'), (m, 'Olive oil', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 200C/400F and roast carrot, cauliflower, and red pepper with a little olive oil for 20 minutes.'), (m, 1, 'Simmer chickpeas, turmeric, and coconut milk in a pan for 5 minutes.'), (m, 2, 'Add the roasted vegetables to the curry sauce and stir to combine.');

  --------------------------------------------------------------------
  -- Baked Trout with Steamed Kale, Quinoa, and Roasted Beets (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Baked Trout with Steamed Kale, Quinoa, and Roasted Beets', 'DINNER', 5, 4, 5,
    'Trout is a freshwater fish source of omega-3s; kale and quinoa round out the plate with fiber, vitamin K, and plant protein; beets add color and antioxidants.', 'Kale -> spinach or collard greens; Beets -> carrots or radishes', 'Kale: Fresh is better, especially for raw or massaged-salad uses; frozen chopped kale exists but turns soft, only really suited to soups. Beets: Fresh, or pre-cooked vacuum-packed beets, is standard; frozen beets are uncommon and not necessary here.', 'Pink trout flesh, dark green kale, magenta beets, pale quinoa', 25,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'iron-rich'), (m, 'omega-3');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Trout fillet', '150 g'), (m, 'Olive oil', '1 tbsp'), (m, 'Lemon', '1/2'), (m, 'Kale, chopped', '2 cups'), (m, 'Cooked quinoa', '3/4 cup'), (m, 'Beets, roasted and sliced', '1/2 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 200C/400F and roast beets separately until tender, about 35-40 minutes (or use pre-cooked beets).'), (m, 1, 'Bake trout with olive oil and a squeeze of lemon for 12-15 minutes, until cooked through.'), (m, 2, 'Steam kale for 3-4 minutes until wilted.'), (m, 3, 'Serve the trout over quinoa with steamed kale and roasted beets on the side.');

  --------------------------------------------------------------------
  -- Herb-Roasted Chicken with Root Vegetables (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Herb-Roasted Chicken with Root Vegetables', 'DINNER', 3, 3, 3,
    'Roasting bone-in chicken with root vegetables makes a satisfying, whole-food dinner using herbs rather than heavy sauces; root vegetables add fiber and antioxidants.', 'Carrot -> parsnip or sweet potato; Parsnip -> carrot or turnip', 'Carrot: Both work. Frozen sliced or diced carrot is fine in soups, stews, and curries; fresh is better for raw or roasted dishes where texture matters. Parsnip: Both work. Frozen parsnip is less common but fine in stews; fresh is better for roasting.', 'Golden-brown chicken skin, orange carrots and parsnip', 50,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Bone-in chicken thighs', '2'), (m, 'Carrots, chopped', '1 cup'), (m, 'Parsnip, chopped', '1/2 cup'), (m, 'Onion, chopped', '1/2'), (m, 'Olive oil', '2 tbsp'), (m, 'Rosemary, chopped', '1 tsp'), (m, 'Thyme, chopped', '1 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 200C/400F.'), (m, 1, 'Toss carrots, parsnip, and onion with olive oil, rosemary, and thyme in a baking dish.'), (m, 2, 'Nestle chicken thighs on top of the vegetables.'), (m, 3, 'Roast for 40-45 minutes, until the chicken is cooked through and vegetables are tender.');

  --------------------------------------------------------------------
  -- Baked Halibut with Roasted Fennel and Olives (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Baked Halibut with Roasted Fennel and Olives', 'DINNER', 4, 2, 2,
    'Halibut is a lean white fish; fennel adds fiber and a mild anise note; olives contribute monounsaturated fat, echoing a Mediterranean-style plate.', 'Fennel -> celery or leek', 'Fennel: Fresh only, frozen fennel isn''t commonly sold.', 'White halibut, pale green fennel, dark green-black olives', 30,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Halibut fillet', '150 g'), (m, 'Fennel, sliced', '1 cup'), (m, 'Olive oil', '1 tbsp'), (m, 'Lemon, sliced', '1/2'), (m, 'Olives', '2 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 200C/400F.'), (m, 1, 'Toss sliced fennel with olive oil and roast for 15 minutes, until softened.'), (m, 2, 'Add halibut fillet and lemon slices to the sheet, and bake for 12-15 minutes until cooked through.'), (m, 3, 'Scatter olives over the top before serving.');

  --------------------------------------------------------------------
  -- Beef and Broccoli Stir-Fry with Ginger (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Beef and Broccoli Stir-Fry with Ginger', 'DINNER', 4, 5, 2,
    'Using lean cuts of beef in a quick stir-fry limits saturated fat while still providing iron and protein; broccoli adds sulforaphane and fiber; ginger and garlic add traditional anti-inflammatory spice compounds.', 'Broccoli -> cauliflower or Brussels sprouts', 'Broccoli: Frozen works very well, especially steamed or in stir-fries; fresh gives a firmer texture if you''re roasting it.', 'Browned beef, deep green broccoli', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free'), (m, 'iron-rich');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Dairy-free (use tamari for gluten-free)');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Lean beef strips', '150 g'), (m, 'Broccoli florets', '1 cup'), (m, 'Fresh ginger, grated', '1 tsp'), (m, 'Garlic, minced', '1 clove'), (m, 'Tamari', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Stir-fry beef strips over high heat until browned, about 3-4 minutes, then remove from the pan.'), (m, 1, 'Stir-fry broccoli in the same pan for 3-4 minutes.'), (m, 2, 'Add ginger and garlic, and stir-fry for 30 seconds.'), (m, 3, 'Return beef to the pan with tamari and toss to combine.');

  --------------------------------------------------------------------
  -- Honey-Pecan Brie Sweet Potato Rounds (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Honey-Pecan Brie Sweet Potato Rounds', 'SNACK', 3, 1, 2,
    'Roasted sweet potato rounds work as a base in place of crackers or bread; pecans add polyphenols and healthy fat. This one leans more indulgent than most of the set because of the brie and honey, so treat it as an occasional plate rather than a daily snack.', 'Sweet potato -> butternut squash or regular potato', 'Sweet potato: Both work. Frozen cubes or fries are convenient for roasting; fresh gives a better texture for rounds or slices you want to hold their shape.', 'Orange sweet potato rounds, creamy white-gold brie, brown pecans', 30,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Sweet potato, sliced into rounds', '1'), (m, 'Olive oil', '1 tbsp'), (m, 'Black pepper', 'pinch'), (m, 'Brie, sliced', '60 g'), (m, 'Pecans, halved', '8'), (m, 'Honey', '1 tsp'), (m, 'Fresh thyme leaves', '1/2 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 200C/400F.'), (m, 1, 'Toss sweet potato rounds with olive oil and black pepper, and spread on a baking sheet.'), (m, 2, 'Roast for 20-25 minutes, flipping halfway.'), (m, 3, 'Top each round with a small piece of brie and a pecan half, and return to the oven for 3-5 minutes until the cheese softens.'), (m, 4, 'Drizzle with honey and scatter fresh thyme leaves.');

  --------------------------------------------------------------------
  -- Chicken and Lentil Curry with Brown Rice (Non-Vegan Alt) (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Chicken and Lentil Curry with Brown Rice (Non-Vegan Alt)', 'DINNER', 5, 4, 5,
    'Chicken thighs added to the same lentil and vegetable curry base for extra protein.', 'Carrot -> parsnip or sweet potato; Spinach -> kale or Swiss chard', 'Carrot: Both work. Frozen sliced or diced carrot is fine in soups, stews, and curries; fresh is better for raw or roasted dishes where texture matters. Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted.', 'Golden-orange curry with chicken, green spinach, red pepper', 35,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'high-protein'), (m, 'iron-rich');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chicken thighs, diced', '150 g'), (m, 'Lentils', '1/2 cup'), (m, 'Carrot, diced', '1/2 cup'), (m, 'Spinach', '1 cup'), (m, 'Bell pepper, diced', '1/2 cup'), (m, 'Turmeric', '1/2 tsp'), (m, 'Brown rice, cooked', '3/4 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Brown chicken thighs in a pot for 4-5 minutes.'), (m, 1, 'Add lentils, carrot, bell pepper, and turmeric, cover with water or broth, and simmer for 20-25 minutes.'), (m, 2, 'Stir in spinach and cook until wilted.'), (m, 3, 'Serve over cooked brown rice.');

  --------------------------------------------------------------------
  -- Beef and Quinoa Stuffed Bell Peppers (Non-Vegan Alt) (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Beef and Quinoa Stuffed Bell Peppers (Non-Vegan Alt)', 'DINNER', 4, 5, 5,
    'Lean ground beef added to the same quinoa and black bean filling for extra protein and iron.', 'Bell pepper -> poblano pepper or zucchini; Corn -> edamame or peas', 'Bell pepper: Frozen sliced peppers work well in any cooked dish (stir-fries, curries, stews, roasting); use fresh if it needs to stay raw or crisp. Corn: Frozen kernels work great and are often more convenient than fresh corn; canned is a fine substitute too.', 'Red, yellow, and orange peppers, browned beef, golden corn', 40,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'high-protein'), (m, 'iron-rich');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Bell peppers, halved', '2'), (m, 'Lean ground beef', '150 g'), (m, 'Cooked quinoa', '1/2 cup'), (m, 'Black beans', '1/2 cup'), (m, 'Corn kernels', '1/4 cup'), (m, 'Tomato, diced', '1/2 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 190C/375F.'), (m, 1, 'Brown ground beef in a pan, about 5 minutes.'), (m, 2, 'Mix browned beef with cooked quinoa, black beans, corn, and tomato.'), (m, 3, 'Spoon the mixture into the halved bell peppers and bake for 25-30 minutes, until peppers soften.');

  --------------------------------------------------------------------
  -- Ginger Turmeric Stir-Fry with Shrimp, Bell Pepper, and Snap Peas (Non-Vegan Alt) (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Ginger Turmeric Stir-Fry with Shrimp, Bell Pepper, and Snap Peas (Non-Vegan Alt)', 'DINNER', 4, 2, 3,
    'Shrimp in place of tofu, keeping the same quick-cooked vegetables and ginger-turmeric seasoning.', 'Bell pepper -> poblano pepper or zucchini; Peas -> edamame or green beans', 'Bell pepper: Frozen sliced peppers work well in any cooked dish (stir-fries, curries, stews, roasting); use fresh if it needs to stay raw or crisp. Peas: Frozen is actually the standard choice here, often better than fresh since they''re flash-frozen at peak sweetness; no need to seek out fresh.', 'Pink shrimp, red pepper, bright green snap peas, orange carrot', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Shrimp, peeled', '150 g'), (m, 'Bell pepper, sliced', '1/2'), (m, 'Snap peas', '1/2 cup'), (m, 'Carrot, sliced', '1/2'), (m, 'Fresh ginger, grated', '1 tsp'), (m, 'Turmeric', '1/4 tsp'), (m, 'Tamari', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Stir-fry shrimp over medium-high heat until just pink, about 3 minutes, then remove from the pan.'), (m, 1, 'Stir-fry bell pepper, snap peas, and carrot in the same pan for 3-4 minutes.'), (m, 2, 'Add ginger and turmeric, and stir-fry for 30 seconds.'), (m, 3, 'Return shrimp to the pan with tamari and toss to combine.');

  --------------------------------------------------------------------
  -- Chicken and Spinach Stew with Whole Grain Bread (Non-Vegan Alt) (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Chicken and Spinach Stew with Whole Grain Bread (Non-Vegan Alt)', 'DINNER', 4, 4, 5,
    'Chicken thighs added to the same chickpea and spinach stew base for extra protein.', 'Spinach -> kale or Swiss chard; Tomato -> red bell pepper or sun-dried tomato', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted. Tomato: Fresh is better for salads and raw preparations; frozen or canned diced tomato is fine in anything cooked (sauces, soups, stews).', 'Deep red tomato broth, dark green spinach, browned chicken', 35,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dinner'), (m, 'gluten-free'), (m, 'high-fiber'), (m, 'high-protein'), (m, 'iron-rich');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chicken thighs, diced', '150 g'), (m, 'Chickpeas', '1/2 cup'), (m, 'Spinach', '1 cup'), (m, 'Tomato, diced', '1 cup'), (m, 'Garlic, minced', '1 clove'), (m, 'Cumin', '1/4 tsp'), (m, 'Smoked paprika', '1/4 tsp'), (m, 'Whole grain bread', '1 slice');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Brown chicken thighs in a pot, about 4-5 minutes.'), (m, 1, 'Add chickpeas, tomato, garlic, cumin, and smoked paprika, and simmer for 15-18 minutes until chicken is cooked through.'), (m, 2, 'Stir in spinach and cook until wilted.'), (m, 3, 'Serve with a slice of whole grain bread.');

  --------------------------------------------------------------------
  -- Roasted Vegetable and Chicken Curry (Non-Vegan Alt) (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Roasted Vegetable and Chicken Curry (Non-Vegan Alt)', 'DINNER', 4, 3, 3,
    'Chicken thighs in place of chickpeas as the main protein, keeping the same roasted vegetables and turmeric-coconut sauce.', 'Carrot -> parsnip or sweet potato; Cauliflower -> broccoli or Romanesco', 'Carrot: Both work. Frozen sliced or diced carrot is fine in soups, stews, and curries; fresh is better for raw or roasted dishes where texture matters. Cauliflower: Frozen works well for curries, rice, or roasting if patted dry first; fresh gives a better roasted texture.', 'Golden curry, orange carrot, white cauliflower, red pepper', 40,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'dinner'), (m, 'gluten-free');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chicken thighs, diced', '150 g'), (m, 'Carrot, diced', '1/2 cup'), (m, 'Cauliflower florets', '1/2 cup'), (m, 'Red pepper, diced', '1/2 cup'), (m, 'Turmeric', '1/2 tsp'), (m, 'Coconut milk', '1/2 cup'), (m, 'Olive oil', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Brown chicken thighs in a pan, about 5 minutes.'), (m, 1, 'Preheat oven to 200C/400F and roast carrot, cauliflower, and red pepper with a little olive oil for 20 minutes.'), (m, 2, 'Simmer chicken, turmeric, and coconut milk together for 10 minutes, until chicken is cooked through.'), (m, 3, 'Stir in the roasted vegetables and combine.');

  --------------------------------------------------------------------
  -- Tempeh and Broccoli Stir-Fry with Ginger (DINNER)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Tempeh and Broccoli Stir-Fry with Ginger', 'DINNER', 4, 3, 4,
    'Tempeh is a fermented soy product with a firmer texture and more fiber than tofu, since it uses the whole soybean; it''s a good rotation option alongside tofu and legumes for plant protein variety.', 'Broccoli -> cauliflower or Brussels sprouts; Carrot -> parsnip or sweet potato', 'Broccoli: Frozen works very well, especially steamed or in stir-fries; fresh gives a firmer texture if you''re roasting it. Carrot: Both work. Frozen sliced or diced carrot is fine in soups, stews, and curries; fresh is better for raw or roasted dishes where texture matters.', 'Browned tempeh, deep green broccoli, orange carrot', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dinner'), (m, 'gluten-free'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free (use tamari)');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Tempeh, sliced', '150 g'), (m, 'Broccoli florets', '1 cup'), (m, 'Fresh ginger, grated', '1 tsp'), (m, 'Garlic, minced', '1 clove'), (m, 'Carrot, sliced', '1/2'), (m, 'Tamari', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Pan-fry tempeh slices until browned on both sides, about 3-4 minutes per side, then remove from the pan.'), (m, 1, 'Stir-fry broccoli and carrot in the same pan for 3-4 minutes.'), (m, 2, 'Add ginger and garlic, and stir-fry for 30 seconds.'), (m, 3, 'Return tempeh to the pan with tamari and toss to combine.');

  --------------------------------------------------------------------
  -- Mixed Berries with Walnuts (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Mixed Berries with Walnuts', 'SNACK', 4, 1, 3,
    'Berries provide antioxidant polyphenols; walnuts add omega-3 (ALA) and healthy fat.', NULL, NULL, 'Red, blue, and purple berries, tan walnuts', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick'), (m, 'snack'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Mixed berries (strawberry, blueberry, raspberry)', '1 cup'), (m, 'Walnuts', '2 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Combine mixed berries and walnuts in a small bowl.'), (m, 1, 'Serve immediately.');

  --------------------------------------------------------------------
  -- Hummus with Carrot, Cucumber, and Red Pepper Sticks (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Hummus with Carrot, Cucumber, and Red Pepper Sticks', 'SNACK', 4, 2, 4,
    'Chickpea-based hummus provides fiber and plant protein; raw vegetables add crunch without added sugar or refined carbohydrates.', 'Carrot -> parsnip or sweet potato; Cucumber -> zucchini or celery', 'Carrot: Both work. Frozen sliced or diced carrot is fine in soups, stews, and curries; fresh is better for raw or roasted dishes where texture matters. Cucumber: Fresh only, cucumber breaks down and turns watery once frozen.', 'Orange carrot, green cucumber, red pepper against golden hummus', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'no-cook'), (m, 'quick'), (m, 'snack'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Hummus', '1/3 cup'), (m, 'Carrot, cut into sticks', '1/2'), (m, 'Cucumber, cut into sticks', '1/2'), (m, 'Red bell pepper, cut into sticks', '1/2');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Spoon hummus into a small bowl.'), (m, 1, 'Arrange carrot, cucumber, and red pepper sticks around the hummus.'), (m, 2, 'Serve for dipping.');

  --------------------------------------------------------------------
  -- Turmeric Roasted Chickpeas (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Turmeric Roasted Chickpeas', 'SNACK', 5, 3, 4,
    'Roasted chickpeas offer fiber and plant protein in a crunchy, shelf-stable snack format; turmeric and black pepper pairing may aid curcumin absorption.', NULL, NULL, 'Golden-orange roasted chickpeas', 30,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'gluten-free'), (m, 'snack'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chickpeas, drained', '1 cup'), (m, 'Olive oil', '1 tbsp'), (m, 'Turmeric', '1/2 tsp'), (m, 'Black pepper', 'pinch'), (m, 'Smoked paprika', '1/4 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 200C/400F.'), (m, 1, 'Pat chickpeas dry and toss with olive oil, turmeric, black pepper, and smoked paprika.'), (m, 2, 'Spread on a baking sheet and roast for 25-30 minutes, stirring occasionally, until crisp.');

  --------------------------------------------------------------------
  -- Greek Yogurt with Honey, Cinnamon, and Pomegranate (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Greek Yogurt with Honey, Cinnamon, and Pomegranate', 'SNACK', 3, 1, 1,
    'Yogurt provides probiotics and protein; cinnamon and pomegranate contribute polyphenol antioxidants.', NULL, NULL, 'White yogurt studded with ruby pomegranate jewels', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'no-cook'), (m, 'quick'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Greek yogurt', '1 cup'), (m, 'Honey', '1 tsp'), (m, 'Cinnamon', '1/4 tsp'), (m, 'Pomegranate seeds', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Spoon Greek yogurt into a bowl.'), (m, 1, 'Drizzle with honey and dust with cinnamon.'), (m, 2, 'Top with pomegranate seeds.');

  --------------------------------------------------------------------
  -- Apple Slices with Almond Butter and Cinnamon (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Apple Slices with Almond Butter and Cinnamon', 'SNACK', 3, 1, 3,
    'Apples provide fiber (including pectin) and polyphenols concentrated in the skin; almond butter adds healthy fat and vitamin E.', NULL, NULL, 'Red-green apple slices, cream-colored almond butter', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'no-cook'), (m, 'quick'), (m, 'snack'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Apple, sliced', '1'), (m, 'Almond butter', '2 tbsp'), (m, 'Cinnamon', 'pinch');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Slice the apple and arrange in a fan on a plate.'), (m, 1, 'Serve with almond butter for dipping.'), (m, 2, 'Dust lightly with cinnamon.');

  --------------------------------------------------------------------
  -- Dark Chocolate and Almonds (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Dark Chocolate and Almonds', 'SNACK', 3, 1, 2,
    'Dark chocolate with high cacao content contains flavanols studied for antioxidant properties; almonds add healthy fat and vitamin E.', NULL, NULL, 'Deep brown chocolate, tan almonds', 2,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'no-cook'), (m, 'quick'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Dark chocolate (70%+ cacao)', '20 g'), (m, 'Almonds', '12');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Portion a small square of dark chocolate.'), (m, 1, 'Serve alongside a small handful of almonds.');

  --------------------------------------------------------------------
  -- Golden Milk (Turmeric Latte) (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Golden Milk (Turmeric Latte)', 'SNACK', 4, 1, 0,
    'A warm turmeric-based drink using the turmeric-black pepper pairing thought to enhance curcumin absorption.', NULL, NULL, 'Warm golden-yellow drink', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'quick'), (m, 'snack'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian (vegan with plant milk)'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Milk or plant milk', '1 cup'), (m, 'Turmeric', '1/2 tsp'), (m, 'Black pepper', 'pinch'), (m, 'Cinnamon', '1/4 tsp'), (m, 'Honey (optional)', '1 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Warm milk in a small saucepan over medium heat.'), (m, 1, 'Whisk in turmeric, black pepper, and cinnamon.'), (m, 2, 'Continue whisking until warmed through and slightly frothy.'), (m, 3, 'Sweeten with honey if desired.');

  --------------------------------------------------------------------
  -- Edamame with Sea Salt and Chili Flakes (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Edamame with Sea Salt and Chili Flakes', 'SNACK', 3, 2, 3,
    'Edamame provides plant protein, fiber, and isoflavones.', 'Edamame -> green peas or snap peas', 'Edamame: Frozen is the standard and easiest way to buy edamame; fresh in the pod is rare in most stores.', 'Bright green edamame pods', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'quick'), (m, 'snack'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Edamame, in pods', '1 cup'), (m, 'Sea salt', 'pinch'), (m, 'Chili flakes', 'pinch');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Steam or boil edamame pods for 4-5 minutes.'), (m, 1, 'Drain and sprinkle with sea salt and chili flakes.');

  --------------------------------------------------------------------
  -- Walnut and Date Energy Balls (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Walnut and Date Energy Balls', 'SNACK', 4, 1, 3,
    'Dates provide natural sweetness and fiber without refined sugar; walnuts add omega-3 fat.', NULL, NULL, 'Deep brown balls flecked with tan walnut pieces', 15,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'omega-3'), (m, 'snack'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Dates, pitted', '1 cup'), (m, 'Walnuts', '1/2 cup'), (m, 'Cinnamon', '1/2 tsp'), (m, 'Cacao powder', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Blend pitted dates and walnuts in a food processor until a sticky dough forms.'), (m, 1, 'Add cinnamon and cacao powder, and blend to combine.'), (m, 2, 'Roll the mixture into small balls, about 12.'), (m, 3, 'Refrigerate for at least 30 minutes before serving; makes about 12 balls.');

  --------------------------------------------------------------------
  -- Chia Seed Pudding Cup with Mixed Berries (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Chia Seed Pudding Cup with Mixed Berries', 'SNACK', 3, 1, 4,
    'A portable, fiber- and omega-3-rich snack using the same chia base as the breakfast pudding, topped with berries for color and prepared in single-serve portions.', NULL, NULL, 'Creamy pudding topped with red and blue berries', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'meal-prep'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick'), (m, 'snack'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free (needs soak time)');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chia seeds', '3 tbsp'), (m, 'Plant milk', '1 cup'), (m, 'Vanilla extract', '1/4 tsp'), (m, 'Mixed berries', '1/2 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Stir chia seeds into plant milk with vanilla extract in a small jar.'), (m, 1, 'Cover and refrigerate overnight.'), (m, 2, 'Top with mixed berries before eating.');

  --------------------------------------------------------------------
  -- Roasted Pumpkin Seeds with Ginger (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Roasted Pumpkin Seeds with Ginger', 'SNACK', 3, 3, 2,
    'Pumpkin seeds provide magnesium, zinc, and healthy fats; ground ginger adds a traditional warming spice.', NULL, NULL, 'Golden-green pumpkin seeds', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'snack'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Pumpkin seeds', '1/2 cup'), (m, 'Olive oil', '1 tsp'), (m, 'Ground ginger', '1/4 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 180C/350F.'), (m, 1, 'Toss pumpkin seeds with olive oil and ground ginger.'), (m, 2, 'Spread on a baking sheet and roast for 12-15 minutes, until golden.');

  --------------------------------------------------------------------
  -- Green Tea and Mixed Nuts (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Green Tea and Mixed Nuts', 'SNACK', 3, 1, 2,
    'Green tea contains catechins studied for antioxidant activity; nuts provide healthy fats and fiber in a portion-controlled snack.', NULL, NULL, 'Pale green tea, tan and green-flecked pistachio mix', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick'), (m, 'snack'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Green tea bag', '1'), (m, 'Mixed nuts (almonds, walnuts, pistachios)', '2 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Brew green tea according to package instructions.'), (m, 1, 'Serve alongside a small portion of mixed nuts.');

  --------------------------------------------------------------------
  -- Kefir Green Smoothie with Mango and Ginger (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Kefir Green Smoothie with Mango and Ginger', 'SNACK', 3, 1, 2,
    'Same probiotic-diversity and texture rationale as the kefir breakfast smoothie, in a savory-leaning, ginger-forward version for a snack rather than a full meal.', 'Spinach -> kale or Swiss chard', 'Spinach: Frozen works well once thawed and squeezed dry, fine for anything cooked (scrambles, curries, stews); use fresh if the recipe calls for it raw or barely wilted.', 'Green-gold smoothie with flecks of spinach', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'quick'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free (contains dairy)');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Kefir', '1 cup'), (m, 'Mango, diced', '1/2 cup'), (m, 'Spinach', '1/2 cup'), (m, 'Fresh ginger', '1/2 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Combine kefir, mango, spinach, and ginger in a blender.'), (m, 1, 'Blend until smooth.');

  --------------------------------------------------------------------
  -- Whipped Coconut Cream with Cinnamon and Pomegranate (Yogurt-Free) (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Whipped Coconut Cream with Cinnamon and Pomegranate (Yogurt-Free)', 'SNACK', 2, 1, 1,
    'Whipped chilled coconut cream has a light, mousse-like texture with none of yogurt''s tang, for people who dislike yogurt specifically rather than dairy in general; still pairs with the same cinnamon and pomegranate as the yogurt snack version.', NULL, NULL, 'White whipped cream studded with ruby pomegranate', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'gluten-free'), (m, 'meal-prep'), (m, 'no-cook'), (m, 'quick'), (m, 'snack'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Full-fat coconut milk, chilled overnight', '1 can'), (m, 'Honey or maple syrup', '1 tsp'), (m, 'Cinnamon', '1/4 tsp'), (m, 'Pomegranate seeds', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Scoop out only the solid cream from the top of the chilled coconut milk can.'), (m, 1, 'Whip briefly with a fork or whisk until light.'), (m, 2, 'Top with honey or maple syrup, cinnamon, and pomegranate seeds.');

  --------------------------------------------------------------------
  -- Turmeric Deviled Eggs (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Turmeric Deviled Eggs', 'SNACK', 3, 3, 0,
    'Eggs are a portable source of complete protein; turmeric adds color and its characteristic anti-inflammatory compound, curcumin.', NULL, NULL, 'Golden-yellow filling, white egg, red paprika dusting', 15,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'high-protein'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Eggs, hard-boiled', '4'), (m, 'Turmeric', '1/4 tsp'), (m, 'Mayonnaise (or Greek yogurt)', '2 tbsp'), (m, 'Paprika', 'pinch');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Halve the hard-boiled eggs and scoop out the yolks.'), (m, 1, 'Mash yolks with mayonnaise (or Greek yogurt) and turmeric until smooth.'), (m, 2, 'Spoon the mixture back into the egg whites.'), (m, 3, 'Dust with paprika before serving.');

  --------------------------------------------------------------------
  -- Smoked Salmon and Cucumber Bites with Dill (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Smoked Salmon and Cucumber Bites with Dill', 'SNACK', 4, 2, 1,
    'A no-cook snack pairing omega-3-rich smoked salmon with hydrating, antioxidant-containing cucumber.', 'Cucumber -> zucchini or celery', 'Cucumber: Fresh only, cucumber breaks down and turns watery once frozen.', 'Deep pink salmon, pale green cucumber, green dill', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'gluten-free'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick'), (m, 'snack');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Cucumber, sliced into rounds', '1/2'), (m, 'Smoked salmon', '60 g'), (m, 'Fresh dill sprigs', '6'), (m, 'Lemon wedge', '1');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Arrange cucumber rounds on a plate.'), (m, 1, 'Top each round with a small piece of smoked salmon.'), (m, 2, 'Add a sprig of dill to each.'), (m, 3, 'Finish with a squeeze of lemon.');

  --------------------------------------------------------------------
  -- Turkey and Cucumber Roll-Ups with Mustard (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Turkey and Cucumber Roll-Ups with Mustard', 'SNACK', 2, 2, 1,
    'Lean turkey breast provides a portable, minimally processed protein snack; whole grain mustard adds flavor without added sugar.', 'Cucumber -> zucchini or celery', 'Cucumber: Fresh only, cucumber breaks down and turns watery once frozen.', 'Pale turkey, pale green cucumber', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'gluten-free'), (m, 'no-cook'), (m, 'quick'), (m, 'snack');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Sliced turkey breast', '6 slices'), (m, 'Whole grain mustard', '1 tbsp'), (m, 'Cucumber, cut into sticks', '1');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Spread a thin layer of mustard on each turkey slice.'), (m, 1, 'Wrap a turkey slice around each cucumber stick.'), (m, 2, 'Secure with a toothpick if needed.');

  --------------------------------------------------------------------
  -- Hard-Boiled Eggs with Everything Seasoning (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Hard-Boiled Eggs with Everything Seasoning', 'SNACK', 2, 3, 0,
    'A simple, portable protein snack with a small amount of seasoning rather than a processed dip or sauce.', NULL, NULL, 'White and gold egg, dark seasoning fleck', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'gluten-free'), (m, 'quick'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Eggs', '2'), (m, 'Everything bagel seasoning', '1/2 tsp'), (m, 'Sea salt', 'pinch');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Hard-boil the eggs for 9-10 minutes, then transfer to cold water.'), (m, 1, 'Peel and halve the eggs.'), (m, 2, 'Sprinkle with everything seasoning and sea salt before serving.');

  --------------------------------------------------------------------
  -- Chicken and Avocado Lettuce Cups (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Chicken and Avocado Lettuce Cups', 'SNACK', 3, 2, 2,
    'Using lettuce leaves instead of a wrap or cracker keeps this a whole-food snack; chicken adds lean protein and avocado adds healthy fat.', 'Lettuce -> butter lettuce leaves or cabbage leaves', 'Lettuce: Fresh only, lettuce doesn''t freeze.', 'Golden chicken, green avocado and lettuce', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'dairy-free'), (m, 'gluten-free'), (m, 'quick'), (m, 'snack');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Gluten-free'), (m, 'dairy-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Cooked chicken, shredded', '100 g'), (m, 'Lime juice', '1 tsp'), (m, 'Cilantro, chopped', '1 tbsp'), (m, 'Lettuce leaves', '4'), (m, 'Avocado, diced', '1/2');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Toss shredded chicken with lime juice and cilantro.'), (m, 1, 'Spoon the chicken mixture into lettuce leaves.'), (m, 2, 'Top with diced avocado before serving.');

  --------------------------------------------------------------------
  -- Mixed Berries with Walnuts and Greek Yogurt (Non-Vegan Alt) (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Mixed Berries with Walnuts and Greek Yogurt (Non-Vegan Alt)', 'SNACK', 4, 1, 3,
    'A spoonful of Greek yogurt adds protein to the same berries and walnuts.', NULL, NULL, 'Red, blue, and purple berries, tan walnuts, white yogurt', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Mixed berries', '1 cup'), (m, 'Walnuts', '2 tbsp'), (m, 'Greek yogurt', '2 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Combine mixed berries and walnuts in a small bowl.'), (m, 1, 'Top with a spoonful of Greek yogurt.');

  --------------------------------------------------------------------
  -- Hummus and Egg Plate with Carrot, Cucumber, and Red Pepper (Non-Vegan Alt) (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Hummus and Egg Plate with Carrot, Cucumber, and Red Pepper (Non-Vegan Alt)', 'SNACK', 4, 3, 4,
    'A hard-boiled egg adds extra protein alongside the same hummus and vegetable sticks.', 'Carrot -> parsnip or sweet potato; Cucumber -> zucchini or celery', 'Carrot: Both work. Frozen sliced or diced carrot is fine in soups, stews, and curries; fresh is better for raw or roasted dishes where texture matters. Cucumber: Fresh only, cucumber breaks down and turns watery once frozen.', 'Orange carrot, green cucumber, red pepper, white and gold egg against golden hummus', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'high-protein'), (m, 'quick'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Hummus', '1/3 cup'), (m, 'Egg, hard-boiled', '1'), (m, 'Carrot, cut into sticks', '1/2'), (m, 'Cucumber, cut into sticks', '1/2'), (m, 'Red bell pepper, cut into sticks', '1/2');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Spoon hummus into a small bowl.'), (m, 1, 'Halve the hard-boiled egg and place alongside the hummus.'), (m, 2, 'Arrange carrot, cucumber, and red pepper sticks around the plate.');

  --------------------------------------------------------------------
  -- Turmeric Roasted Chickpeas with Parmesan (Non-Vegan Alt) (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Turmeric Roasted Chickpeas with Parmesan (Non-Vegan Alt)', 'SNACK', 5, 3, 4,
    'A dusting of parmesan after roasting adds a savory, salty finish and a small amount of dairy protein.', NULL, NULL, 'Golden-orange roasted chickpeas, dusted white parmesan', 30,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'anti-inflammatory'), (m, 'gluten-free'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chickpeas, drained', '1 cup'), (m, 'Olive oil', '1 tbsp'), (m, 'Turmeric', '1/2 tsp'), (m, 'Black pepper', 'pinch'), (m, 'Smoked paprika', '1/4 tsp'), (m, 'Parmesan, grated', '2 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 200C/400F.'), (m, 1, 'Pat chickpeas dry and toss with olive oil, turmeric, black pepper, and smoked paprika.'), (m, 2, 'Spread on a baking sheet and roast for 25-30 minutes, stirring occasionally, until crisp.'), (m, 3, 'Toss with grated parmesan while still warm.');

  --------------------------------------------------------------------
  -- Apple Slices with Almond Butter, Cinnamon, and Cheddar (Non-Vegan Alt) (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Apple Slices with Almond Butter, Cinnamon, and Cheddar (Non-Vegan Alt)', 'SNACK', 3, 1, 3,
    'A few thin cheddar slices alongside the same apple and almond butter add extra protein and a classic sweet-savory pairing.', NULL, NULL, 'Red-green apple, cream almond butter, pale yellow cheddar', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'no-cook'), (m, 'quick'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Apple, sliced', '1'), (m, 'Almond butter', '2 tbsp'), (m, 'Cinnamon', 'pinch'), (m, 'Cheddar cheese, sliced', '30 g');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Slice the apple and cheddar.'), (m, 1, 'Arrange both on a plate alongside almond butter for dipping.'), (m, 2, 'Dust lightly with cinnamon.');

  --------------------------------------------------------------------
  -- Edamame and Soft-Boiled Egg with Sea Salt and Chili Flakes (Non-Vegan Alt) (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Edamame and Soft-Boiled Egg with Sea Salt and Chili Flakes (Non-Vegan Alt)', 'SNACK', 3, 3, 3,
    'A soft-boiled egg alongside the same edamame adds extra complete protein.', 'Edamame -> green peas or snap peas', 'Edamame: Frozen is the standard and easiest way to buy edamame; fresh in the pod is rare in most stores.', 'Bright green edamame, golden egg yolk', 10,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'quick'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Edamame, in pods', '1 cup'), (m, 'Egg', '1'), (m, 'Sea salt', 'pinch'), (m, 'Chili flakes', 'pinch');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Steam or boil edamame pods for 4-5 minutes.'), (m, 1, 'Soft-boil the egg for 6-7 minutes, then halve.'), (m, 2, 'Serve edamame alongside the soft-boiled egg, sprinkled with sea salt and chili flakes.');

  --------------------------------------------------------------------
  -- Walnut, Date, and Honey Energy Balls (Non-Vegan Alt) (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Walnut, Date, and Honey Energy Balls (Non-Vegan Alt)', 'SNACK', 4, 1, 3,
    'Honey in place of relying solely on dates for sweetness; the same walnuts and cacao stay for polyphenols and healthy fat.', NULL, NULL, 'Deep brown balls flecked with tan walnut pieces', 15,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'omega-3'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Dates, pitted', '1 cup'), (m, 'Walnuts', '1/2 cup'), (m, 'Cinnamon', '1/2 tsp'), (m, 'Cacao powder', '1 tbsp'), (m, 'Honey', '1 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Blend pitted dates and walnuts in a food processor until a sticky dough forms.'), (m, 1, 'Add cinnamon, cacao powder, and honey, and blend to combine.'), (m, 2, 'Roll the mixture into small balls, about 12.'), (m, 3, 'Refrigerate for at least 30 minutes before serving; makes about 12 balls.');

  --------------------------------------------------------------------
  -- Chia Seed Pudding Cup with Milk, Honey, and Mixed Berries (Non-Vegan Alt) (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Chia Seed Pudding Cup with Milk, Honey, and Mixed Berries (Non-Vegan Alt)', 'SNACK', 3, 1, 4,
    'Whole milk and honey in place of plant milk and a vegan sweetener, same portable single-serve format.', NULL, NULL, 'Creamy pudding topped with red and blue berries', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'meal-prep'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free (needs soak time)');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Chia seeds', '3 tbsp'), (m, 'Whole milk', '1 cup'), (m, 'Vanilla extract', '1/4 tsp'), (m, 'Honey', '1 tsp'), (m, 'Mixed berries', '1/2 cup');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Stir chia seeds into whole milk with vanilla extract and honey in a small jar.'), (m, 1, 'Cover and refrigerate overnight.'), (m, 2, 'Top with mixed berries before eating.');

  --------------------------------------------------------------------
  -- Roasted Pumpkin Seeds with Ginger and Parmesan (Non-Vegan Alt) (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Roasted Pumpkin Seeds with Ginger and Parmesan (Non-Vegan Alt)', 'SNACK', 3, 3, 2,
    'A dusting of parmesan after roasting adds a savory finish and a small amount of dairy protein.', NULL, NULL, 'Golden-green pumpkin seeds, dusted white parmesan', 20,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Pumpkin seeds', '1/2 cup'), (m, 'Olive oil', '1 tsp'), (m, 'Ground ginger', '1/4 tsp'), (m, 'Parmesan, grated', '2 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Preheat oven to 180C/350F.'), (m, 1, 'Toss pumpkin seeds with olive oil and ground ginger.'), (m, 2, 'Spread on a baking sheet and roast for 12-15 minutes, until golden.'), (m, 3, 'Toss with grated parmesan while still warm.');

  --------------------------------------------------------------------
  -- Green Tea with Honey-Drizzled Mixed Nuts (Non-Vegan Alt) (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Green Tea with Honey-Drizzled Mixed Nuts (Non-Vegan Alt)', 'SNACK', 3, 1, 2,
    'A light honey drizzle over the same nuts for a touch of sweetness.', NULL, NULL, 'Pale green tea, tan nuts with a light honey sheen', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'no-cook'), (m, 'quick'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Green tea bag', '1'), (m, 'Mixed nuts', '2 tbsp'), (m, 'Honey', '1/2 tsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Brew green tea according to package instructions.'), (m, 1, 'Lightly drizzle mixed nuts with honey.'), (m, 2, 'Serve nuts alongside the tea.');

  --------------------------------------------------------------------
  -- Apple Slices with Greek Yogurt and Cinnamon (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Apple Slices with Greek Yogurt and Cinnamon', 'SNACK', 3, 1, 3,
    'Greek yogurt adds a substantial protein hit alongside the fiber and polyphenols in the apple; a simpler, dairy-forward alternative to the almond butter version.', NULL, NULL, 'Red-green apple slices, white yogurt, dusted cinnamon', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'no-cook'), (m, 'quick'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Apple, sliced', '1'), (m, 'Greek yogurt', '1/2 cup'), (m, 'Cinnamon', 'pinch');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Slice the apple.'), (m, 1, 'Spoon Greek yogurt into a small bowl and dust with cinnamon.'), (m, 2, 'Serve apple slices alongside the yogurt for dipping.');

  --------------------------------------------------------------------
  -- Peanut Butter and Banana Rice Cakes (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Peanut Butter and Banana Rice Cakes', 'SNACK', 2, 1, 2,
    'Peanut butter is a widely available, budget-friendly alternative to almond butter with a similar healthy-fat and protein profile; banana adds potassium and natural sweetness.', NULL, NULL, 'Pale rice cake, cream peanut butter, pale yellow banana', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'no-cook'), (m, 'quick'), (m, 'snack'), (m, 'vegan');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegan'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Brown rice cakes', '2'), (m, 'Peanut butter', '2 tbsp'), (m, 'Banana, sliced', '1/2'), (m, 'Cinnamon', 'pinch');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Spread peanut butter evenly over each rice cake.'), (m, 1, 'Top with banana slices.'), (m, 2, 'Dust lightly with cinnamon.');

  --------------------------------------------------------------------
  -- Cottage Cheese with Berries and Flaxseed (SNACK)
  --------------------------------------------------------------------
  m := gen_random_uuid();
  INSERT INTO meals (
    id, name, meal_type, anti_inflammatory_score, iron_support, fiber_score,
    why_it_helps, vegetable_substitutes, fresh_or_frozen, color_palette, prep_time_minutes,
    created_at
  ) VALUES (
    m, 'Cottage Cheese with Berries and Flaxseed', 'SNACK', 3, 2, 2,
    'Cottage cheese is a particularly protein-dense dairy option, higher in protein per calorie than most yogurts; paired with berries and flaxseed for antioxidants and omega-3.', NULL, NULL, 'White cottage cheese, red and blue berries, brown flax flecks', 5,
    now()
  );
  INSERT INTO meal_tags (meal_id, tag) VALUES (m, 'gluten-free'), (m, 'no-cook'), (m, 'omega-3'), (m, 'quick'), (m, 'snack'), (m, 'vegetarian');
  INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES (m, 'Vegetarian'), (m, 'gluten-free');
  INSERT INTO meal_ingredients (meal_id, name, amount) VALUES (m, 'Cottage cheese', '1 cup'), (m, 'Mixed berries', '1/2 cup'), (m, 'Ground flaxseed', '1 tbsp');
  INSERT INTO meal_instructions (meal_id, step_order, instruction) VALUES (m, 0, 'Spoon cottage cheese into a bowl.'), (m, 1, 'Top with mixed berries.'), (m, 2, 'Sprinkle with ground flaxseed.');

END $$;
