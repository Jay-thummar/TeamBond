package com.spring.codeamigosbackend.recommendation.services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.codeamigosbackend.hackathon.model.Hackathon;
import com.spring.codeamigosbackend.registration.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class HackathonMatcherService {

    private final ChatClient chatClient;
    private final ObjectMapper objectMapper;
    private static final Logger logger = LoggerFactory.getLogger(HackathonMatcherService.class);

    public HackathonMatcherService(ChatClient.Builder chatClientBuilder, ObjectMapper objectMapper) {
        this.chatClient = chatClientBuilder.build();
        this.objectMapper = objectMapper;
    }

    /**
     * Ranks a list of users based on their fit for the given hackathon.
     * Returns a list of Maps containing: {"userId": "...", "score": 90, "reason":
     * "..."}
     */
    public List<Map<String, Object>> rankCandidates(Hackathon hackathon, List<User> candidates) {
        if (candidates == null || candidates.isEmpty()) {
            return new ArrayList<>();
        }

        // 1. Prepare Hackathon Context
        String hackathonContext = String.format("""
                Hackathon Title: %s
                Theme: %s
                Required Tech Stacks: %s
                Description: %s
                """,
                hackathon.getTitle(),
                hackathon.getTheme(),
                hackathon.getTechStacks(),
                hackathon.getAbout());

        // 2. Prepare Candidates Context (Anonymized or minimal data to save tokens)
        StringBuilder candidatesContext = new StringBuilder();
        for (User user : candidates) {
            // Skip users without profile analysis
            if (user.getTechProfile() == null)
                continue;

            candidatesContext.append(String.format("""
                    - Candidate ID: %s
                      Username: %s
                      Tech Profile: %s
                    """,
                    user.getId(),
                    user.getUsername(),
                    user.getTechProfile().toString()));
        }

        if (candidatesContext.length() == 0) {
            logger.warn("No candidates with tech profiles found for matching.");
            return new ArrayList<>();
        }

        // 3. Construct AI Prompt
        String prompt = """
                You are an Expert AI Recruiter.
                Your task is to RANK the following candidates for a specific Hackathon team.

                === HACKATHON DETAILS ===
                %s

                === CANDIDATES ===
                %s

                === INSTRUCTIONS ===
                1. Analyze each candidate's Tech Profile against the Hackathon requirements.
                2. Assign a 'match_score' (0-100).
                3. Provide a brief 1-sentence 'reason' for the score.
                4. Return the result as a strictly valid JSON List.

                Output Format:
                [
                    {
                        "userId": "candidate_id_here",
                        "username": "candidate_username",
                        "match_score": 85,
                        "reason": "Strong Java skills match the backend requirement."
                    },
                    ...
                ]

                Do not include markdown formatting (like ```json). Return RAW JSON only.
                """.formatted(hackathonContext, candidatesContext.toString());

        // 4. Call AI & Parse Result
        try {
            String jsonResponse = chatClient.prompt().user(prompt).call().content();

            // Cleanup markdown if present
            if (jsonResponse.startsWith("```json")) {
                jsonResponse = jsonResponse.substring(7, jsonResponse.length() - 3);
            } else if (jsonResponse.startsWith("```")) {
                jsonResponse = jsonResponse.substring(3, jsonResponse.length() - 3);
            }

            // Parse JSON to List of Maps
            List<Map<String, Object>> ranking = objectMapper.readValue(jsonResponse, List.class);

            // Sort by score descending (just in case AI didn't sort perfectly)
            ranking.sort((a, b) -> {
                Integer scoreA = (Integer) a.get("match_score");
                Integer scoreB = (Integer) b.get("match_score");
                return scoreB.compareTo(scoreA);
            });

            return ranking;

        } catch (Exception e) {
            logger.error("AI Matching Failed", e);
            return new ArrayList<>();
        }
    }
}
