package com.spring.codeamigosbackend.personalchat.dto;

import com.spring.codeamigosbackend.personalchat.model.Message;
import lombok.Data;

import java.util.List;

@Data
public class PersonalChatResponseDto {
    private String id;
    private String githubUserName;
    private List<Message> messages;
    private String secretKey;
    private String secretKey1;

    public PersonalChatResponseDto(String githubUserName, List<Message> messages, String id, String secretKey,
            String secretKey1) {
        this.githubUserName = githubUserName;
        this.messages = messages;
        this.id = id;
        this.secretKey = secretKey;
        this.secretKey1 = secretKey1;
    }
}
