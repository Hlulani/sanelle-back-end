package com.hlulani.sanelle.support;

import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.boot.testcontainers.service.connection.ServiceConnection;
import org.springframework.context.annotation.Bean;
import org.testcontainers.containers.PostgreSQLContainer;

/**
 * A throwaway PostgreSQL for integration tests, the same major version as production. Spring
 * points the datasource at it, Flyway migrates it, and it's discarded after the run. Spring's
 * test-context cache shares one container across every test class that imports this.
 */
@TestConfiguration(proxyBeanMethods = false)
public class PostgresTestConfiguration {

    @Bean
    @ServiceConnection
    PostgreSQLContainer<?> postgres() {
        return new PostgreSQLContainer<>("postgres:16-alpine");
    }
}
