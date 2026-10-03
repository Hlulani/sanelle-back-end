package com.hlulani.sanelle.service;

import com.hlulani.sanelle.domain.entity.ChallengeParticipant;
import com.hlulani.sanelle.repository.ChallengeParticipantRepository;
import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatCode;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class ChallengeParticipationServiceTest {

    private final ChallengeParticipantRepository repository = mock(ChallengeParticipantRepository.class);
    private final ChallengeParticipationService service = new ChallengeParticipationService(repository);

    @Test
    void joiningTwiceDoesNotThrowOrCreateASecondRow() {
        UUID userId = UUID.randomUUID();
        String challengeId = "weekly-5";
        ChallengeParticipant existing = new ChallengeParticipant(userId, challengeId);

        // First call: not joined yet. Second call: already joined (as if the first call's insert took effect).
        when(repository.findByUserIdAndChallengeId(userId, challengeId))
                .thenReturn(Optional.empty())
                .thenReturn(Optional.of(existing));

        assertThatCode(() -> {
            service.join(userId, challengeId);
            service.join(userId, challengeId);
        }).doesNotThrowAnyException();

        verify(repository, times(1)).save(any(ChallengeParticipant.class));
    }

    @Test
    void leavingAChallengeNeverJoinedDoesNotThrow() {
        UUID userId = UUID.randomUUID();

        assertThatCode(() -> service.leave(userId, "streak-3")).doesNotThrowAnyException();

        verify(repository).deleteByUserIdAndChallengeId(userId, "streak-3");
    }

    @Test
    void countsReturnsZeroForAChallengeNobodyJoined() {
        when(repository.countByChallengeId("consistency-14")).thenReturn(0L);

        Map<String, Long> counts = service.counts(List.of("consistency-14"));

        assertThat(counts).containsEntry("consistency-14", 0L);
    }

    @Test
    void countsReturnsTheNumberOfDistinctUsersWhoJoinedEachChallenge() {
        when(repository.countByChallengeId("weekly-5")).thenReturn(3L);
        when(repository.countByChallengeId("streak-3")).thenReturn(1L);

        Map<String, Long> counts = service.counts(List.of("weekly-5", "streak-3"));

        assertThat(counts).containsEntry("weekly-5", 3L).containsEntry("streak-3", 1L);
    }
}
