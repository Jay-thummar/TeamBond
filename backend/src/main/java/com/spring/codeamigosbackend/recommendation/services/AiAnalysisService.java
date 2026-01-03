package com.spring.codeamigosbackend.recommendation.services;

import com.spring.codeamigosbackend.recommendation.dtos.RepositoryInfo;
import com.spring.codeamigosbackend.registration.model.User;
import com.spring.codeamigosbackend.registration.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AiAnalysisService {
    private static final Logger logger = LoggerFactory.getLogger(AiAnalysisService.class);

    private final ChatClient chatClient;
    private final GithubApiService githubApiService;
    private final UserRepository userRepository;

    public AiAnalysisService(ChatClient.Builder chatClientBuilder, GithubApiService githubApiService,
            UserRepository userRepository) {
        this.chatClient = chatClientBuilder.build();
        this.githubApiService = githubApiService;
        this.userRepository = userRepository;
    }

    public void analyzeUserProfile(String username, String accessToken) {
        logger.info("Starting AI Agentic Analysis for user: " + username);

        // Step 1: Agentic Discovery (Get light inventory)
        List<RepositoryInfo> allRepos = githubApiService.listAllRepositories(username, accessToken);
        StringBuilder repoInventory = new StringBuilder();
        for (RepositoryInfo repo : allRepos) {
            repoInventory.append(String.format("Repo: %s, Branch: %s\n", repo.getName(), repo.getDefaultBranch()));
        }

        // Step 2 & 3: Agentic Reasoning & Selective Fetching (Simulated Agent Loop)
        // In a full agent, the LLM calls tools. Here we simulate the optimizing prompt
        // to save tokens.
        // We give the list to LLM and ask it "Which files should I inspect to
        // understand the stack?"
        // Ideally, we fetch top 10 significant repos' manifest files.

        StringBuilder collectedData = new StringBuilder();
        collectedData.append("User Repositories Inventory:\n").append(repoInventory).append("\n\n");
        collectedData.append("Detailed File Contents from Significant Repos:\n");

        int inspectedCount = 0;
        for (RepositoryInfo repo : allRepos) {
            if (inspectedCount >= 10)
                break; // Analyze top 10 most recent

            // "Inbuilt MCP" Logic: Use pre-fetched data directly! (Zero Latency)
            Map<String, String> configFiles = repo.getConfigFiles();

            if (configFiles != null) {
                if (configFiles.containsKey("package.json")) {
                    collectedData.append(
                            String.format("--- Repo: %s, File: package.json ---\n%s\n", repo.getName(),
                                    configFiles.get("package.json")));
                }
                if (configFiles.containsKey("pom.xml")) {
                    collectedData.append(
                            String.format("--- Repo: %s, File: pom.xml ---\n%s\n", repo.getName(),
                                    configFiles.get("pom.xml")));
                }
                if (configFiles.containsKey("requirements.txt")) {
                    collectedData.append(
                            String.format("--- Repo: %s, File: requirements.txt ---\n%s\n", repo.getName(),
                                    configFiles.get("requirements.txt")));
                }
            }

            inspectedCount++;
        }

        // Step 4: Final Analysis (LLM Processing)
        String prompt = """
                You are a Senior Technical Recruiter and Code Analyst.
                Analyze the following raw GitHub data for user '%s'.

                Data Provided:
                1. List of all repositories (sorted by date).
                2. Content of dependency files (package.json, pom.xml) for the most relevant projects.

                Your Task:
                1. Identify the user's PRIMARY tech stack (e.g., "Full Stack Java + React").
                2. Estimate a proficiency score (0-100) for each skill found based on the complexity of dependencies and number of projects.
                3. Return ONLY a valid JSON object with the following structure:
                {
                    "primary_title": "String",
                    "skills": {
                        "Java": 90,
                        "React": 80,
                        "Spring Boot": 85
                    }
                }
                Do not include markdown formatting like ```json.

                Raw Data:
                %s
                """
                .formatted(username, collectedData.toString());

        try {
            String jsonResponse = chatClient.prompt().user(prompt).call().content();
            logger.info("AI Analysis Result: " + jsonResponse);

            // Clean cleanup json if marked down
            if (jsonResponse.startsWith("```json")) {
                jsonResponse = jsonResponse.substring(7, jsonResponse.length() - 3);
            }

            // Save to DB
            User user = userRepository.findByUsername(username).orElseThrow();

            // Simplistic JSON parsing (In real app, use ObjectMapper)
            // For now, storing as generic Object in DB or map if we parsed it.
            // Storing raw string for demonstration, but ideal is Map.
            com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
            Map<String, Object> profile = mapper.readValue(jsonResponse, Map.class);

            user.setTechProfile(profile);
            user.setRawGithubData(repoInventory.toString()); // Store summary
            userRepository.save(user);
            logger.info("Saved AI Profile to Database");

        } catch (Exception e) {
            logger.error("AI Analysis Failed", e);
        }
    }
}
