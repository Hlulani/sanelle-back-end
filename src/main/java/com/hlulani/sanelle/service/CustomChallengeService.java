package com.hlulani.sanelle.service;

import com.hlulani.sanelle.domain.entity.ChallengeParticipant;
import com.hlulani.sanelle.domain.entity.CustomChallenge;
import com.hlulani.sanelle.domain.entity.User;
import com.hlulani.sanelle.exception.ChallengeNotFoundException;
import com.hlulani.sanelle.repository.ChallengeParticipantRepository;
import com.hlulani.sanelle.repository.CustomChallengeRepository;
import com.hlulani.sanelle.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.time.OffsetDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Transactional
public class CustomChallengeService {

    private static final String CODE_ALPHABET = "ABCDEFGHJKMNPQRSTUVWXYZ23456789"; // no 0/O, 1/I/L — avoids human misreads
    private static final int CODE_LENGTH = 8;

    private final CustomChallengeRepository customChallengeRepository;
    private final ChallengeParticipantRepository challengeParticipantRepository;
    private final ChallengeParticipationService challengeParticipationService;
    private final UserRepository userRepository;

    public CustomChallengeService(CustomChallengeRepository customChallengeRepository,
                                   ChallengeParticipantRepository challengeParticipantRepository,
                                   ChallengeParticipationService challengeParticipationService,
                                   UserRepository userRepository) {
        this.customChallengeRepository = customChallengeRepository;
        this.challengeParticipantRepository = challengeParticipantRepository;
        this.challengeParticipationService = challengeParticipationService;
        this.userRepository = userRepository;
    }

    public CustomChallenge create(UUID creatorUserId, String name, String description,
                                   String type, int targetCount, int durationDays) {
        String code = generateUniqueInviteCode();
        CustomChallenge challenge = new CustomChallenge(
                name, description, type, targetCount, durationDays, code, creatorUserId
        );
        customChallengeRepository.save(challenge);
        challengeParticipationService.join(creatorUserId, challenge.getId().toString());
        return challenge;
    }

    public CustomChallenge joinByCode(UUID userId, String inviteCode) {
        CustomChallenge challenge = customChallengeRepository.findByInviteCode(inviteCode.trim().toUpperCase())
                .orElseThrow(() -> new ChallengeNotFoundException(inviteCode));
        challengeParticipationService.join(userId, challenge.getId().toString());
        return challenge;
    }

    @Transactional(readOnly = true)
    public List<CustomChallenge> mineOrJoined(UUID userId) {
        return customChallengeRepository.findMineOrJoined(userId);
    }

    /** Only for people who are actually a participant (or the creator) — enforce in the controller/here, not just the DB. */
    @Transactional(readOnly = true)
    public boolean isMember(UUID userId, CustomChallenge challenge) {
        if (challenge.getCreatedByUserId().equals(userId)) return true;
        return challengeParticipantRepository.findByUserIdAndChallengeId(userId, challenge.getId().toString()).isPresent();
    }

    @Transactional(readOnly = true)
    public List<ChallengeMember> getMembers(CustomChallenge challenge) {
        List<ChallengeParticipant> participants = challengeParticipantRepository.findByChallengeId(challenge.getId().toString());
        Map<UUID, User> usersById = userRepository.findAllById(
                participants.stream().map(ChallengeParticipant::getUserId).toList()
        ).stream().collect(Collectors.toMap(User::getId, u -> u));

        return participants.stream()
                .map(p -> new ChallengeMember(p.getUserId(), usersById.get(p.getUserId()).getUsername(), p.getJoinedAt()))
                .sorted(Comparator.comparing(ChallengeMember::joinedAt))
                .toList();
    }

    private String generateUniqueInviteCode() {
        SecureRandom random = new SecureRandom();
        for (int attempt = 0; attempt < 10; attempt++) {
            StringBuilder sb = new StringBuilder(CODE_LENGTH);
            for (int i = 0; i < CODE_LENGTH; i++) {
                sb.append(CODE_ALPHABET.charAt(random.nextInt(CODE_ALPHABET.length())));
            }
            String code = sb.toString();
            if (!customChallengeRepository.existsByInviteCode(code)) return code;
        }
        throw new IllegalStateException("Could not generate a unique invite code after 10 attempts");
    }

    public record ChallengeMember(UUID userId, String username, OffsetDateTime joinedAt) {}
}
