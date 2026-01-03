package com.spring.codeamigosbackend.rabbitmq.producer;

import com.spring.codeamigosbackend.recommendation.dtos.GithubScoreRequest;
import io.github.cdimascio.dotenv.Dotenv;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Service;

import java.io.File;

@Service
@RequiredArgsConstructor
public class RabbitMqProducer {

    private static Dotenv dotenv;
    
    static {
        try {
            File envFile = new File(".env");
            if (envFile.exists()) {
                dotenv = Dotenv.load();
            } else {
                dotenv = Dotenv.configure().ignoreIfMissing().load();
            }
        } catch (Exception e) {
            dotenv = Dotenv.configure().ignoreIfMissing().load();
        }
    }
    
    private static String getEnv(String key) {
        String value = dotenv.get(key, null);
        if (value == null) {
            value = System.getProperty(key);
            if (value == null) {
                value = System.getenv(key);
            }
        }
        return value;
    }

    private final RabbitTemplate rabbitTemplate;
    private static final Logger logger = LoggerFactory.getLogger(RabbitMqProducer.class);

    private final String exchangeName = getEnv("rabbitmq.exchange");
    private final String routingKey = getEnv("rabbitmq.routingKey");

    public void sendUserToQueue(GithubScoreRequest user) {
            logger.info("Sending user to queue",user);
            rabbitTemplate.convertAndSend(exchangeName, routingKey, user);
    }
}
