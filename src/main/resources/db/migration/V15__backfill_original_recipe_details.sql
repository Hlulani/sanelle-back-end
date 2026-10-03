-- Backfill why_it_helps / color_palette / prep_time_minutes / vegetable_substitutes / fresh_or_frozen
-- and dietary tags for the original ~62-meal seed batch (V4), which predates the V12 columns and
-- V13 104-recipe batch that shipped with this content from the start. Grounded in each meal's
-- real, already-seeded ingredients/instructions/scores. Meals are matched by name because the
-- seed migrations assign random ids.

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Oats supply soluble fiber to support steady digestion, and walnuts add anti-inflammatory omega-3 fats alongside a touch of cinnamon.',
  color_palette = 'Creamy oats with golden apple and toasted walnut pieces',
  vegetable_substitutes = 'Apple -> pear',
  fresh_or_frozen = 'Apple: best fresh for texture; not recommended frozen for this dish.'
WHERE name = 'Apple Cinnamon Oatmeal';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Apple Cinnamon Oatmeal';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Apple Cinnamon Oatmeal';

UPDATE meals SET
  prep_time_minutes = 3,
  why_it_helps = 'Apple fiber pairs with almond butter healthy fats and protein for a snack that helps keep energy steady between meals.',
  color_palette = 'Crisp red-green apple slices with pale almond butter',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Apple with Almond Butter';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Apple with Almond Butter';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Apple with Almond Butter';

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Avocado provides anti-inflammatory monounsaturated fat, and cherry tomatoes add vitamin C and lycopene.',
  color_palette = 'Golden toast, bright green avocado, red cherry tomatoes',
  vegetable_substitutes = 'Cherry tomatoes -> diced regular tomato',
  fresh_or_frozen = 'Tomatoes: fresh is best for this dish; frozen tomatoes turn watery once thawed.'
WHERE name = 'Avocado Tomato Toast';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Avocado Tomato Toast';

UPDATE meals SET
  prep_time_minutes = 5,
  why_it_helps = 'Avocado healthy fats and yogurt protein and probiotics make this a gut-friendly, satisfying snack.',
  color_palette = 'Creamy pale-green dip with crisp cucumber rounds',
  vegetable_substitutes = 'Cucumber -> celery or bell pepper sticks',
  fresh_or_frozen = 'Cucumber: fresh only - cucumber turns watery and limp when frozen.'
WHERE name = 'Avocado Yogurt Dip Plate';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Avocado Yogurt Dip Plate';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Avocado Yogurt Dip Plate';

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Cod is a lean source of protein and iron, and spinach adds anti-inflammatory antioxidants and vitamin K.',
  color_palette = 'White fish fillet with a bed of dark green sauteed spinach',
  vegetable_substitutes = 'Spinach -> kale or Swiss chard',
  fresh_or_frozen = 'Spinach: frozen works well once thawed and squeezed dry; use fresh if serving barely wilted.'
WHERE name = 'Baked Cod with Lemon and Greens';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Baked Cod with Lemon and Greens';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Baked Cod with Lemon and Greens';

UPDATE meals SET
  prep_time_minutes = 30,
  why_it_helps = 'Salmon is rich in anti-inflammatory omega-3s, and sweet potato adds fiber and beta-carotene.',
  color_palette = 'Pink salmon fillet beside golden-orange roasted sweet potato',
  vegetable_substitutes = 'Sweet potato -> butternut squash',
  fresh_or_frozen = 'Sweet potato: fresh is best for roasting; frozen sweet potato works in soups but turns mushy when roasted.'
WHERE name = 'Baked Salmon with Sweet Potato';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Baked Salmon with Sweet Potato';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Baked Salmon with Sweet Potato';

UPDATE meals SET
  prep_time_minutes = 30,
  why_it_helps = 'Tofu provides plant protein and iron, while broccoli and carrots add fiber and anti-inflammatory antioxidants.',
  color_palette = 'Golden-brown tofu cubes with vibrant green broccoli and orange carrots',
  vegetable_substitutes = 'Broccoli -> cauliflower; Carrots -> parsnip',
  fresh_or_frozen = 'Broccoli: frozen works well once cooked through; fresh is better for roasting until crisp-edged. Carrots: both work well, including from frozen.'
