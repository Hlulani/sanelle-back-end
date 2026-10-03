package com.hlulani.sanelle.config;

import com.hlulani.sanelle.security.JwtProperties;
import com.hlulani.sanelle.security.JwtService;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(JwtProperties.class)
public class JwtConfig {

    @Bean
    public JwtService jwtService(JwtProperties props) {
        return new JwtService(props);
    }
}
