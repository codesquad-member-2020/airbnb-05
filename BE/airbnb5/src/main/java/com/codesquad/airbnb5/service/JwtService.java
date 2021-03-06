package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.domain.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
public class JwtService {

    private final String JWT_KEY;
    private SecretKey key;

    public JwtService(Environment env) {
        JWT_KEY = env.getProperty("JWT_KEY");
        key = Keys.hmacShaKeyFor(JWT_KEY.getBytes());
    }

    public String buildJwt(User user) {
        return Jwts.builder()
                .setHeader(createHeaders())
                .setClaims(createPayloads(user))
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();
    }

    public User parseJwt(String jwt) {
        jwt = jwt.replace("Bearer ", "");
        Claims claims = Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(jwt)
                .getBody();
        int id = (int) claims.get("id");
        String name = (String) claims.get("name");
        String email = (String) claims.get("email");
        return User.builder()
                .githubId(id)
                .githubName(name)
                .githubEmail(email)
                .build();
    }

    private Map<String, Object> createHeaders() {
        Map<String, Object> headers = new HashMap<>();
        headers.put("typ", "JWT");
        headers.put("alg", "HS256");
        return headers;
    }

    private Map<String, Object> createPayloads(User user) {
        Map<String, Object> payloads = new HashMap<>();
        payloads.put("id", user.getUserIndex());
        return payloads;
    }
}
