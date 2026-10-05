package com.hlulani.sanelle.service;

import com.hlulani.sanelle.domain.entity.ChallengeParticipant;
import com.hlulani.sanelle.repository.ChallengeParticipantRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/** The one way into challenge participation, for built-in and custom challenges alike. */
@Service
@Transactional
public class ChallengeParticipationService {

    private final ChallengeParticipantRepository repository;

    public ChallengeParticipationService(ChallengeParticipantRepository repository) {
        this.repository = repository;
    }

    public void join(UUID userId, String challengeId) {
        repository.findByUserIdAndChallengeId(userId, challengeId)
                .ifPresentOrElse(
                        ChallengeParticipant::refreshJoinedAt,
                        () -> repository.save(new ChallengeParticipant(userId, challengeId))
                );
    }

    public void leave(UUID userId, String challengeId) {
        repository.deleteByUserIdAndChallengeId(userId, challengeId);
    }

    /** Everyone leaves, for a challenge that no longer exists. */
    public void removeAll(String challengeId) {
        repository.deleteByChallengeId(challengeId);
    }

    @Transactional(readOnly = true)
    public boolean isParticipant(UUID userId, String challengeId) {
        return repository.findByUserIdAndChallengeId(userId, challengeId).isPresent();
    }

    @Transactional(readOnly = true)
    public List<ChallengeParticipant> participants(String challengeId) {
        return repository.findByChallengeId(challengeId);
    }

    @Transactional(readOnly = true)
    public Map<String, Long> counts(List<String> challengeIds) {
        Map<String, Long> counts = new LinkedHashMap<>();
        for (String challengeId : challengeIds) {
            counts.put(challengeId, repository.countByChallengeId(challengeId));
        }
        return counts;
    }
}
