package com.hlulani.sanelle.api.dto.response;

import com.hlulani.sanelle.domain.entity.User;

import java.util.List;
import java.util.UUID;

/** {@code name} is the display name, or the username for accounts without one. */
public record UserResponse(UUID id, String email, String username, String name, boolean emailVerified,
                           List<String> roles) {
    public static UserResponse from(User user, List<String> roles) {
        return new UserResponse(user.getId(), user.getEmail(), user.getUsername(), user.getName(),
                user.isEmailVerified(), roles);
    }
}
