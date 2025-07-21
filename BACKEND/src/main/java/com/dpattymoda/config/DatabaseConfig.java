package com.dpattymoda.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import javax.sql.DataSource;
import org.springframework.boot.jdbc.DataSourceBuilder;

/**
 * Configuración de base de datos MySQL para DPattyModa
 */
@Configuration
@EnableJpaRepositories(basePackages = "com.dpattymoda.repository")
public class DatabaseConfig {

    @Primary
    @Bean
    @ConfigurationProperties("spring.datasource")
    public DataSource dataSource() {
        DataSourceBuilder<?> builder = DataSourceBuilder.create();
        builder.driverClassName("com.mysql.cj.jdbc.Driver");
        return builder.build();
    }
}