package com.hlulani.sanelle.config;

import com.hlulani.sanelle.controller.DevOutboxController;
import com.hlulani.sanelle.service.ImageStorage;
import com.hlulani.sanelle.security.JwtAuthenticationFilter;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.List;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final JwtAuthenticationFilter jwtAuthFilter;
    private final List<String> allowedOrigins;
    private final boolean outboxEnabled;

    public SecurityConfig(JwtAuthenticationFilter jwtAuthFilter,
                          @Value("${app.cors.allowed-origins}") List<String> allowedOrigins,
                          @Value("${app.mail.outbox.enabled:false}") boolean outboxEnabled) {
        this.jwtAuthFilter = jwtAuthFilter;
        this.allowedOrigins = allowedOrigins;
        this.outboxEnabled = outboxEnabled;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                // 1. MUST come first - use the bean defined below
                .cors(cors -> cors.configurationSource(corsConfigurationSource()))
                // 2. Disable CSRF for Stateless APIs
                .csrf(csrf -> csrf.disable())
                // 3. Configure Request Authorization
                .authorizeHttpRequests(auth -> {
                    // Explicitly permit OPTIONS (Preflight) requests
                    auth.requestMatchers(org.springframework.http.HttpMethod.OPTIONS, "/**").permitAll();
                    // Sign-up, sign-in, email links and password reset; /me checks its own principal
                    auth.requestMatchers("/api/v1/auth/**").permitAll();
                    auth.requestMatchers(ImageStorage.URL_PATTERN).permitAll();
                    auth.requestMatchers("/v3/api-docs/**", "/swagger-ui/**", "/swagger-ui.html").permitAll();
                    // Development outbox: open only when switched on; otherwise it doesn't exist at all
                    if (outboxEnabled) {
                        auth.requestMatchers(DevOutboxController.PATH).permitAll();
                    }
                    auth.anyRequest().authenticated();
                })
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
                .exceptionHandling(ex -> ex
                        .authenticationEntryPoint((request, response, authException) ->
                                response.sendError(HttpServletResponse.SC_UNAUTHORIZED))
                )
                .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }
    // 👇 ADD THIS METHOD TO FIX THE ERROR
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        // Defaults cover the frontend dev servers (Ionic + Angular), plus the native app's
        // WebView origins: Capacitor's default scheme is capacitor://localhost on iOS and
        // http://localhost (no port) on Android. Override with CORS_ALLOWED_ORIGINS.
        configuration.setAllowedOrigins(allowedOrigins);
        // Allow all methods including OPTIONS
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));
        // Be very explicit about allowed headers
        configuration.setAllowedHeaders(Arrays.asList("Authorization", "Content-Type", "Accept", "X-Requested-With", "Origin"));
        // Allow the browser to send the Authorization header
        configuration.setAllowCredentials(true);
        // Important for browsers to remember this is allowed
        configuration.setMaxAge(3600L);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}