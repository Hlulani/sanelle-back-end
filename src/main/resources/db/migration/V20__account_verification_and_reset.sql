-- V20__account_verification_and_reset.sql
-- Accounts get a display name, a record of when the terms were accepted and when the
-- address was confirmed. Links sent by email (verify address, reset password) are kept
-- only as a SHA-256 hash of the token, never the token itself.

ALTER TABLE users ADD COLUMN display_name VARCHAR(80);
ALTER TABLE users ADD COLUMN email_verified_at TIMESTAMPTZ;
ALTER TABLE users ADD COLUMN terms_accepted_at TIMESTAMPTZ;

-- Everyone who signed up before verification existed is treated as verified.
UPDATE users SET email_verified_at = now() WHERE email_verified_at IS NULL;

CREATE TABLE email_tokens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    purpose VARCHAR(20) NOT NULL CHECK (purpose IN ('VERIFY_EMAIL', 'RESET_PASSWORD')),
    token_hash VARCHAR(64) NOT NULL UNIQUE,
    expires_at TIMESTAMPTZ NOT NULL,
    used_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_email_tokens_user_id ON email_tokens(user_id);
