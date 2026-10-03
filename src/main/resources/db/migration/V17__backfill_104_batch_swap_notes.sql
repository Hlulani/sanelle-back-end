-- Fills in vegetable_substitutes / fresh_or_frozen for recipes in the original V13 (104-recipe)
-- batch that had real, swappable fresh produce (mostly fruit toppings) but no substitute note.
-- The remaining recipes with no swap notes in that batch (e.g. Dark Chocolate and Almonds,
-- Turmeric Roasted Chickpeas, Green Tea and Mixed Nuts) genuinely have no fresh produce to swap
-- and are intentionally left as-is.

UPDATE meals SET
  vegetable_substitutes = 'Mango and blueberries -> any diced or frozen fruit you have on hand',
  fresh_or_frozen = 'Banana, mango, and blueberries: frozen is standard here and gives a thicker, colder smoothie bowl; fresh works too.'
WHERE id = 'b3e17a86-81bf-4cfa-900f-941465e4e518';

UPDATE meals SET
  vegetable_substitutes = 'Apple -> pear or plum',
  fresh_or_frozen = 'Apple: best fresh for slicing; not recommended frozen for this dish.'
WHERE id = '479ed298-e93a-488e-9457-fbf7df849673';

UPDATE meals SET
  vegetable_substitutes = 'Apple -> pear or plum',
  fresh_or_frozen = 'Apple: best fresh for slicing; not recommended frozen for this dish.'
WHERE id = 'd159543f-b55a-4b5c-beed-cc7cc0e2477d';

UPDATE meals SET
  vegetable_substitutes = 'Apple -> pear or plum',
  fresh_or_frozen = 'Apple: best fresh for slicing; not recommended frozen for this dish.'
WHERE id = '0c261e25-d16e-4673-91be-6d3221a75510';

UPDATE meals SET
  vegetable_substitutes = 'Blueberries -> any frozen berry mix',
  fresh_or_frozen = 'Blueberries: fresh or frozen both work well for a quick stovetop compote; frozen is often better since it releases more juice.'
WHERE id = 'a2e0b3da-a80b-485d-ab3d-bccc4a202dad';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix',
  fresh_or_frozen = 'Berries: fresh or frozen both work well as a topping.'
WHERE id = '7b3b266c-db4d-4583-8c3d-e36729f5a259';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix',
  fresh_or_frozen = 'Berries: fresh or frozen both work well as a topping.'
WHERE id = 'e8b2e7c1-f22e-4601-8912-3f5f2d31ad15';

UPDATE meals SET
  vegetable_substitutes = 'Mango -> pineapple or peach',
  fresh_or_frozen = 'Mango: fresh or frozen both work well; frozen diced mango blends into the pudding just as easily.'
WHERE id = '5e3fea0d-43c1-48af-9154-10979c625b79';

UPDATE meals SET
  vegetable_substitutes = 'Mango -> pineapple or peach',
  fresh_or_frozen = 'Mango: fresh or frozen both work well; frozen diced mango blends into the pudding just as easily.'
WHERE id = '1d7dea26-925d-4391-be11-9d8cb3c650ce';

UPDATE meals SET
  vegetable_substitutes = 'Chives -> spring onion tops',
  fresh_or_frozen = 'Chives: fresh is best for flavor; dried chives work in a pinch at about a third of the amount.'
WHERE id = '4f361a45-ca2f-476a-8ab1-e8ca3cd80cc1';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix',
  fresh_or_frozen = 'Berries: fresh or frozen both work well as a topping.'
WHERE id = '7bdd99d7-f522-48b9-87a3-4cbe577779de';

UPDATE meals SET
  vegetable_substitutes = 'Mango and blueberries -> any diced or frozen fruit you have on hand',
  fresh_or_frozen = 'Banana, mango, and blueberries: frozen is standard here and gives a thicker, colder smoothie bowl; fresh works too.'
WHERE id = 'f68bdc2d-ecdd-4a9b-adff-32138638a73a';

UPDATE meals SET
  vegetable_substitutes = 'Blueberries -> any frozen berry mix',
  fresh_or_frozen = 'Blueberries: fresh or frozen both work well as a topping.'
WHERE id = 'c50b27a0-3d9c-40e7-a224-a542985179bc';

UPDATE meals SET
  vegetable_substitutes = 'Pomegranate seeds -> dried cranberries',
  fresh_or_frozen = 'Pomegranate seeds: fresh is standard; pre-packaged pomegranate arils also work well and save prep time.'
WHERE id = '076c3e44-959b-4e54-a410-2a6dd1d4ee92';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix',
  fresh_or_frozen = 'Berries and banana: frozen is standard here for a thick, cold smoothie; fresh works too but the texture will be thinner.'
WHERE id = '78ba607c-0fd7-4fb3-b30f-2345748d1813';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any seasonal fruit',
  fresh_or_frozen = 'Berries: fresh is best for eating plain; frozen berries work well if thawed first.'
WHERE id = '0fccd383-31db-43fc-8a78-718cb7612055';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any seasonal fruit',
  fresh_or_frozen = 'Berries: fresh is best for eating plain; frozen berries work well if thawed first.'
WHERE id = 'f30db50b-ec72-4612-976e-b1277332395a';

UPDATE meals SET
  vegetable_substitutes = 'Raspberries -> any frozen berry mix',
  fresh_or_frozen = 'Raspberries: fresh or frozen both work well; frozen is convenient and holds up fine soaked overnight.'
WHERE id = '6dbea585-c8f8-474a-b9d9-c99fb56eb9a6';

UPDATE meals SET
  vegetable_substitutes = 'Raspberries -> any frozen berry mix',
  fresh_or_frozen = 'Raspberries: fresh or frozen both work well; frozen is convenient and holds up fine soaked overnight.'
WHERE id = 'be9a0e3b-5d14-4e21-86b2-c033aead7d94';

UPDATE meals SET
  vegetable_substitutes = 'Banana -> ripe pear, sliced',
  fresh_or_frozen = 'Banana: best fresh for slicing; frozen banana is better saved for smoothies.'
WHERE id = 'fdd008eb-9ae7-44cc-9b4d-f979a3c80347';

UPDATE meals SET
  vegetable_substitutes = 'Blueberries -> any frozen berry mix',
  fresh_or_frozen = 'Blueberries: fresh or frozen both work well as a topping.'
WHERE id = '1247b31b-9009-466d-b6e6-b289a5268c60';

UPDATE meals SET
  vegetable_substitutes = 'Avocado -> mashed white beans with a squeeze of lemon',
  fresh_or_frozen = 'Avocado: fresh only, avocado turns brown and mushy once frozen and thawed.'
WHERE id = '838b46fc-9268-47ff-88bb-1f742e08a38a';

UPDATE meals SET
  vegetable_substitutes = 'Mixed berries -> any frozen berry mix; Fresh ginger -> 1/4 tsp ground ginger',
  fresh_or_frozen = 'Berries: fresh or frozen both work well as a topping. Ginger: fresh is best for flavor; ground ginger works in a pinch at about a quarter of the amount.'
WHERE id = '9f9dea61-8471-4a4b-bfbd-01e719336da7';

UPDATE meals SET
  vegetable_substitutes = 'Pomegranate seeds -> dried cranberries',
  fresh_or_frozen = 'Pomegranate seeds: fresh is standard; pre-packaged pomegranate arils also work well and save prep time.'
WHERE id = '6973b574-90ac-4d7c-9247-e0054169950a';
