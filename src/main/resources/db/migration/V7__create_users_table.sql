-- 1. Create the table only if it's missing
CREATE TABLE IF NOT EXISTS users (
                                     id UUID PRIMARY KEY,
                                     email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL
                             );

-- 2. If the table existed but had the wrong column name, this ensures it matches your Java code
-- Note: Use this only if your DB currently has 'password_hash' and you want 'password'
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='users' AND column_name='password_hash') THEN
ALTER TABLE users RENAME COLUMN password_hash TO password;
END IF;
END $$;