package com.spring.codeamigosbackend.config;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Component
public class CustomCorsConfiguration implements CorsConfigurationSource {
    
    @Value("${frontend.url:}")
    private String frontendUrl;
    
    @Value("${cors.allowed.origins:*}")
    private String allowedOrigins;

    @Override
    public CorsConfiguration getCorsConfiguration(HttpServletRequest request) {
        CorsConfiguration config = new CorsConfiguration();
        
        // Build allowed origins list
        List<String> origins = new ArrayList<>();
        
        // If CORS_ALLOWED_ORIGINS is set, use it (comma-separated)
        if (allowedOrigins != null && !allowedOrigins.equals("*") && !allowedOrigins.isEmpty()) {
            origins.addAll(Arrays.asList(allowedOrigins.split(",")));
        }
        
        // Add frontend URL if provided
        if (frontendUrl != null && !frontendUrl.isEmpty()) {
            origins.add(frontendUrl);
        }
        
        // If no origins specified, allow all (for development)
        if (origins.isEmpty()) {
            config.addAllowedOriginPattern("*");
        } else {
            config.setAllowedOrigins(origins);
        }
        
        config.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS"));
        config.setAllowedHeaders(List.of("*"));
        config.setAllowCredentials(true);
        config.addExposedHeader("Authorization");
        config.setMaxAge(3600L);
        return config;
    }
}