WHERE name = 'Baked Tofu with Roasted Veggies';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Baked Tofu with Roasted Veggies';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Baked Tofu with Roasted Veggies';

UPDATE meals SET
  prep_time_minutes = 2,
  why_it_helps = 'Banana offers quick, easily digested energy along with potassium, and cinnamon may help support balanced blood sugar.',
  color_palette = 'Bright yellow banana dusted with warm brown cinnamon',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Banana Cinnamon Snack';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Banana Cinnamon Snack';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Banana Cinnamon Snack';

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Black beans and corn together provide fiber and plant protein, and lime and cilantro add brightness and antioxidants.',
  color_palette = 'Black beans, yellow corn, and red tomato flecked with green cilantro',
  vegetable_substitutes = 'Tomatoes -> bell pepper',
  fresh_or_frozen = 'Corn: frozen or canned both work well; fresh is best in season.'
WHERE name = 'Bean and Corn Salsa Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Bean and Corn Salsa Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Bean and Corn Salsa Bowl';

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Two kinds of beans deliver fiber and plant protein, and tomato and chili powder both bring anti-inflammatory antioxidants.',
  color_palette = 'Deep red-brown chili with dark red beans',
  vegetable_substitutes = 'Onion -> shallot or leek',
  fresh_or_frozen = 'Onion: fresh is standard; frozen diced onion works fine in a simmered dish like this one.'
WHERE name = 'Bean Chili (Quick)';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Bean Chili (Quick)';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Bean Chili (Quick)';

UPDATE meals SET
  prep_time_minutes = 5,
  why_it_helps = 'Tuna adds lean protein and iron, and kidney beans contribute fiber for a filling, no-cook lunch.',
  color_palette = 'Pale tuna and deep red kidney beans dressed in olive oil',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Bean Tuna Salad';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Bean Tuna Salad';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Bean Tuna Salad';

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Lean beef is a strong source of iron, and bell pepper and spinach add anti-inflammatory vitamins and antioxidants.',
  color_palette = 'Browned beef with red bell pepper and wilted green spinach',
  vegetable_substitutes = 'Bell pepper -> zucchini; Spinach -> kale',
  fresh_or_frozen = 'Bell pepper: both work, frozen sliced pepper is fine cooked into a skillet. Spinach: frozen works well once thawed and squeezed dry.'
WHERE name = 'Beef and Veggie Skillet';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Beef and Veggie Skillet';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Beef and Veggie Skillet';

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Beef strips deliver a strong dose of iron, and spinach adds anti-inflammatory antioxidants on top of the rice base.',
  color_palette = 'White rice, browned beef strips, and dark green wilted spinach',
  vegetable_substitutes = 'Spinach -> kale or Swiss chard',
  fresh_or_frozen = 'Spinach: frozen works well once thawed and squeezed dry; use fresh if serving barely wilted.'
WHERE name = 'Beef Spinach Rice Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Beef Spinach Rice Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Beef Spinach Rice Bowl';

UPDATE meals SET
  prep_time_minutes = 5,
  why_it_helps = 'Berries and spinach together deliver a strong dose of antioxidants, and Greek yogurt adds protein and probiotics.',
  color_palette = 'Deep purple-green smoothie flecked with berry color',
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix',
  fresh_or_frozen = 'Berries and spinach: frozen works just as well as fresh here, and gives a thicker blended texture.'
WHERE name = 'Berry Spinach Smoothie';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Berry Spinach Smoothie';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Berry Spinach Smoothie';

UPDATE meals SET
  prep_time_minutes = 12,
  why_it_helps = 'Eggs are a complete, easy-to-digest source of protein and iron in a simple, portable snack.',
  color_palette = 'White eggshell halves with golden-yellow yolks',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Boiled Eggs with Salt';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Boiled Eggs with Salt';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Boiled Eggs with Salt';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Boiled Eggs with Salt';

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Chicken provides lean protein and iron, and avocado adds anti-inflammatory healthy fats to this fresh salad.',
  color_palette = 'Shredded chicken and green avocado over crisp lettuce',
  vegetable_substitutes = 'Lettuce -> baby spinach or arugula',
  fresh_or_frozen = 'Lettuce: fresh only - lettuce does not hold up to freezing.'
