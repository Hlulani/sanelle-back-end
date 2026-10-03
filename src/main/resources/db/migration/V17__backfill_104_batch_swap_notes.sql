-- Fills in vegetable_substitutes / fresh_or_frozen for recipes in the original V13 (104-recipe)
-- batch that had real, swappable fresh produce (mostly fruit toppings) but no substitute note.
-- The remaining recipes with no swap notes in that batch (e.g. Dark Chocolate and Almonds,
-- Turmeric Roasted Chickpeas, Green Tea and Mixed Nuts) genuinely have no fresh produce to swap
-- and are intentionally left as-is.

UPDATE meals SET
  vegetable_substitutes = 'Mango and blueberries -> any diced or frozen fruit you have on hand',
  fresh_or_frozen = 'Banana, mango, and blueberries: frozen is standard here and gives a thicker, colder smoothie bowl; fresh works too.'
WHERE name = 'Anti-Inflammatory Golden Milk Smoothie Bowl';

UPDATE meals SET
  vegetable_substitutes = 'Apple -> pear or plum',
  fresh_or_frozen = 'Apple: best fresh for slicing; not recommended frozen for this dish.'
WHERE name = 'Apple Slices with Almond Butter and Cinnamon';

UPDATE meals SET
  vegetable_substitutes = 'Apple -> pear or plum',
  fresh_or_frozen = 'Apple: best fresh for slicing; not recommended frozen for this dish.'
WHERE name = 'Apple Slices with Almond Butter, Cinnamon, and Cheddar (Non-Vegan Alt)';

UPDATE meals SET
  vegetable_substitutes = 'Apple -> pear or plum',
  fresh_or_frozen = 'Apple: best fresh for slicing; not recommended frozen for this dish.'
WHERE name = 'Apple Slices with Greek Yogurt and Cinnamon';

UPDATE meals SET
  vegetable_substitutes = 'Blueberries -> any frozen berry mix',
  fresh_or_frozen = 'Blueberries: fresh or frozen both work well for a quick stovetop compote; frozen is often better since it releases more juice.'
WHERE name = 'Buckwheat Pancakes with Blueberry Compote';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix',
  fresh_or_frozen = 'Berries: fresh or frozen both work well as a topping.'
WHERE name = 'Chia Seed Pudding Cup with Milk, Honey, and Mixed Berries (Non-Vegan Alt)';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix',
  fresh_or_frozen = 'Berries: fresh or frozen both work well as a topping.'
WHERE name = 'Chia Seed Pudding Cup with Mixed Berries';

UPDATE meals SET
  vegetable_substitutes = 'Mango -> pineapple or peach',
  fresh_or_frozen = 'Mango: fresh or frozen both work well; frozen diced mango blends into the pudding just as easily.'
WHERE name = 'Chia Seed Pudding with Mango and Coconut';

UPDATE meals SET
  vegetable_substitutes = 'Mango -> pineapple or peach',
  fresh_or_frozen = 'Mango: fresh or frozen both work well; frozen diced mango blends into the pudding just as easily.'
WHERE name = 'Chia Seed Pudding with Mango and Greek Yogurt (Non-Vegan Alt)';

UPDATE meals SET
  vegetable_substitutes = 'Chives -> spring onion tops',
  fresh_or_frozen = 'Chives: fresh is best for flavor; dried chives work in a pinch at about a third of the amount.'
WHERE name = 'Cottage Cheese and Egg Scramble with Chives';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix',
  fresh_or_frozen = 'Berries: fresh or frozen both work well as a topping.'
WHERE name = 'Cottage Cheese with Berries and Flaxseed';

UPDATE meals SET
  vegetable_substitutes = 'Mango and blueberries -> any diced or frozen fruit you have on hand',
  fresh_or_frozen = 'Banana, mango, and blueberries: frozen is standard here and gives a thicker, colder smoothie bowl; fresh works too.'
WHERE name = 'Golden Milk Smoothie Bowl with Dairy Milk and Honey (Non-Vegan Alt)';

UPDATE meals SET
  vegetable_substitutes = 'Blueberries -> any frozen berry mix',
  fresh_or_frozen = 'Blueberries: fresh or frozen both work well as a topping.'
WHERE name = 'Greek Yogurt Parfait with Blueberries, Flaxseed, Honey';

UPDATE meals SET
  vegetable_substitutes = 'Pomegranate seeds -> dried cranberries',
  fresh_or_frozen = 'Pomegranate seeds: fresh is standard; pre-packaged pomegranate arils also work well and save prep time.'
WHERE name = 'Greek Yogurt with Honey, Cinnamon, and Pomegranate';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix',
  fresh_or_frozen = 'Berries and banana: frozen is standard here for a thick, cold smoothie; fresh works too but the texture will be thinner.'
WHERE name = 'Kefir Berry Smoothie with Flaxseed';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any seasonal fruit',
  fresh_or_frozen = 'Berries: fresh is best for eating plain; frozen berries work well if thawed first.'
WHERE name = 'Mixed Berries with Walnuts';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any seasonal fruit',
  fresh_or_frozen = 'Berries: fresh is best for eating plain; frozen berries work well if thawed first.'
WHERE name = 'Mixed Berries with Walnuts and Greek Yogurt (Non-Vegan Alt)';

UPDATE meals SET
  vegetable_substitutes = 'Raspberries -> any frozen berry mix',
  fresh_or_frozen = 'Raspberries: fresh or frozen both work well; frozen is convenient and holds up fine soaked overnight.'
WHERE name = 'Overnight Oats with Cinnamon, Walnuts, and Raspberries';

UPDATE meals SET
  vegetable_substitutes = 'Raspberries -> any frozen berry mix',
  fresh_or_frozen = 'Raspberries: fresh or frozen both work well; frozen is convenient and holds up fine soaked overnight.'
WHERE name = 'Overnight Oats with Milk, Honey, Walnuts, and Raspberries (Non-Vegan Alt)';

UPDATE meals SET
  vegetable_substitutes = 'Banana -> ripe pear, sliced',
  fresh_or_frozen = 'Banana: best fresh for slicing; frozen banana is better saved for smoothies.'
WHERE name = 'Peanut Butter and Banana Rice Cakes';

UPDATE meals SET
  vegetable_substitutes = 'Blueberries -> any frozen berry mix',
  fresh_or_frozen = 'Blueberries: fresh or frozen both work well as a topping.'
WHERE name = 'Silken Tofu Berry Parfait (Yogurt-Free)';

UPDATE meals SET
  vegetable_substitutes = 'Avocado -> mashed white beans with a squeeze of lemon',
  fresh_or_frozen = 'Avocado: fresh only, avocado turns brown and mushy once frozen and thawed.'
WHERE name = 'Smoked Salmon and Avocado Toast with Everything Seasoning';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix; Fresh ginger -> 1/4 tsp ground ginger',
  fresh_or_frozen = 'Berries: fresh or frozen both work well as a topping. Ginger: fresh is best for flavor; ground ginger works in a pinch at about a quarter of the amount.'
WHERE name = 'Turmeric Ginger Oatmeal with Berries and Walnuts';

UPDATE meals SET
  vegetable_substitutes = 'Pomegranate seeds -> dried cranberries',
  fresh_or_frozen = 'Pomegranate seeds: fresh is standard; pre-packaged pomegranate arils also work well and save prep time.'
WHERE name = 'Whipped Coconut Cream with Cinnamon and Pomegranate (Yogurt-Free)';
