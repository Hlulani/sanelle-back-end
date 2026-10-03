package com.hlulani.sanelle.controller;

import com.hlulani.sanelle.domain.entity.User;
import com.hlulani.sanelle.repository.UserRepository;
import com.hlulani.sanelle.service.ChallengeParticipationService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/challenges")
public class ChallengeController {

    private final ChallengeParticipationService challengeParticipationService;
    private final UserRepository userRepository;

    public ChallengeController(ChallengeParticipationService challengeParticipationService, UserRepository userRepository) {
        this.challengeParticipationService = challengeParticipationService;
        this.userRepository = userRepository;
    }

    @PostMapping("/{challengeId}/join")
    public ResponseEntity<Void> join(@PathVariable String challengeId, @AuthenticationPrincipal UserDetails principal) {
        UUID userId = resolveUserId(principal);
        challengeParticipationService.join(userId, challengeId);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/{challengeId}/join")
    public ResponseEntity<Void> leave(@PathVariable String challengeId, @AuthenticationPrincipal UserDetails principal) {
        UUID userId = resolveUserId(principal);
        challengeParticipationService.leave(userId, challengeId);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/counts")
    public ResponseEntity<Map<String, Long>> counts(@RequestParam String ids) {
        List<String> challengeIds = Arrays.stream(ids.split(","))
                .map(String::trim)
                .filter(id -> !id.isEmpty())
                .toList();
        return ResponseEntity.ok(challengeParticipationService.counts(challengeIds));
    }

    private UUID resolveUserId(UserDetails principal) {
        User user = userRepository.findByEmail(principal.getUsername())
                .orElseThrow(() -> new IllegalStateException("Authenticated but user missing in DB"));
        return user.getId();
    }
}