WHERE name = 'Chicken Avocado Salad';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Chicken Avocado Salad';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Chicken Avocado Salad';

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Chicken and stock provide protein and iron, and carrot adds a mild dose of fiber and beta-carotene.',
  color_palette = 'Golden broth with pale chicken, rice, and orange carrot',
  vegetable_substitutes = 'Carrot -> parsnip',
  fresh_or_frozen = 'Carrot: both work, frozen sliced carrot is fine in soups; fresh is better where texture matters.'
WHERE name = 'Chicken Rice Soup';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Chicken Rice Soup';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Chicken Rice Soup';

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'This broth-based soup pairs lean chicken protein with carrot and celery for a light, easy-to-digest anti-inflammatory meal.',
  color_palette = 'Golden broth with orange carrot and pale green celery',
  vegetable_substitutes = 'Carrot -> parsnip; Celery -> fennel',
  fresh_or_frozen = 'Carrot and celery: both work well from frozen in a simmered soup like this.'
WHERE name = 'Chicken Veggie Soup';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Chicken Veggie Soup';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Chicken Veggie Soup';

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Chickpeas bring fiber and plant protein, and turmeric-forward curry powder alongside spinach adds anti-inflammatory support.',
  color_palette = 'Golden-yellow coconut curry with deep green spinach',
  vegetable_substitutes = 'Spinach -> kale or Swiss chard',
  fresh_or_frozen = 'Spinach: frozen works well once thawed and squeezed dry; use fresh if serving barely wilted.'
WHERE name = 'Chickpea Coconut Curry';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Chickpea Coconut Curry';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Chickpea Coconut Curry';

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Chickpeas provide fiber and plant protein, and the fresh vegetables add vitamin C and antioxidants.',
  color_palette = 'Cream chickpeas with red tomato, green cucumber, and purple red onion',
  vegetable_substitutes = 'Cucumber -> bell pepper; Tomatoes -> cherry tomatoes',
  fresh_or_frozen = 'Cucumber and tomatoes: fresh only, both turn watery once frozen and thawed.'
WHERE name = 'Chickpea Salad with Lemon Dressing';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Chickpea Salad with Lemon Dressing';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Chickpea Salad with Lemon Dressing';

UPDATE meals SET
  prep_time_minutes = 5,
  why_it_helps = 'Chia seeds are a strong source of fiber and anti-inflammatory omega-3s, made into an easy make-ahead pudding.',
  color_palette = 'Speckled cream pudding with a dusting of brown cinnamon',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Cinnamon Chia Pudding';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Cinnamon Chia Pudding';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Cinnamon Chia Pudding';

UPDATE meals SET
  prep_time_minutes = 3,
  why_it_helps = 'Cottage cheese provides protein, and pineapple adds vitamin C along with bromelain, an enzyme with mild anti-inflammatory properties.',
  color_palette = 'Creamy white cottage cheese with golden pineapple chunks',
  vegetable_substitutes = 'Pineapple -> mango',
  fresh_or_frozen = 'Pineapple: fresh or frozen both work well; frozen is convenient and just as nutritious.'
WHERE name = 'Cottage Cheese and Pineapple Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Cottage Cheese and Pineapple Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Cottage Cheese and Pineapple Bowl';

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Cucumber is hydrating and light, while feta adds protein and a dose of calcium.',
  color_palette = 'Pale green cucumber with crumbled white feta',
  vegetable_substitutes = 'Cucumber -> zucchini ribbons',
  fresh_or_frozen = 'Cucumber: fresh only - cucumber turns watery and limp when frozen.'
WHERE name = 'Cucumber Feta Salad';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Cucumber Feta Salad';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Cucumber Feta Salad';

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Tuna adds lean protein and iron to crisp, hydrating cucumber rounds for a light snack.',
  color_palette = 'Pale green cucumber rounds topped with light pink tuna',
  vegetable_substitutes = 'Cucumber -> celery',
  fresh_or_frozen = 'Cucumber: fresh only - cucumber turns watery and limp when frozen.'
WHERE name = 'Cucumber Tuna Bites';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Cucumber Tuna Bites';

