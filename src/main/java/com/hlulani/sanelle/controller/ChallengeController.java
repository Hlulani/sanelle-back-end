package com.hlulani.sanelle.controller;

import com.hlulani.sanelle.security.AuthenticatedUser;
import com.hlulani.sanelle.service.ChallengeParticipationService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/challenges")
public class ChallengeController {

    private final ChallengeParticipationService participation;

    public ChallengeController(ChallengeParticipationService participation) {
        this.participation = participation;
    }

    @PostMapping("/{challengeId}/join")
    public ResponseEntity<Void> join(@PathVariable String challengeId, @AuthenticationPrincipal AuthenticatedUser user) {
        participation.join(user.getUserId(), challengeId);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/{challengeId}/join")
    public ResponseEntity<Void> leave(@PathVariable String challengeId, @AuthenticationPrincipal AuthenticatedUser user) {
        participation.leave(user.getUserId(), challengeId);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/counts")
    public Map<String, Long> counts(@RequestParam String ids) {
        List<String> challengeIds = Arrays.stream(ids.split(","))
                .map(String::trim)
                .filter(id -> !id.isEmpty())
                .toList();
        return participation.counts(challengeIds);
    }
}
