-- The anti-inflammatory, iron and fibre "scores" were hand-entered 0-5 numbers with
-- no documented method. They are no longer used for choosing meals or shown anywhere.
ALTER TABLE meals DROP COLUMN anti_inflammatory_score;
ALTER TABLE meals DROP COLUMN iron_support;
ALTER TABLE meals DROP COLUMN fiber_score;
