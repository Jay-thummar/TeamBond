package com.spring.codeamigosbackend.recommendation.services;

import com.spring.codeamigosbackend.recommendation.dtos.GithubScoreRequest;
import com.spring.codeamigosbackend.recommendation.dtos.RepositoryInfo;
import com.spring.codeamigosbackend.recommendation.models.UserFrameworkStats;
import com.spring.codeamigosbackend.recommendation.repositories.UserFrameworkStatsRepository;
import com.spring.codeamigosbackend.recommendation.utils.ApiException;
import com.spring.codeamigosbackend.registration.model.User;
import com.spring.codeamigosbackend.registration.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;

@Service
@RequiredArgsConstructor
public class FrameworkAnalysisService {

    private final GithubApiService githubApiService;
    private final UserFrameworkStatsRepository userFrameworkStatsRepository;
    private final UserRepository userRepository;
    private final AiAnalysisService aiAnalysisService; // Inject new AI Service
    private static final Logger logger = LoggerFactory.getLogger(FrameworkAnalysisService.class);

    // Keep old method for backward compatibility if needed, or deprecate
    public void analyseUserFrameworkStats(GithubScoreRequest request) {
        // ... old logic ...
    }

    public UserFrameworkStats getUserFrameworkStats(String username) {
        User user = this.userRepository.findByUsername(username).get();
        UserFrameworkStats stats = this.userFrameworkStatsRepository.findByUserId(user.getId()).get();
        return stats;
    }

    @RabbitListener(queues = { "${rabbitmq.queue}" })
    public void calculateUserFrameworkStats(GithubScoreRequest request) {
        try {
            logger.info("Processing message for user: {}", request.getUsername());

            // --- NEW AI AGENT FLOW ---
            // Instead of old regex logic, we call the AI Agent
            aiAnalysisService.analyzeUserProfile(request.getUsername(), request.getAccessToken());

        } catch (Exception e) {
            logger.error("Error processing message for user {}: {}", request.getUsername(), e.getMessage());
            // throw e; // Optional: decide if you want to retry on AI failure
        }
    }
}