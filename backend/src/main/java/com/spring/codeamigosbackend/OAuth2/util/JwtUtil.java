package com.spring.codeamigosbackend.OAuth2.util;
import io.github.cdimascio.dotenv.Dotenv;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
@Component
public class JwtUtil {
    private static Dotenv dotenv;
    private static final String SECRET_KEY;
    private static final SecretKey KEY;
    private static final long EXPIRATION_TIME = 24 * 60 * 60 * 1000; // 24 hour
    
    static {
        try {
            java.io.File envFile = new java.io.File(".env");
            if (envFile.exists()) {
                dotenv = Dotenv.load();
            } else {
                dotenv = Dotenv.configure().ignoreIfMissing().load();
            }
        } catch (Exception e) {
            dotenv = Dotenv.configure().ignoreIfMissing().load();
        }
        
        // Get JWT_SECRET_KEY from dotenv or system environment
        String key = dotenv.get("JWT_SECRET_KEY", null);
        if (key == null) {
            key = System.getProperty("JWT_SECRET_KEY");
            if (key == null) {
                key = System.getenv("JWT_SECRET_KEY");
            }
        }
        SECRET_KEY = key != null ? key : "qwertyuiopasdfghjklzxcvbnm1234567890QWERTYUIOP"; // fallback
        KEY = Keys.hmacShaKeyFor(SECRET_KEY.getBytes(StandardCharsets.UTF_8));
    }

    public static String generateToken(String id, String username, String email,String status) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("id", id);
        claims.put("username", username);
        claims.put("status",status);
        claims.put("email", email);

        return Jwts.builder()
                .setSubject(id)
                .addClaims(claims)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(KEY, SignatureAlgorithm.HS256)
                .compact();
    }

    public static Claims validateToken(String token) {
        return Jwts.parser()
                .verifyWith(KEY)
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }



    public static String getUserIdFromToken(String token) {
        return validateToken(token).getSubject();
    }
}