UPDATE meals SET
  prep_time_minutes = 6,
  why_it_helps = 'Edamame is a plant-based source of protein and fiber, with isoflavones that may offer mild anti-inflammatory benefits.',
  color_palette = 'Bright green edamame pods dusted with sea salt',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Edamame with Sea Salt';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Edamame with Sea Salt';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Edamame with Sea Salt';

UPDATE meals SET
  prep_time_minutes = 12,
  why_it_helps = 'Eggs provide complete protein and iron, and swapping mayonnaise for Greek yogurt keeps this lighter while adding probiotics.',
  color_palette = 'Pale yellow egg salad cupped in crisp green lettuce',
  vegetable_substitutes = 'Lettuce -> cabbage leaves',
  fresh_or_frozen = 'Lettuce: fresh only - lettuce does not hold up to freezing.'
WHERE name = 'Egg Salad Lettuce Cups';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Egg Salad Lettuce Cups';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Egg Salad Lettuce Cups';

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Chicken breast offers lean protein and iron, and broccoli and garlic both bring anti-inflammatory compounds.',
  color_palette = 'Golden chicken breast beside bright green broccoli',
  vegetable_substitutes = 'Broccoli -> cauliflower or green beans',
  fresh_or_frozen = 'Broccoli: frozen works well once cooked through; fresh is better for a crisp-tender sautee.'
WHERE name = 'Garlic Lemon Chicken with Broccoli';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Garlic Lemon Chicken with Broccoli';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Garlic Lemon Chicken with Broccoli';

UPDATE meals SET
  prep_time_minutes = 3,
  why_it_helps = 'Greek yogurt provides protein and probiotics, and chia seeds add a dose of fiber and omega-3s.',
  color_palette = 'Creamy white yogurt topped with dark chia seeds and a honey drizzle',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Greek Yogurt Snack Cup';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Greek Yogurt Snack Cup';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Greek Yogurt Snack Cup';

UPDATE meals SET
  prep_time_minutes = 3,
  why_it_helps = 'Greek yogurt provides protein and probiotics, and mixed nuts add anti-inflammatory healthy fats.',
  color_palette = 'Creamy white yogurt topped with golden-brown nuts',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Greek Yogurt with Nuts and Honey';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Greek Yogurt with Nuts and Honey';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Greek Yogurt with Nuts and Honey';

UPDATE meals SET
  prep_time_minutes = 5,
  why_it_helps = 'Hummus provides plant protein and fiber from chickpeas, and carrots add a dose of beta-carotene.',
  color_palette = 'Cream hummus with bright orange carrot sticks',
  vegetable_substitutes = 'Carrots -> cucumber or bell pepper sticks',
  fresh_or_frozen = 'Carrots: fresh is best for dipping sticks; frozen carrot is better saved for cooked dishes.'
WHERE name = 'Hummus and Carrot Sticks';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Hummus and Carrot Sticks';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Hummus and Carrot Sticks';

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Lentils are rich in fiber, iron, and plant protein, and tomato and garlic add anti-inflammatory antioxidants.',
  color_palette = 'Deep red tomato sauce with brown-green lentils',
  vegetable_substitutes = 'Onion -> shallot',
  fresh_or_frozen = NULL
WHERE name = 'Lentil Bolognese';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Lentil Bolognese';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Lentil Bolognese';

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Lentils provide fiber, iron, and plant protein, and carrot and garlic round out this warming, anti-inflammatory soup.',
  color_palette = 'Golden-brown broth with orange carrot and soft lentils',
  vegetable_substitutes = 'Carrot -> parsnip',
  fresh_or_frozen = 'Carrot: both work well from frozen in a simmered soup like this.'
WHERE name = 'Lentil Soup (Quick)';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Lentil Soup (Quick)';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Lentil Soup (Quick)';

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Mackerel is a strong source of anti-inflammatory omega-3s and iron, paired with filling boiled potatoes.',
  color_palette = 'Silvery mackerel fillets beside pale golden potatoes',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Mackerel Potato Plate';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Mackerel Potato Plate';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Mackerel Potato Plate';

UPDATE meals SET
  prep_time_minutes = 12,
  why_it_helps = 'Tomatoes and olives bring anti-inflammatory antioxidants and healthy fats to this Mediterranean-style pasta.',
  color_palette = 'Pale pasta with dark olives, red tomato, and white feta',
  vegetable_substitutes = 'Tomatoes -> cherry tomatoes',
  fresh_or_frozen = NULL
