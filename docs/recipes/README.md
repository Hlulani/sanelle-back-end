# Recipe content revision — 10 October 2026

Audited all 166 seeded database recipes. Expanded 62 legacy methods and corrected 35 newer methods; 69 existing methods were retained. All recipes receive explicit input-state notes, applicable cooking-check identifiers and source URLs. These are editorial clarifications of the original Sanelle recipes. They have **not been kitchen-tested**; estimated method timings do not establish doneness or a verified total duration.

`recipe-content-v1.json` records the exact original ingredients and ordered directions, revised directions, provenance and sources. V21 updates only uniquely named recipes with matching original ingredients AND directions. It preserves IDs, portions, ingredients, dietary tags and saved plans; custom edits are skipped with a migration notice. New/custom recipes remain unreviewed (`recipeContent: null`).

Two misleading names are corrected: Oat Banana Pancakes (2-Ingredient) becomes Oat Banana Pancakes (three listed ingredients); Anti-Inflammatory Golden Milk Smoothie Bowl becomes Golden Milk Smoothie Bowl (no treatment claim). The frontend retains photo matches for both renamed recipes.

The central cooking checks in the frontend interpret the database check identifiers. FoodSafety.gov supplies doneness temperatures, FSA supplies rice cooling/reheating guidance, FDA supplies egg and produce handling guidance. These authorities do not validate the complete recipes. Quaker supplies the rolled-oat technique, NEFF the cod oven-method reference, BBC Good Food the vegetable-roasting reference. The Sanelle ingredients differ; these are technique references, not verbatim borrowed recipes.

The recorded `prepTimeMinutes` is preserved as legacy preparation metadata. Overnight chilling and preparation of already-cooked ingredients add time. Ingredient notes make those prerequisites explicit. Scaling ingredients does not scale cooking times; use even pieces, avoid crowding and check doneness. Freeze suitable leftovers for later weeks; a saved monthly plan is not a claim that cooked food keeps for a month.

Validation uses an isolated PostgreSQL container: fresh migration, preservation of altered instructions/ingredients and ordered steps. Browser tests use throwaway accounts and the actual API; no patient data is required.
