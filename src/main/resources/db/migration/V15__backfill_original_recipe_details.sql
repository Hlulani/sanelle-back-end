-- Backfill why_it_helps / color_palette / prep_time_minutes / vegetable_substitutes / fresh_or_frozen
-- and dietary tags for the original ~62-meal seed batch (V4), which predates the V12 columns and
-- V13 104-recipe batch that shipped with this content from the start. Grounded in each meal's
-- real, already-seeded ingredients/instructions/scores -- see claude session notes for how this was drafted.

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Oats supply soluble fiber to support steady digestion, and walnuts add anti-inflammatory omega-3 fats alongside a touch of cinnamon.',
  color_palette = 'Creamy oats with golden apple and toasted walnut pieces',
  vegetable_substitutes = 'Apple -> pear',
  fresh_or_frozen = 'Apple: best fresh for texture; not recommended frozen for this dish.'
WHERE id = 'a001d1df-e7b4-46c4-b04b-d5b9a9672e93';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('a001d1df-e7b4-46c4-b04b-d5b9a9672e93', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('a001d1df-e7b4-46c4-b04b-d5b9a9672e93', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 3,
  why_it_helps = 'Apple fiber pairs with almond butter healthy fats and protein for a snack that helps keep energy steady between meals.',
  color_palette = 'Crisp red-green apple slices with pale almond butter',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = '0cc82836-e9bf-4d56-b213-668b12fc6cb0';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('0cc82836-e9bf-4d56-b213-668b12fc6cb0', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('0cc82836-e9bf-4d56-b213-668b12fc6cb0', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Avocado provides anti-inflammatory monounsaturated fat, and cherry tomatoes add vitamin C and lycopene.',
  color_palette = 'Golden toast, bright green avocado, red cherry tomatoes',
  vegetable_substitutes = 'Cherry tomatoes -> diced regular tomato',
  fresh_or_frozen = 'Tomatoes: fresh is best for this dish; frozen tomatoes turn watery once thawed.'
WHERE id = '57cae83b-0406-49ee-856c-39feb4850277';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('57cae83b-0406-49ee-856c-39feb4850277', 'Vegan');

UPDATE meals SET
  prep_time_minutes = 5,
  why_it_helps = 'Avocado healthy fats and yogurt protein and probiotics make this a gut-friendly, satisfying snack.',
  color_palette = 'Creamy pale-green dip with crisp cucumber rounds',
  vegetable_substitutes = 'Cucumber -> celery or bell pepper sticks',
  fresh_or_frozen = 'Cucumber: fresh only - cucumber turns watery and limp when frozen.'
WHERE id = '366b5d88-e434-4920-91bb-a2905170a95c';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('366b5d88-e434-4920-91bb-a2905170a95c', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('366b5d88-e434-4920-91bb-a2905170a95c', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Cod is a lean source of protein and iron, and spinach adds anti-inflammatory antioxidants and vitamin K.',
  color_palette = 'White fish fillet with a bed of dark green sauteed spinach',
  vegetable_substitutes = 'Spinach -> kale or Swiss chard',
  fresh_or_frozen = 'Spinach: frozen works well once thawed and squeezed dry; use fresh if serving barely wilted.'
WHERE id = 'f159f0fe-4c54-48f7-8315-209d39a240fc';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('f159f0fe-4c54-48f7-8315-209d39a240fc', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('f159f0fe-4c54-48f7-8315-209d39a240fc', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 30,
  why_it_helps = 'Salmon is rich in anti-inflammatory omega-3s, and sweet potato adds fiber and beta-carotene.',
  color_palette = 'Pink salmon fillet beside golden-orange roasted sweet potato',
  vegetable_substitutes = 'Sweet potato -> butternut squash',
  fresh_or_frozen = 'Sweet potato: fresh is best for roasting; frozen sweet potato works in soups but turns mushy when roasted.'
WHERE id = 'bacf4f76-676d-4d53-bb76-80c831f66e03';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('bacf4f76-676d-4d53-bb76-80c831f66e03', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('bacf4f76-676d-4d53-bb76-80c831f66e03', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 30,
  why_it_helps = 'Tofu provides plant protein and iron, while broccoli and carrots add fiber and anti-inflammatory antioxidants.',
  color_palette = 'Golden-brown tofu cubes with vibrant green broccoli and orange carrots',
  vegetable_substitutes = 'Broccoli -> cauliflower; Carrots -> parsnip',
  fresh_or_frozen = 'Broccoli: frozen works well once cooked through; fresh is better for roasting until crisp-edged. Carrots: both work well, including from frozen.'
WHERE id = 'fdb2bc39-4ac7-4cff-a245-e9c94211f670';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('fdb2bc39-4ac7-4cff-a245-e9c94211f670', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('fdb2bc39-4ac7-4cff-a245-e9c94211f670', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 2,
  why_it_helps = 'Banana offers quick, easily digested energy along with potassium, and cinnamon may help support balanced blood sugar.',
  color_palette = 'Bright yellow banana dusted with warm brown cinnamon',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = '1fe953d0-cedc-4b9e-b2dc-9842cde09ab4';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('1fe953d0-cedc-4b9e-b2dc-9842cde09ab4', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('1fe953d0-cedc-4b9e-b2dc-9842cde09ab4', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Black beans and corn together provide fiber and plant protein, and lime and cilantro add brightness and antioxidants.',
  color_palette = 'Black beans, yellow corn, and red tomato flecked with green cilantro',
  vegetable_substitutes = 'Tomatoes -> bell pepper',
  fresh_or_frozen = 'Corn: frozen or canned both work well; fresh is best in season.'
WHERE id = 'e9bedf4f-c413-46c3-94d8-b66fd7805db2';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('e9bedf4f-c413-46c3-94d8-b66fd7805db2', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('e9bedf4f-c413-46c3-94d8-b66fd7805db2', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Two kinds of beans deliver fiber and plant protein, and tomato and chili powder both bring anti-inflammatory antioxidants.',
  color_palette = 'Deep red-brown chili with dark red beans',
  vegetable_substitutes = 'Onion -> shallot or leek',
  fresh_or_frozen = 'Onion: fresh is standard; frozen diced onion works fine in a simmered dish like this one.'
WHERE id = '3cb61e19-f29d-4ccc-8718-ed70566163a9';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('3cb61e19-f29d-4ccc-8718-ed70566163a9', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('3cb61e19-f29d-4ccc-8718-ed70566163a9', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 5,
  why_it_helps = 'Tuna adds lean protein and iron, and kidney beans contribute fiber for a filling, no-cook lunch.',
  color_palette = 'Pale tuna and deep red kidney beans dressed in olive oil',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = '6c381112-562a-4253-b98d-c4d85af101ba';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('6c381112-562a-4253-b98d-c4d85af101ba', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('6c381112-562a-4253-b98d-c4d85af101ba', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Lean beef is a strong source of iron, and bell pepper and spinach add anti-inflammatory vitamins and antioxidants.',
  color_palette = 'Browned beef with red bell pepper and wilted green spinach',
  vegetable_substitutes = 'Bell pepper -> zucchini; Spinach -> kale',
  fresh_or_frozen = 'Bell pepper: both work, frozen sliced pepper is fine cooked into a skillet. Spinach: frozen works well once thawed and squeezed dry.'
WHERE id = 'ddf15657-356c-4508-82ad-1ce64a84e8f5';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('ddf15657-356c-4508-82ad-1ce64a84e8f5', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('ddf15657-356c-4508-82ad-1ce64a84e8f5', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Beef strips deliver a strong dose of iron, and spinach adds anti-inflammatory antioxidants on top of the rice base.',
  color_palette = 'White rice, browned beef strips, and dark green wilted spinach',
  vegetable_substitutes = 'Spinach -> kale or Swiss chard',
  fresh_or_frozen = 'Spinach: frozen works well once thawed and squeezed dry; use fresh if serving barely wilted.'
WHERE id = '7477efb4-0f9f-42ca-82f7-78c67cc44d80';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('7477efb4-0f9f-42ca-82f7-78c67cc44d80', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('7477efb4-0f9f-42ca-82f7-78c67cc44d80', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 5,
  why_it_helps = 'Berries and spinach together deliver a strong dose of antioxidants, and Greek yogurt adds protein and probiotics.',
  color_palette = 'Deep purple-green smoothie flecked with berry color',
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix',
  fresh_or_frozen = 'Berries and spinach: frozen works just as well as fresh here, and gives a thicker blended texture.'
WHERE id = '90ae2cdd-6499-41f9-9ebe-731d16cd6977';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('90ae2cdd-6499-41f9-9ebe-731d16cd6977', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('90ae2cdd-6499-41f9-9ebe-731d16cd6977', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 12,
  why_it_helps = 'Eggs are a complete, easy-to-digest source of protein and iron in a simple, portable snack.',
  color_palette = 'White eggshell halves with golden-yellow yolks',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = '974ccc24-55c1-4471-a699-36a18e9d55a6';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('974ccc24-55c1-4471-a699-36a18e9d55a6', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('974ccc24-55c1-4471-a699-36a18e9d55a6', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('974ccc24-55c1-4471-a699-36a18e9d55a6', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Chicken provides lean protein and iron, and avocado adds anti-inflammatory healthy fats to this fresh salad.',
  color_palette = 'Shredded chicken and green avocado over crisp lettuce',
  vegetable_substitutes = 'Lettuce -> baby spinach or arugula',
  fresh_or_frozen = 'Lettuce: fresh only - lettuce does not hold up to freezing.'
WHERE id = 'f7eb674a-10dd-4370-8fab-a508b4d2a880';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('f7eb674a-10dd-4370-8fab-a508b4d2a880', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('f7eb674a-10dd-4370-8fab-a508b4d2a880', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Chicken and stock provide protein and iron, and carrot adds a mild dose of fiber and beta-carotene.',
  color_palette = 'Golden broth with pale chicken, rice, and orange carrot',
  vegetable_substitutes = 'Carrot -> parsnip',
  fresh_or_frozen = 'Carrot: both work, frozen sliced carrot is fine in soups; fresh is better where texture matters.'
WHERE id = '07de3cdc-11cc-4202-a994-5d2453137488';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('07de3cdc-11cc-4202-a994-5d2453137488', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('07de3cdc-11cc-4202-a994-5d2453137488', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'This broth-based soup pairs lean chicken protein with carrot and celery for a light, easy-to-digest anti-inflammatory meal.',
  color_palette = 'Golden broth with orange carrot and pale green celery',
  vegetable_substitutes = 'Carrot -> parsnip; Celery -> fennel',
  fresh_or_frozen = 'Carrot and celery: both work well from frozen in a simmered soup like this.'
WHERE id = 'd84f6e77-5dc4-4ebf-b1c4-51dcb2ca701c';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('d84f6e77-5dc4-4ebf-b1c4-51dcb2ca701c', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('d84f6e77-5dc4-4ebf-b1c4-51dcb2ca701c', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Chickpeas bring fiber and plant protein, and turmeric-forward curry powder alongside spinach adds anti-inflammatory support.',
  color_palette = 'Golden-yellow coconut curry with deep green spinach',
  vegetable_substitutes = 'Spinach -> kale or Swiss chard',
  fresh_or_frozen = 'Spinach: frozen works well once thawed and squeezed dry; use fresh if serving barely wilted.'
WHERE id = 'f743aa8e-3a31-4dcb-ae0a-ba0af67d32f2';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('f743aa8e-3a31-4dcb-ae0a-ba0af67d32f2', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('f743aa8e-3a31-4dcb-ae0a-ba0af67d32f2', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Chickpeas provide fiber and plant protein, and the fresh vegetables add vitamin C and antioxidants.',
  color_palette = 'Cream chickpeas with red tomato, green cucumber, and purple red onion',
  vegetable_substitutes = 'Cucumber -> bell pepper; Tomatoes -> cherry tomatoes',
  fresh_or_frozen = 'Cucumber and tomatoes: fresh only, both turn watery once frozen and thawed.'
WHERE id = '63224c30-347f-4115-8b06-92bfa6d73ea5';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('63224c30-347f-4115-8b06-92bfa6d73ea5', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('63224c30-347f-4115-8b06-92bfa6d73ea5', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 5,
  why_it_helps = 'Chia seeds are a strong source of fiber and anti-inflammatory omega-3s, made into an easy make-ahead pudding.',
  color_palette = 'Speckled cream pudding with a dusting of brown cinnamon',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = '6f851b99-f92a-4a83-9680-97a0c1464388';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('6f851b99-f92a-4a83-9680-97a0c1464388', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('6f851b99-f92a-4a83-9680-97a0c1464388', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 3,
  why_it_helps = 'Cottage cheese provides protein, and pineapple adds vitamin C along with bromelain, an enzyme with mild anti-inflammatory properties.',
  color_palette = 'Creamy white cottage cheese with golden pineapple chunks',
  vegetable_substitutes = 'Pineapple -> mango',
  fresh_or_frozen = 'Pineapple: fresh or frozen both work well; frozen is convenient and just as nutritious.'
WHERE id = '14438125-e5eb-4ac2-b75d-079fb036fe45';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('14438125-e5eb-4ac2-b75d-079fb036fe45', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('14438125-e5eb-4ac2-b75d-079fb036fe45', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Cucumber is hydrating and light, while feta adds protein and a dose of calcium.',
  color_palette = 'Pale green cucumber with crumbled white feta',
  vegetable_substitutes = 'Cucumber -> zucchini ribbons',
  fresh_or_frozen = 'Cucumber: fresh only - cucumber turns watery and limp when frozen.'
WHERE id = '12ca198c-d82e-4d13-8589-196db9a53023';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('12ca198c-d82e-4d13-8589-196db9a53023', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('12ca198c-d82e-4d13-8589-196db9a53023', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Tuna adds lean protein and iron to crisp, hydrating cucumber rounds for a light snack.',
  color_palette = 'Pale green cucumber rounds topped with light pink tuna',
  vegetable_substitutes = 'Cucumber -> celery',
  fresh_or_frozen = 'Cucumber: fresh only - cucumber turns watery and limp when frozen.'
WHERE id = '2e1ebe28-0aa7-469a-b4f7-d8127ea1dc7f';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('2e1ebe28-0aa7-469a-b4f7-d8127ea1dc7f', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 6,
  why_it_helps = 'Edamame is a plant-based source of protein and fiber, with isoflavones that may offer mild anti-inflammatory benefits.',
  color_palette = 'Bright green edamame pods dusted with sea salt',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = 'aafa81ff-708c-4d29-83bc-b66f5d58e888';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('aafa81ff-708c-4d29-83bc-b66f5d58e888', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('aafa81ff-708c-4d29-83bc-b66f5d58e888', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 12,
  why_it_helps = 'Eggs provide complete protein and iron, and swapping mayonnaise for Greek yogurt keeps this lighter while adding probiotics.',
  color_palette = 'Pale yellow egg salad cupped in crisp green lettuce',
  vegetable_substitutes = 'Lettuce -> cabbage leaves',
  fresh_or_frozen = 'Lettuce: fresh only - lettuce does not hold up to freezing.'
WHERE id = 'aa337ddd-e693-468a-b090-8677d146bb39';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('aa337ddd-e693-468a-b090-8677d146bb39', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('aa337ddd-e693-468a-b090-8677d146bb39', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Chicken breast offers lean protein and iron, and broccoli and garlic both bring anti-inflammatory compounds.',
  color_palette = 'Golden chicken breast beside bright green broccoli',
  vegetable_substitutes = 'Broccoli -> cauliflower or green beans',
  fresh_or_frozen = 'Broccoli: frozen works well once cooked through; fresh is better for a crisp-tender sautee.'
WHERE id = '9fe82446-dab9-48ba-a92e-0748f7640978';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('9fe82446-dab9-48ba-a92e-0748f7640978', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('9fe82446-dab9-48ba-a92e-0748f7640978', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 3,
  why_it_helps = 'Greek yogurt provides protein and probiotics, and chia seeds add a dose of fiber and omega-3s.',
  color_palette = 'Creamy white yogurt topped with dark chia seeds and a honey drizzle',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = '75c8701b-b1f7-4de2-bc26-54c87eb9ddb6';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('75c8701b-b1f7-4de2-bc26-54c87eb9ddb6', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('75c8701b-b1f7-4de2-bc26-54c87eb9ddb6', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 3,
  why_it_helps = 'Greek yogurt provides protein and probiotics, and mixed nuts add anti-inflammatory healthy fats.',
  color_palette = 'Creamy white yogurt topped with golden-brown nuts',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = '4bd7c15c-8ad4-465d-966a-dc359840254f';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('4bd7c15c-8ad4-465d-966a-dc359840254f', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('4bd7c15c-8ad4-465d-966a-dc359840254f', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 5,
  why_it_helps = 'Hummus provides plant protein and fiber from chickpeas, and carrots add a dose of beta-carotene.',
  color_palette = 'Cream hummus with bright orange carrot sticks',
  vegetable_substitutes = 'Carrots -> cucumber or bell pepper sticks',
  fresh_or_frozen = 'Carrots: fresh is best for dipping sticks; frozen carrot is better saved for cooked dishes.'
WHERE id = 'bd05ddef-918d-4eec-a43a-b5f0eb80522a';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('bd05ddef-918d-4eec-a43a-b5f0eb80522a', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('bd05ddef-918d-4eec-a43a-b5f0eb80522a', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Lentils are rich in fiber, iron, and plant protein, and tomato and garlic add anti-inflammatory antioxidants.',
  color_palette = 'Deep red tomato sauce with brown-green lentils',
  vegetable_substitutes = 'Onion -> shallot',
  fresh_or_frozen = NULL
WHERE id = '338fbcea-aa81-4b88-8091-0de78b5b64e0';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('338fbcea-aa81-4b88-8091-0de78b5b64e0', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('338fbcea-aa81-4b88-8091-0de78b5b64e0', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Lentils provide fiber, iron, and plant protein, and carrot and garlic round out this warming, anti-inflammatory soup.',
  color_palette = 'Golden-brown broth with orange carrot and soft lentils',
  vegetable_substitutes = 'Carrot -> parsnip',
  fresh_or_frozen = 'Carrot: both work well from frozen in a simmered soup like this.'
WHERE id = '3b9f9a4a-11b3-47bd-affd-f3c310cab1b5';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('3b9f9a4a-11b3-47bd-affd-f3c310cab1b5', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('3b9f9a4a-11b3-47bd-affd-f3c310cab1b5', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Mackerel is a strong source of anti-inflammatory omega-3s and iron, paired with filling boiled potatoes.',
  color_palette = 'Silvery mackerel fillets beside pale golden potatoes',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = 'cabbdaa1-8f93-4393-9802-5371a1014213';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('cabbdaa1-8f93-4393-9802-5371a1014213', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('cabbdaa1-8f93-4393-9802-5371a1014213', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 12,
  why_it_helps = 'Tomatoes and olives bring anti-inflammatory antioxidants and healthy fats to this Mediterranean-style pasta.',
  color_palette = 'Pale pasta with dark olives, red tomato, and white feta',
  vegetable_substitutes = 'Tomatoes -> cherry tomatoes',
  fresh_or_frozen = NULL
WHERE id = '182c5eb5-29a1-4473-b05b-06974a727de0';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('182c5eb5-29a1-4473-b05b-06974a727de0', 'Vegetarian');

UPDATE meals SET
  prep_time_minutes = 12,
  why_it_helps = 'Oats and banana together provide fiber for steady digestion, and eggs add complete protein.',
  color_palette = 'Golden-brown pancakes with pale banana',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = 'caf35eb8-4e28-4864-bcef-d0229a4fdbb4';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('caf35eb8-4e28-4864-bcef-d0229a4fdbb4', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('caf35eb8-4e28-4864-bcef-d0229a4fdbb4', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Oats supply soluble fiber, and cocoa powder adds antioxidant flavonoids alongside banana natural sweetness.',
  color_palette = 'Deep brown oats topped with pale banana slices',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = 'a08a4485-74c1-49b8-ba74-746e6b390fee';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('a08a4485-74c1-49b8-ba74-746e6b390fee', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('a08a4485-74c1-49b8-ba74-746e6b390fee', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 25,
  why_it_helps = 'Chicken thighs offer protein and iron, and paprika and bell pepper both bring antioxidants to this one-pan dinner.',
  color_palette = 'Golden-red paprika chicken with red bell pepper and onion',
  vegetable_substitutes = 'Bell pepper -> zucchini',
  fresh_or_frozen = 'Bell pepper: both work, frozen sliced pepper is fine cooked into a skillet.'
WHERE id = '09e9ba10-4fa2-4ec2-b762-8beac481c26b';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('09e9ba10-4fa2-4ec2-b762-8beac481c26b', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('09e9ba10-4fa2-4ec2-b762-8beac481c26b', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 5,
  why_it_helps = 'Oats and chia seeds together deliver a strong dose of fiber, and berries add anti-inflammatory antioxidants.',
  color_palette = 'Creamy oats layered with deep purple-red berries',
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix',
  fresh_or_frozen = 'Berries: fresh or frozen both work well as a topping, straight from the freezer is fine.'
WHERE id = 'b9bfff3e-b104-473b-9e27-6240194264af';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('b9bfff3e-b104-473b-9e27-6240194264af', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('b9bfff3e-b104-473b-9e27-6240194264af', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Oats provide soluble fiber, and peanut butter adds protein and healthy fats to keep this breakfast filling.',
  color_palette = 'Creamy oats with golden banana slices and a peanut butter swirl',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = 'bbdd2681-b349-4c63-9e5f-7157a38c0532';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('bbdd2681-b349-4c63-9e5f-7157a38c0532', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('bbdd2681-b349-4c63-9e5f-7157a38c0532', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Peas provide fiber and plant protein, blended into a light, easy-to-digest soup.',
  color_palette = 'Vibrant green pea soup',
  vegetable_substitutes = 'Onion -> leek',
  fresh_or_frozen = NULL
WHERE id = '17eb7c87-284d-4746-bd85-affa5ebffae5';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('17eb7c87-284d-4746-bd85-affa5ebffae5', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('17eb7c87-284d-4746-bd85-affa5ebffae5', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Quinoa is a complete plant protein and fiber source, paired here with lean chicken for extra protein and iron.',
  color_palette = 'Pale quinoa with chicken and green cucumber',
  vegetable_substitutes = 'Cucumber -> bell pepper',
  fresh_or_frozen = 'Cucumber: fresh only - cucumber turns watery and limp when frozen.'
WHERE id = '7b7af4ee-9ae5-41ee-b8c1-8d48a1808cbe';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('7b7af4ee-9ae5-41ee-b8c1-8d48a1808cbe', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('7b7af4ee-9ae5-41ee-b8c1-8d48a1808cbe', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 30,
  why_it_helps = 'Roasted chickpeas offer fiber and plant protein in a crunchy, shelf-stable snack, with paprika adding antioxidants.',
  color_palette = 'Golden-brown roasted chickpeas dusted with red paprika',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = 'd553c214-495c-476e-b880-10faba2a7b54';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('d553c214-495c-476e-b880-10faba2a7b54', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('d553c214-495c-476e-b880-10faba2a7b54', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Roasted zucchini and bell pepper add anti-inflammatory antioxidants to this simple grain bowl.',
  color_palette = 'Pale couscous with golden zucchini and red bell pepper',
  vegetable_substitutes = 'Zucchini -> yellow squash; Bell pepper -> carrot',
  fresh_or_frozen = 'Zucchini and bell pepper: fresh is best for roasting; frozen versions turn softer and release more water.'
WHERE id = '5590230b-7574-4e8d-a261-3f8290a107a1';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('5590230b-7574-4e8d-a261-3f8290a107a1', 'Vegan');

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Salmon provides anti-inflammatory omega-3s and protein, and avocado adds more healthy fat to this rice bowl.',
  color_palette = 'White rice, pink salmon, green avocado, and cucumber',
  vegetable_substitutes = 'Cucumber -> shredded carrot',
  fresh_or_frozen = 'Cucumber: fresh only - cucumber turns watery and limp when frozen.'
WHERE id = '8f7d4bf9-c0fe-416e-8fcb-a144494ca9ff';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('8f7d4bf9-c0fe-416e-8fcb-a144494ca9ff', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Sardines are a strong source of anti-inflammatory omega-3s, calcium, and iron in a quick, no-cook topping.',
  color_palette = 'White rice topped with silvery sardines and cucumber',
  vegetable_substitutes = 'Cucumber -> shredded carrot',
  fresh_or_frozen = 'Cucumber: fresh only - cucumber turns watery and limp when frozen.'
WHERE id = '552327db-9e76-43c8-9d1d-932a970daa16';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('552327db-9e76-43c8-9d1d-932a970daa16', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('552327db-9e76-43c8-9d1d-932a970daa16', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 6,
  why_it_helps = 'Sardines deliver anti-inflammatory omega-3s, calcium, and iron on top of a simple slice of toast.',
  color_palette = 'Golden toast topped with silvery sardines',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = 'ed9a1f24-1aaf-4085-af41-b8313cb9e1ed';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('ed9a1f24-1aaf-4085-af41-b8313cb9e1ed', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Shrimp provides lean protein and iron, and zucchini noodles keep this dish light while adding fiber.',
  color_palette = 'Pink shrimp over pale green zucchini noodles',
  vegetable_substitutes = 'Zucchini noodles -> spaghetti squash',
  fresh_or_frozen = 'Zucchini: fresh is best for noodles, frozen zucchini releases too much water and turns mushy.'
WHERE id = 'b41e298f-5f8f-4231-819a-58d731ce767b';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('b41e298f-5f8f-4231-819a-58d731ce767b', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('b41e298f-5f8f-4231-819a-58d731ce767b', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Lentils provide fiber, iron, and plant protein, and tomato and garlic add anti-inflammatory antioxidants.',
  color_palette = 'Deep red tomato stew with soft brown lentils',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = 'b4f74c98-530d-4ea4-9bce-e73fbfdfbe9e';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('b4f74c98-530d-4ea4-9bce-e73fbfdfbe9e', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('b4f74c98-530d-4ea4-9bce-e73fbfdfbe9e', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 6,
  why_it_helps = 'Smoked salmon adds anti-inflammatory omega-3s and protein to a light, refreshing toast.',
  color_palette = 'Golden toast, pink smoked salmon, and pale green cucumber',
  vegetable_substitutes = 'Cucumber -> radish slices',
  fresh_or_frozen = NULL
WHERE id = 'a656c3c3-74a7-4b7f-889e-7943fec42e03';

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Eggs provide complete protein, and spinach adds anti-inflammatory antioxidants and vitamin K to this quick scramble.',
  color_palette = 'Golden scrambled eggs with dark green spinach and white feta',
  vegetable_substitutes = 'Spinach -> kale or Swiss chard',
  fresh_or_frozen = 'Spinach: frozen works well once thawed and squeezed dry; use fresh if serving barely wilted.'
WHERE id = '06fd4cd1-cd4b-41e0-bc91-8fcff42be69d';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('06fd4cd1-cd4b-41e0-bc91-8fcff42be69d', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('06fd4cd1-cd4b-41e0-bc91-8fcff42be69d', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Tofu provides plant protein and iron, and broccoli and carrot add fiber and anti-inflammatory antioxidants.',
  color_palette = 'Golden-brown tofu with green broccoli and orange carrot',
  vegetable_substitutes = 'Broccoli -> cauliflower; Carrot -> bell pepper',
  fresh_or_frozen = 'Broccoli: frozen works well once cooked through; fresh is better for a crisp-tender stir-fry.'
WHERE id = '220b388d-1690-4f91-b14b-3ec218070c6b';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('220b388d-1690-4f91-b14b-3ec218070c6b', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('220b388d-1690-4f91-b14b-3ec218070c6b', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 20,
  why_it_helps = 'Eggs provide complete protein, and tomato and basil add vitamin C and antioxidants to this make-ahead breakfast.',
  color_palette = 'Golden egg muffins studded with red tomato and green basil',
  vegetable_substitutes = 'Cherry tomatoes -> diced regular tomato',
  fresh_or_frozen = 'Cherry tomatoes: fresh is best here for texture; frozen tomatoes turn watery once thawed.'
WHERE id = 'bb3d3ac3-49c5-467c-b03e-d8faa142d556';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('bb3d3ac3-49c5-467c-b03e-d8faa142d556', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('bb3d3ac3-49c5-467c-b03e-d8faa142d556', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('bb3d3ac3-49c5-467c-b03e-d8faa142d556', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'White beans provide fiber and plant protein, and tomato, garlic, and basil bring anti-inflammatory antioxidants.',
  color_palette = 'Deep red tomato stew with creamy white beans and fresh basil',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = 'e7568fba-9ddb-499c-b843-483fec0db74a';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('e7568fba-9ddb-499c-b843-483fec0db74a', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('e7568fba-9ddb-499c-b843-483fec0db74a', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Eggs provide complete protein, and tomatoes add vitamin C and lycopene in this simple, fast stir-fry.',
  color_palette = 'Golden scrambled eggs in a red tomato sauce',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = '09a85e6a-4946-4e7c-9b36-c1e4dbba6dca';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('09a85e6a-4946-4e7c-9b36-c1e4dbba6dca', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('09a85e6a-4946-4e7c-9b36-c1e4dbba6dca', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('09a85e6a-4946-4e7c-9b36-c1e4dbba6dca', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 3,
  why_it_helps = 'Tomato provides vitamin C and lycopene, paired simply with mozzarella for protein and calcium.',
  color_palette = 'Red tomato slices with white mozzarella',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = '719f2c0f-2b85-4703-b60c-1f540bc559ed';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('719f2c0f-2b85-4703-b60c-1f540bc559ed', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('719f2c0f-2b85-4703-b60c-1f540bc559ed', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 2,
  why_it_helps = 'Nuts and pumpkin seeds provide anti-inflammatory healthy fats, and dried fruit adds a natural dose of sweetness and fiber.',
  color_palette = 'Mixed browns and golds from nuts, seeds, and dried fruit',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = 'ed78147e-6355-49bf-b07a-11069ef6e2bb';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('ed78147e-6355-49bf-b07a-11069ef6e2bb', 'Vegan');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('ed78147e-6355-49bf-b07a-11069ef6e2bb', 'Gluten-free');

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Tuna provides lean protein and iron, and white beans add fiber for a filling, no-cook lunch.',
  color_palette = 'Pale tuna and creamy white beans flecked with green parsley',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = '80def1d6-ccb0-474c-9567-68935d7450e1';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('80def1d6-ccb0-474c-9567-68935d7450e1', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('80def1d6-ccb0-474c-9567-68935d7450e1', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 6,
  why_it_helps = 'Turkey provides lean protein, and hummus adds plant protein and fiber from chickpeas.',
  color_palette = 'Pale wrap with lean turkey, green lettuce, and cucumber',
  vegetable_substitutes = 'Cucumber -> shredded carrot',
  fresh_or_frozen = NULL
WHERE id = '01f4e0ef-ffa7-4244-b90b-f33deac94fc0';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('01f4e0ef-ffa7-4244-b90b-f33deac94fc0', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 25,
  why_it_helps = 'Turkey provides lean protein and iron, and tomato and garlic bring anti-inflammatory antioxidants to the sauce.',
  color_palette = 'Golden-brown meatballs in a deep red tomato sauce',
  vegetable_substitutes = NULL,
  fresh_or_frozen = NULL
WHERE id = '18fb5dcb-d3a9-4a03-90f7-7991b48de17b';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('18fb5dcb-d3a9-4a03-90f7-7991b48de17b', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('18fb5dcb-d3a9-4a03-90f7-7991b48de17b', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 15,
  why_it_helps = 'Eggs add complete protein, and the mixed vegetables bring fiber and a range of anti-inflammatory antioxidants.',
  color_palette = 'Golden fried rice with colorful mixed vegetables',
  vegetable_substitutes = 'Mixed veggies -> peas, carrot, and corn',
  fresh_or_frozen = 'Mixed vegetables: frozen works great here and is the standard choice for fried rice.'
WHERE id = 'a1a1c098-0a97-4fd6-9fbb-f5446351ec90';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('a1a1c098-0a97-4fd6-9fbb-f5446351ec90', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('a1a1c098-0a97-4fd6-9fbb-f5446351ec90', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 10,
  why_it_helps = 'Eggs provide complete protein, and mushrooms and bell pepper add fiber and antioxidants to this quick omelette.',
  color_palette = 'Golden folded omelette with flecks of red pepper and brown mushroom',
  vegetable_substitutes = 'Mushrooms -> zucchini; Bell pepper -> tomato',
  fresh_or_frozen = 'Mushrooms: fresh is recommended, mushrooms turn watery and rubbery when frozen. Bell pepper: both work, frozen sliced pepper is fine cooked into an omelette.'
WHERE id = '65b4edaf-a8a5-4360-b0ac-508a80a37927';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('65b4edaf-a8a5-4360-b0ac-508a80a37927', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('65b4edaf-a8a5-4360-b0ac-508a80a37927', 'Gluten-free');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('65b4edaf-a8a5-4360-b0ac-508a80a37927', 'Dairy-free');

UPDATE meals SET
  prep_time_minutes = 8,
  why_it_helps = 'Quinoa is a complete plant protein and fiber source, and blueberries add a strong dose of antioxidants.',
  color_palette = 'Warm pale quinoa topped with deep blue blueberries and almonds',
  vegetable_substitutes = 'Blueberries -> any frozen berry',
  fresh_or_frozen = 'Blueberries: fresh or frozen both work well as a topping.'
WHERE id = '995d555d-04c1-42b3-a072-83bf45370bc8';
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('995d555d-04c1-42b3-a072-83bf45370bc8', 'Vegetarian');
INSERT INTO meal_dietary_tags (meal_id, dietary_tag) VALUES ('995d555d-04c1-42b3-a072-83bf45370bc8', 'Gluten-free');
