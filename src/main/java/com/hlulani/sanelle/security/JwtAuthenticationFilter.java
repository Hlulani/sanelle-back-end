package com.hlulani.sanelle.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import java.io.IOException;
import java.util.UUID;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;

    public JwtAuthenticationFilter(JwtService jwtService) {
        this.jwtService = jwtService;
    }

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain
    ) throws ServletException, IOException {

        String authHeader = request.getHeader("Authorization");

        // 1. Check if the header is missing or doesn't start with Bearer
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }

        // 2. Extract the token (everything after "Bearer ")
        String token = authHeader.substring(7);

        try {
            String email = jwtService.getEmail(token);

            // 3. If email is extracted and user is not already authenticated
            if (email != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                UUID userId = jwtService.getUserId(token);

                AuthenticatedUser principal = new AuthenticatedUser(userId, email);

                UsernamePasswordAuthenticationToken authentication =
                        new UsernamePasswordAuthenticationToken(
                                principal,
                                null,
                                principal.getAuthorities()
                        );

                authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

                // 4. Set the authentication in the context
                SecurityContextHolder.getContext().setAuthentication(authentication);

                // Logging for the Senior Dev to confirm success in the console
                System.out.println("DEBUG: JWT Auth successful for user: " + email);
            }
        } catch (Exception ex) {
            // 5. If extraction fails (expired, wrong secret, etc.), we log the reason
            System.err.println("DEBUG: JWT Auth failed. Reason: " + ex.getMessage());
            SecurityContextHolder.clearContext();
        }

        filterChain.doFilter(request, response);
    }
}