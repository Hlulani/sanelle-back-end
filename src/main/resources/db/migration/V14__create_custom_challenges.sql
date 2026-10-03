CREATE TABLE IF NOT EXISTS custom_challenges (
    id UUID PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(280),
    type VARCHAR(32) NOT NULL,
    target_count INTEGER NOT NULL,
    duration_days INTEGER NOT NULL,
    invite_code VARCHAR(16) NOT NULL,
    created_by_user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL,
    CONSTRAINT uq_custom_challenges_invite_code UNIQUE (invite_code)
);

CREATE INDEX IF NOT EXISTS idx_custom_challenges_created_by ON custom_challenges(created_by_user_id);