WHERE name = 'Mediterranean Pasta Salad';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Mediterranean Pasta Salad';

UPDATE meals SET
  prep_time_minutes = 12,
  why_it_helps = 'Oats and banana together provide fiber for steady digestion, and eggs add complete protein.',
  color_palette = 'Golden-brown pancakes with pale banana',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Oat Banana Pancakes (2-Ingredient)';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Oat Banana Pancakes (2-Ingredient)';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Oat Banana Pancakes (2-Ingredient)';

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Oats supply soluble fiber, and cocoa powder adds antioxidant flavonoids alongside banana natural sweetness.',
  color_palette = 'Deep brown oats topped with pale banana slices',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Oats with Cocoa and Banana';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Oats with Cocoa and Banana';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Oats with Cocoa and Banana';

UPDATE meals SET
  prep_time_minutes = 25,
  why_it_helps = 'Chicken thighs offer protein and iron, and paprika and bell pepper both bring antioxidants to this one-pan dinner.',
  color_palette = 'Golden-red paprika chicken with red bell pepper and onion',
  vegetable_substitutes = 'Bell pepper -> zucchini',
  fresh_or_frozen = 'Bell pepper: both work, frozen sliced pepper is fine cooked into a skillet.'
WHERE name = 'One-Pan Paprika Chicken';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'One-Pan Paprika Chicken';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'One-Pan Paprika Chicken';

UPDATE meals SET
  prep_time_minutes = 5,
  why_it_helps = 'Oats and chia seeds together deliver a strong dose of fiber, and berries add anti-inflammatory antioxidants.',
  color_palette = 'Creamy oats layered with deep purple-red berries',
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix',
  fresh_or_frozen = 'Berries: fresh or frozen both work well as a topping, straight from the freezer is fine.'
WHERE name = 'Overnight Oats with Chia and Berries';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Overnight Oats with Chia and Berries';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Overnight Oats with Chia and Berries';

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Oats provide soluble fiber, and peanut butter adds protein and healthy fats to keep this breakfast filling.',
  color_palette = 'Creamy oats with golden banana slices and a peanut butter swirl',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Peanut Butter Banana Oat Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Peanut Butter Banana Oat Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Peanut Butter Banana Oat Bowl';

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Peas provide fiber and plant protein, blended into a light, easy-to-digest soup.',
  color_palette = 'Vibrant green pea soup',
  vegetable_substitutes = 'Onion -> leek',
  fresh_or_frozen = NULL
WHERE name = 'Pea Soup (Quick)';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Pea Soup (Quick)';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Pea Soup (Quick)';

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Quinoa is a complete plant protein and fiber source, paired here with lean chicken for extra protein and iron.',
  color_palette = 'Pale quinoa with chicken and green cucumber',
  vegetable_substitutes = 'Cucumber -> bell pepper',
  fresh_or_frozen = 'Cucumber: fresh only - cucumber turns watery and limp when frozen.'
WHERE name = 'Quinoa Chicken Salad';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Quinoa Chicken Salad';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Quinoa Chicken Salad';

UPDATE meals SET
  prep_time_minutes = 30,
  why_it_helps = 'Roasted chickpeas offer fiber and plant protein in a crunchy, shelf-stable snack, with paprika adding antioxidants.',
  color_palette = 'Golden-brown roasted chickpeas dusted with red paprika',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Roasted Chickpeas (Quick)';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Roasted Chickpeas (Quick)';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Roasted Chickpeas (Quick)';

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Roasted zucchini and bell pepper add anti-inflammatory antioxidants to this simple grain bowl.',
  color_palette = 'Pale couscous with golden zucchini and red bell pepper',
  vegetable_substitutes = 'Zucchini -> yellow squash; Bell pepper -> carrot',
  fresh_or_frozen = 'Zucchini and bell pepper: fresh is best for roasting; frozen versions turn softer and release more water.'
