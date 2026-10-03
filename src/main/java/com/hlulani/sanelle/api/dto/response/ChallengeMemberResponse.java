package com.hlulani.sanelle.api.dto.response;

import java.time.OffsetDateTime;
import java.util.UUID;

public record ChallengeMemberResponse(UUID userId, String username, OffsetDateTime joinedAt) {}
