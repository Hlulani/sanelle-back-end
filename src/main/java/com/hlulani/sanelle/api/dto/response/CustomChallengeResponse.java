package com.hlulani.sanelle.api.dto.response;

import java.time.OffsetDateTime;
import java.util.UUID;

public record CustomChallengeResponse(
        UUID id,
        String name,
        String description,
        String type,
        int targetCount,
        int durationDays,
        String inviteCode,
        UUID createdByUserId,
        String createdByUsername,
        OffsetDateTime createdAt,
        boolean isCreator
) {}
