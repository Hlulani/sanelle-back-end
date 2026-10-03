-- Fills in vegetable_substitutes / fresh_or_frozen for recipes in the V15 backfill that had
-- real swappable produce but were left blank, plus adds fresh_or_frozen to a few that already
-- had a substitute note but no storage guidance. The remaining recipes with no swap notes
-- (e.g. Boiled Eggs with Salt, Trail Mix Cup, Greek Yogurt Snack Cup) genuinely have no fresh
-- produce to swap, matching the existing "Turmeric Roasted Chickpeas" precedent -- left as-is.

UPDATE meals SET
  vegetable_substitutes = 'Apple -> pear or plum',
  fresh_or_frozen = 'Apple: best fresh for slicing; not recommended frozen for this dish.'
WHERE id = '0cc82836-e9bf-4d56-b213-668b12fc6cb0';

UPDATE meals SET
  vegetable_substitutes = 'Banana -> ripe pear',
  fresh_or_frozen = 'Banana: best fresh; frozen banana works but is better saved for smoothies than eating plain.'
WHERE id = '1fe953d0-cedc-4b9e-b2dc-9842cde09ab4';

UPDATE meals SET
  vegetable_substitutes = 'Edamame -> green peas',
  fresh_or_frozen = 'Edamame: frozen is standard and works great; fresh edamame in the pod also works if available.'
WHERE id = 'aafa81ff-708c-4d29-83bc-b66f5d58e888';

UPDATE meals SET
  vegetable_substitutes = 'Potatoes -> sweet potato',
  fresh_or_frozen = 'Potatoes: fresh is standard for boiling; frozen is not recommended here since it turns waterlogged.'
WHERE id = 'cabbdaa1-8f93-4393-9802-5371a1014213';

UPDATE meals SET
  vegetable_substitutes = 'Banana -> ripe pear, mashed',
  fresh_or_frozen = 'Banana: fresh, very ripe banana binds the batter best; thawed and drained frozen banana works in a pinch.'
WHERE id = 'caf35eb8-4e28-4864-bcef-d0229a4fdbb4';

UPDATE meals SET
  vegetable_substitutes = 'Banana -> ripe pear',
  fresh_or_frozen = 'Banana: best fresh; frozen banana works once thawed but makes the oats looser.'
WHERE id = 'a08a4485-74c1-49b8-ba74-746e6b390fee';

UPDATE meals SET
  vegetable_substitutes = 'Banana -> ripe pear',
  fresh_or_frozen = 'Banana: best fresh; frozen banana works once thawed but makes the oats looser.'
WHERE id = 'bbdd2681-b349-4c63-9e5f-7157a38c0532';

UPDATE meals SET
  vegetable_substitutes = 'Garlic -> 1/4 tsp garlic powder per clove',
  fresh_or_frozen = 'Garlic: fresh is standard; pre-minced jarred garlic works fine too.'
WHERE id = 'b4f74c98-530d-4ea4-9bce-e73fbfdfbe9e';

UPDATE meals SET
  vegetable_substitutes = 'Basil -> parsley, or 1 tsp dried basil',
  fresh_or_frozen = 'Basil: fresh is best for flavor; dried basil works in a pinch at about a third of the amount.'
WHERE id = 'e7568fba-9ddb-499c-b843-483fec0db74a';

UPDATE meals SET
  vegetable_substitutes = 'Tomatoes -> canned diced tomatoes',
  fresh_or_frozen = 'Tomatoes: fresh is best for this stir-fry; frozen tomatoes turn watery once thawed.'
WHERE id = '09a85e6a-4946-4e7c-9b36-c1e4dbba6dca';

UPDATE meals SET
  vegetable_substitutes = 'Tomatoes -> heirloom or beefsteak tomato',
  fresh_or_frozen = 'Tomatoes: fresh only, this dish relies on raw tomato texture, which frozen cannot replicate.'
WHERE id = '719f2c0f-2b85-4703-b60c-1f540bc559ed';

UPDATE meals SET
  vegetable_substitutes = 'Parsley -> cilantro or chives',
  fresh_or_frozen = 'Parsley: fresh is best for flavor; dried parsley works in a pinch at about a third of the amount.'
WHERE id = '80def1d6-ccb0-474c-9567-68935d7450e1';

UPDATE meals SET
  vegetable_substitutes = 'Garlic -> 1/4 tsp garlic powder per clove',
  fresh_or_frozen = 'Garlic: fresh is standard; pre-minced jarred garlic works fine too.'
WHERE id = '18fb5dcb-d3a9-4a03-90f7-7991b48de17b';

UPDATE meals SET
  fresh_or_frozen = 'Onion: fresh is standard; frozen diced onion works fine simmered into a sauce like this.'
WHERE id = '338fbcea-aa81-4b88-8091-0de78b5b64e0';

UPDATE meals SET
  fresh_or_frozen = 'Tomatoes: fresh is best for a salad like this; frozen tomatoes turn watery once thawed.'
WHERE id = '182c5eb5-29a1-4473-b05b-06974a727de0';

UPDATE meals SET
  fresh_or_frozen = 'Peas: frozen is standard and works perfectly here; fresh peas work too when in season.'
WHERE id = '17eb7c87-284d-4746-bd85-affa5ebffae5';

UPDATE meals SET
  fresh_or_frozen = 'Cucumber: fresh only, cucumber turns watery and limp when frozen.'
WHERE id = 'a656c3c3-74a7-4b7f-889e-7943fec42e03';

UPDATE meals SET
  fresh_or_frozen = 'Cucumber: fresh only, cucumber turns watery and limp when frozen.'
WHERE id = '01f4e0ef-ffa7-4244-b90b-f33deac94fc0';
