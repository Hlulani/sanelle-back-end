-- V10__add_username.sql
-- Adds a user-chosen username. Existing rows (this dev DB is not actually empty)
-- get a generated placeholder so the column can be made NOT NULL + unique.

ALTER TABLE users ADD COLUMN username VARCHAR(20);

UPDATE users
SET username = 'user_' || substr(id::text, 1, 8)
WHERE username IS NULL;

ALTER TABLE users ALTER COLUMN username SET NOT NULL;

CREATE UNIQUE INDEX users_username_unique_idx ON users (LOWER(username));