WHERE name = 'Roasted Veggie Couscous';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Roasted Veggie Couscous';

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Salmon provides anti-inflammatory omega-3s and protein, and avocado adds more healthy fat to this rice bowl.',
  color_palette = 'White rice, pink salmon, green avocado, and cucumber',
  vegetable_substitutes = 'Cucumber -> shredded carrot',
  fresh_or_frozen = 'Cucumber: fresh only - cucumber turns watery and limp when frozen.'
WHERE name = 'Salmon Rice Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Salmon Rice Bowl';

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Sardines are a strong source of anti-inflammatory omega-3s, calcium, and iron in a quick, no-cook topping.',
  color_palette = 'White rice topped with silvery sardines and cucumber',
  vegetable_substitutes = 'Cucumber -> shredded carrot',
  fresh_or_frozen = 'Cucumber: fresh only - cucumber turns watery and limp when frozen.'
WHERE name = 'Sardine Rice Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Sardine Rice Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Sardine Rice Bowl';

UPDATE meals SET
  prep_time_minutes = 6,
  why_it_helps = 'Sardines deliver anti-inflammatory omega-3s, calcium, and iron on top of a simple slice of toast.',
  color_palette = 'Golden toast topped with silvery sardines',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Sardine Toast with Lemon';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Sardine Toast with Lemon';

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Shrimp provides lean protein and iron, and zucchini noodles keep this dish light while adding fiber.',
  color_palette = 'Pink shrimp over pale green zucchini noodles',
  vegetable_substitutes = 'Zucchini noodles -> spaghetti squash',
  fresh_or_frozen = 'Zucchini: fresh is best for noodles, frozen zucchini releases too much water and turns mushy.'
WHERE name = 'Shrimp Zucchini Noodles';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Shrimp Zucchini Noodles';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Shrimp Zucchini Noodles';

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Lentils provide fiber, iron, and plant protein, and tomato and garlic add anti-inflammatory antioxidants.',
  color_palette = 'Deep red tomato stew with soft brown lentils',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Simple Tomato Lentil Stew';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Simple Tomato Lentil Stew';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Simple Tomato Lentil Stew';

UPDATE meals SET
  prep_time_minutes = 6,
  why_it_helps = 'Smoked salmon adds anti-inflammatory omega-3s and protein to a light, refreshing toast.',
  color_palette = 'Golden toast, pink smoked salmon, and pale green cucumber',
  vegetable_substitutes = 'Cucumber -> radish slices',
  fresh_or_frozen = NULL
WHERE name = 'Smoked Salmon Cucumber Toast';

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Eggs provide complete protein, and spinach adds anti-inflammatory antioxidants and vitamin K to this quick scramble.',
  color_palette = 'Golden scrambled eggs with dark green spinach and white feta',
  vegetable_substitutes = 'Spinach -> kale or Swiss chard',
  fresh_or_frozen = 'Spinach: frozen works well once thawed and squeezed dry; use fresh if serving barely wilted.'
WHERE name = 'Spinach and Feta Scramble';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Spinach and Feta Scramble';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Spinach and Feta Scramble';

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Tofu provides plant protein and iron, and broccoli and carrot add fiber and anti-inflammatory antioxidants.',
  color_palette = 'Golden-brown tofu with green broccoli and orange carrot',
  vegetable_substitutes = 'Broccoli -> cauliflower; Carrot -> bell pepper',
  fresh_or_frozen = 'Broccoli: frozen works well once cooked through; fresh is better for a crisp-tender stir-fry.'
WHERE name = 'Tofu Stir-Fry Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Tofu Stir-Fry Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Tofu Stir-Fry Bowl';

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Eggs provide complete protein, and tomato and basil add vitamin C and antioxidants to this make-ahead breakfast.',
  color_palette = 'Golden egg muffins studded with red tomato and green basil',
  vegetable_substitutes = 'Cherry tomatoes -> diced regular tomato',
  fresh_or_frozen = 'Cherry tomatoes: fresh is best here for texture; frozen tomatoes turn watery once thawed.'
