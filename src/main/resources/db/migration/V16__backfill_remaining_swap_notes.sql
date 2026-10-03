-- Fills in vegetable_substitutes / fresh_or_frozen for recipes in the V15 backfill that had
-- real swappable produce but were left blank, plus adds fresh_or_frozen to a few that already
-- had a substitute note but no storage guidance. The remaining recipes with no swap notes
-- (e.g. Boiled Eggs with Salt, Trail Mix Cup, Greek Yogurt Snack Cup) genuinely have no fresh
-- produce to swap, matching the existing "Turmeric Roasted Chickpeas" precedent -- left as-is.

UPDATE meals SET
  vegetable_substitutes = 'Apple -> pear or plum',
  fresh_or_frozen = 'Apple: best fresh for slicing; not recommended frozen for this dish.'
WHERE name = 'Apple with Almond Butter';

UPDATE meals SET
  vegetable_substitutes = 'Banana -> ripe pear',
  fresh_or_frozen = 'Banana: best fresh; frozen banana works but is better saved for smoothies than eating plain.'
WHERE name = 'Banana Cinnamon Snack';

UPDATE meals SET
  vegetable_substitutes = 'Edamame -> green peas',
  fresh_or_frozen = 'Edamame: frozen is standard and works great; fresh edamame in the pod also works if available.'
WHERE name = 'Edamame with Sea Salt';

UPDATE meals SET
  vegetable_substitutes = 'Potatoes -> sweet potato',
  fresh_or_frozen = 'Potatoes: fresh is standard for boiling; frozen is not recommended here since it turns waterlogged.'
WHERE name = 'Mackerel Potato Plate';

UPDATE meals SET
  vegetable_substitutes = 'Banana -> ripe pear, mashed',
  fresh_or_frozen = 'Banana: fresh, very ripe banana binds the batter best; thawed and drained frozen banana works in a pinch.'
WHERE name = 'Oat Banana Pancakes (2-Ingredient)';

UPDATE meals SET
  vegetable_substitutes = 'Banana -> ripe pear',
  fresh_or_frozen = 'Banana: best fresh; frozen banana works once thawed but makes the oats looser.'
WHERE name = 'Oats with Cocoa and Banana';

UPDATE meals SET
  vegetable_substitutes = 'Banana -> ripe pear',
  fresh_or_frozen = 'Banana: best fresh; frozen banana works once thawed but makes the oats looser.'
WHERE name = 'Peanut Butter Banana Oat Bowl';

UPDATE meals SET
  vegetable_substitutes = 'Garlic -> 1/4 tsp garlic powder per clove',
  fresh_or_frozen = 'Garlic: fresh is standard; pre-minced jarred garlic works fine too.'
WHERE name = 'Simple Tomato Lentil Stew';

UPDATE meals SET
  vegetable_substitutes = 'Basil -> parsley, or 1 tsp dried basil',
  fresh_or_frozen = 'Basil: fresh is best for flavor; dried basil works in a pinch at about a third of the amount.'
WHERE name = 'Tomato Basil White Bean Stew';

UPDATE meals SET
  vegetable_substitutes = 'Tomatoes -> canned diced tomatoes',
  fresh_or_frozen = 'Tomatoes: fresh is best for this stir-fry; frozen tomatoes turn watery once thawed.'
WHERE name = 'Tomato Egg Stir Fry';

UPDATE meals SET
  vegetable_substitutes = 'Tomatoes -> heirloom or beefsteak tomato',
  fresh_or_frozen = 'Tomatoes: fresh only, this dish relies on raw tomato texture, which frozen cannot replicate.'
WHERE name = 'Tomato Mozzarella Snack Plate';

UPDATE meals SET
  vegetable_substitutes = 'Parsley -> cilantro or chives',
  fresh_or_frozen = 'Parsley: fresh is best for flavor; dried parsley works in a pinch at about a third of the amount.'
WHERE name = 'Tuna and White Bean Bowl';

UPDATE meals SET
  vegetable_substitutes = 'Garlic -> 1/4 tsp garlic powder per clove',
  fresh_or_frozen = 'Garlic: fresh is standard; pre-minced jarred garlic works fine too.'
WHERE name = 'Turkey Meatballs with Tomato Sauce';

UPDATE meals SET
  fresh_or_frozen = 'Onion: fresh is standard; frozen diced onion works fine simmered into a sauce like this.'
WHERE name = 'Lentil Bolognese';

UPDATE meals SET
  fresh_or_frozen = 'Tomatoes: fresh is best for a salad like this; frozen tomatoes turn watery once thawed.'
WHERE name = 'Mediterranean Pasta Salad';

UPDATE meals SET
  fresh_or_frozen = 'Peas: frozen is standard and works perfectly here; fresh peas work too when in season.'
WHERE name = 'Pea Soup (Quick)';

UPDATE meals SET
  fresh_or_frozen = 'Cucumber: fresh only, cucumber turns watery and limp when frozen.'
WHERE name = 'Smoked Salmon Cucumber Toast';

UPDATE meals SET
  fresh_or_frozen = 'Cucumber: fresh only, cucumber turns watery and limp when frozen.'
WHERE name = 'Turkey Hummus Wrap';
