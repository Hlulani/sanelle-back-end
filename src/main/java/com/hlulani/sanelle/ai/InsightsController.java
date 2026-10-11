package com.hlulani.sanelle.ai;

import com.hlulani.sanelle.security.AuthenticatedUser;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/ai")
public class InsightsController {

    private final InsightsService insights;

    public InsightsController(InsightsService insights) {
        this.insights = insights;
    }

    /** Whether AI drafting is switched on, so the app knows whether to offer it. */
    @GetMapping("/status")
    public Map<String, Object> status() {
        String reason = insights.unavailableReason();
        return reason == null ? Map.of("available", true) : Map.of("available", false, "reason", reason);
    }

    @PostMapping("/insights")
    public ResponseEntity<InsightsResponse> insights(@AuthenticationPrincipal AuthenticatedUser principal,
                                                     @RequestBody InsightsRequest request) {
        if (principal == null) return ResponseEntity.status(401).build();
        return ResponseEntity.ok(insights.draft(principal.getUserId(), request));
    }
}