WHERE name = 'Tomato Basil Egg Muffins';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Tomato Basil Egg Muffins';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Tomato Basil Egg Muffins';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Tomato Basil Egg Muffins';

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'White beans provide fiber and plant protein, and tomato, garlic, and basil bring anti-inflammatory antioxidants.',
  color_palette = 'Deep red tomato stew with creamy white beans and fresh basil',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Tomato Basil White Bean Stew';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Tomato Basil White Bean Stew';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Tomato Basil White Bean Stew';

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Eggs provide complete protein, and tomatoes add vitamin C and lycopene in this simple, fast stir-fry.',
  color_palette = 'Golden scrambled eggs in a red tomato sauce',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Tomato Egg Stir Fry';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Tomato Egg Stir Fry';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Tomato Egg Stir Fry';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Tomato Egg Stir Fry';

UPDATE meals SET
  prep_time_minutes = 3,
  why_it_helps = 'Tomato provides vitamin C and lycopene, paired simply with mozzarella for protein and calcium.',
  color_palette = 'Red tomato slices with white mozzarella',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Tomato Mozzarella Snack Plate';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Tomato Mozzarella Snack Plate';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Tomato Mozzarella Snack Plate';

UPDATE meals SET
  prep_time_minutes = 2,
  why_it_helps = 'Nuts and pumpkin seeds provide anti-inflammatory healthy fats, and dried fruit adds a natural dose of sweetness and fiber.',
  color_palette = 'Mixed browns and golds from nuts, seeds, and dried fruit',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Trail Mix Cup';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegan' FROM meals WHERE name = 'Trail Mix Cup';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Trail Mix Cup';

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Tuna provides lean protein and iron, and white beans add fiber for a filling, no-cook lunch.',
  color_palette = 'Pale tuna and creamy white beans flecked with green parsley',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Tuna and White Bean Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Tuna and White Bean Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Tuna and White Bean Bowl';

UPDATE meals SET
  prep_time_minutes = 6,
  why_it_helps = 'Turkey provides lean protein, and hummus adds plant protein and fiber from chickpeas.',
  color_palette = 'Pale wrap with lean turkey, green lettuce, and cucumber',
  vegetable_substitutes = 'Cucumber -> shredded carrot',
  fresh_or_frozen = NULL
WHERE name = 'Turkey Hummus Wrap';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Turkey Hummus Wrap';

UPDATE meals SET
  prep_time_minutes = 25,
  why_it_helps = 'Turkey provides lean protein and iron, and tomato and garlic bring anti-inflammatory antioxidants to the sauce.',
  color_palette = 'Golden-brown meatballs in a deep red tomato sauce',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE name = 'Turkey Meatballs with Tomato Sauce';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Turkey Meatballs with Tomato Sauce';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Turkey Meatballs with Tomato Sauce';

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Eggs add complete protein, and the mixed vegetables bring fiber and a range of anti-inflammatory antioxidants.',
  color_palette = 'Golden fried rice with colorful mixed vegetables',
  vegetable_substitutes = 'Mixed veggies -> peas, carrot, and corn',
  fresh_or_frozen = 'Mixed vegetables: frozen works great here and is the standard choice for fried rice.'
WHERE name = 'Veggie Fried Rice (Egg)';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Veggie Fried Rice (Egg)';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Veggie Fried Rice (Egg)';

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Eggs provide complete protein, and mushrooms and bell pepper add fiber and antioxidants to this quick omelette.',
  color_palette = 'Golden folded omelette with flecks of red pepper and brown mushroom',
  vegetable_substitutes = 'Mushrooms -> zucchini; Bell pepper -> tomato',
  fresh_or_frozen = 'Mushrooms: fresh is recommended, mushrooms turn watery and rubbery when frozen. Bell pepper: both work, frozen sliced pepper is fine cooked into an omelette.'
WHERE name = 'Veggie Omelette';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Veggie Omelette';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Veggie Omelette';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Dairy-free' FROM meals WHERE name = 'Veggie Omelette';

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Quinoa is a complete plant protein and fiber source, and blueberries add a strong dose of antioxidants.',
  color_palette = 'Warm pale quinoa topped with deep blue blueberries and almonds',
  vegetable_substitutes = 'Blueberries -> any frozen berry',
  fresh_or_frozen = 'Blueberries: fresh or frozen both work well as a topping.'
WHERE name = 'Warm Quinoa Breakfast Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Vegetarian' FROM meals WHERE name = 'Warm Quinoa Breakfast Bowl';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) SELECT id, 'Gluten-free' FROM meals WHERE name = 'Warm Quinoa Breakfast Bowl';
