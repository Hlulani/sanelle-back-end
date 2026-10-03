-- Swap notes were written with an ASCII "->"; show a proper arrow instead.
UPDATE meals SET vegetable_substitutes = replace(vegetable_substitutes, '->', '→')
WHERE vegetable_substitutes LIKE '%->%';

UPDATE meals SET fresh_or_frozen = replace(fresh_or_frozen, '->', '→')
WHERE fresh_or_frozen LIKE '%->%';
