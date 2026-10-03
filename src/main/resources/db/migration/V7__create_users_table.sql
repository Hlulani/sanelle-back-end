-- 1. Create the table only if it's missing
CREATE TABLE IF NOT EXISTS users (
                                     id UUID PRIMARY KEY,
                                     email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL
                             );

-- 2. Reconcile the password column with the Java entity, which maps to 'password'.
-- V6 added 'password_hash'; on a fresh database V5 has already created 'password',
-- so drop the unused column instead of renaming it.
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='users' AND column_name='password_hash') THEN
        IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='users' AND column_name='password') THEN
            ALTER TABLE users DROP COLUMN password_hash;
        ELSE
            ALTER TABLE users RENAME COLUMN password_hash TO password;
        END IF;
    END IF;
END $$;
