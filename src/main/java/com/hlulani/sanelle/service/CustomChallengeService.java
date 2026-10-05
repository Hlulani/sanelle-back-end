package com.hlulani.sanelle.service;

import com.hlulani.sanelle.api.dto.response.ChallengeMemberResponse;
import com.hlulani.sanelle.api.dto.response.CustomChallengeResponse;
import com.hlulani.sanelle.domain.entity.ChallengeParticipant;
import com.hlulani.sanelle.domain.entity.CustomChallenge;
import com.hlulani.sanelle.domain.entity.User;
import com.hlulani.sanelle.exception.ChallengeNotFoundException;
import com.hlulani.sanelle.exception.NotChallengeMemberException;
import com.hlulani.sanelle.mapper.CustomChallengeMapper;
import com.hlulani.sanelle.repository.CustomChallengeRepository;
import com.hlulani.sanelle.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.util.Collection;
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
    private static final int CODE_ATTEMPTS = 10;

    private final CustomChallengeRepository challenges;
    private final ChallengeParticipationService participation;
    private final UserRepository users;
    private final SecureRandom random = new SecureRandom();

    public CustomChallengeService(CustomChallengeRepository challenges,
                                  ChallengeParticipationService participation,
                                  UserRepository users) {
        this.challenges = challenges;
        this.participation = participation;
        this.users = users;
    }

    public CustomChallengeResponse create(UUID creatorUserId, String name, String description,
                                          String type, int targetCount, int durationDays) {
        CustomChallenge challenge = challenges.save(new CustomChallenge(
                name, description, type, targetCount, durationDays, generateUniqueInviteCode(), creatorUserId
        ));
        participation.join(creatorUserId, challenge.participationKey());
        return toResponses(List.of(challenge), creatorUserId).get(0);
    }

    public CustomChallengeResponse joinByCode(UUID userId, String inviteCode) {
        CustomChallenge challenge = challenges.findByInviteCode(inviteCode.trim().toUpperCase())
                .orElseThrow(() -> new ChallengeNotFoundException(inviteCode));
        participation.join(userId, challenge.participationKey());
        return toResponses(List.of(challenge), userId).get(0);
    }

    @Transactional(readOnly = true)
    public List<CustomChallengeResponse> mineOrJoined(UUID userId) {
        return toResponses(challenges.findMineOrJoined(userId), userId);
    }

    /** Members are only shown to people in the challenge, creator included. */
    @Transactional(readOnly = true)
    public List<ChallengeMemberResponse> members(UUID requestingUserId, UUID challengeId) {
        CustomChallenge challenge = challenges.findById(challengeId)
                .orElseThrow(() -> new ChallengeNotFoundException(challengeId.toString()));
        if (!challenge.isCreatedBy(requestingUserId)
                && !participation.isParticipant(requestingUserId, challenge.participationKey())) {
            throw new NotChallengeMemberException();
        }

        List<ChallengeParticipant> participants = participation.participants(challenge.participationKey());
        Map<UUID, String> names = usernames(participants.stream().map(ChallengeParticipant::getUserId).toList());
        return participants.stream()
                .filter(p -> names.containsKey(p.getUserId())) // a deleted account is no longer listed
                .sorted(Comparator.comparing(ChallengeParticipant::getJoinedAt))
                .map(p -> CustomChallengeMapper.toMember(p, names.get(p.getUserId())))
                .toList();
    }

    /** Removes the challenges someone created, and everyone's membership of them. */
    public void deleteCreatedBy(UUID userId) {
        List<CustomChallenge> created = challenges.findByCreatedByUserId(userId);
        created.forEach(c -> participation.removeAll(c.participationKey()));
        challenges.deleteAll(created);
    }

    /** Maps challenges for one viewer, loading every creator's name in a single query. */
    private List<CustomChallengeResponse> toResponses(List<CustomChallenge> list, UUID viewerId) {
        Map<UUID, String> creators = usernames(list.stream().map(CustomChallenge::getCreatedByUserId).distinct().toList());
        return list.stream()
                .map(c -> CustomChallengeMapper.toResponse(c, creators.get(c.getCreatedByUserId()), viewerId))
                .toList();
    }

    private Map<UUID, String> usernames(Collection<UUID> userIds) {
        return users.findAllById(userIds).stream().collect(Collectors.toMap(User::getId, User::getUsername));
    }

    private String generateUniqueInviteCode() {
        for (int attempt = 0; attempt < CODE_ATTEMPTS; attempt++) {
            StringBuilder sb = new StringBuilder(CODE_LENGTH);
            for (int i = 0; i < CODE_LENGTH; i++) {
                sb.append(CODE_ALPHABET.charAt(random.nextInt(CODE_ALPHABET.length())));
            }
            String code = sb.toString();
            if (!challenges.existsByInviteCode(code)) return code;
        }
        throw new IllegalStateException("Could not generate a unique invite code after " + CODE_ATTEMPTS + " attempts");
    }
}
