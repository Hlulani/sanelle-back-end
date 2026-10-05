package com.hlulani.sanelle.mapper;

import com.hlulani.sanelle.api.dto.response.ChallengeMemberResponse;
import com.hlulani.sanelle.api.dto.response.CustomChallengeResponse;
import com.hlulani.sanelle.domain.entity.ChallengeParticipant;
import com.hlulani.sanelle.domain.entity.CustomChallenge;

import java.util.UUID;

public final class CustomChallengeMapper {

    private CustomChallengeMapper() {}

    public static CustomChallengeResponse toResponse(CustomChallenge challenge, String creatorUsername, UUID requestingUserId) {
        return new CustomChallengeResponse(
                challenge.getId(),
                challenge.getName(),
                challenge.getDescription(),
                challenge.getType(),
                challenge.getTargetCount(),
                challenge.getDurationDays(),
                challenge.getInviteCode(),
                challenge.getCreatedByUserId(),
                creatorUsername,
                challenge.getCreatedAt(),
                challenge.isCreatedBy(requestingUserId)
        );
    }

    public static ChallengeMemberResponse toMember(ChallengeParticipant participant, String username) {
        return new ChallengeMemberResponse(participant.getUserId(), username, participant.getJoinedAt());
    }
}
