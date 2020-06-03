package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.domain.User;
import com.codesquad.airbnb5.exception.AuthorizationException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
public class JwtService {

    SecretKey key = Keys.hmacShaKeyFor("".getBytes());

    public String buildJwt(User user) {
        return Jwts.builder()
                .setHeader(createHeaders())
                .setClaims(createPayloads(user))
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();
    }

    public User parseJwt(String jwt) {
        Claims claims = Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(jwt)
                .getBody();
        int id = (int) claims.get("id");
        String login = (String) claims.get("login");
        String email = (String) claims.get("email");
        return User.builder()
                .id(id)
                .login(login)
                .email(email)
                .build();
    }

    public void checkJwt(String jwt) {
        if (jwt == null) {
            throw AuthorizationException.emptyToken();
        }
    }

    private Map<String, Object> createHeaders() {
        Map<String, Object> headers = new HashMap<>();
        headers.put("typ", "JWT");
        headers.put("alg", "HS256");
        return headers;
    }

    private Map<String, Object> createPayloads(User user) {
        Map<String, Object> payloads = new HashMap<>();
        payloads.put("id", user.getId());
        payloads.put("login", user.getLogin());
        payloads.put("email", user.getEmail());
        return payloads;
    }
}
