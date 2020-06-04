package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.domain.GithubToken;
import com.codesquad.airbnb5.domain.User;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
public class OAuthService {
    private final ObjectMapper objectMapper;
    private final String ACCESS_TOKEN_URL = "https://github.com/login/oauth/access_token";
    private final String USER_DATA_API = "https://api.github.com/user";
    private final String CLIENT_ID = "";
    private final String CLIENT_SECRET = "";

    public OAuthService(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    public GithubToken getAccessToken(String code) {
        MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
        Map<String, String> header = new HashMap<>();
        header.put("Accept", "application/json");
        headers.setAll(header);

        MultiValueMap<String, String> requestPayloads = new LinkedMultiValueMap<>();
        Map<String, String> requestPayload = new HashMap<>();
        requestPayload.put("client_id", CLIENT_ID);
        requestPayload.put("client_secret", CLIENT_SECRET);
        requestPayload.put("code", code);
        requestPayloads.setAll(requestPayload);

        HttpEntity<?> request = new HttpEntity<>(requestPayloads, headers);
        ResponseEntity<?> response = new RestTemplate().postForEntity(ACCESS_TOKEN_URL, request, GithubToken.class);
        return (GithubToken) response.getBody();
    }

    public User getUser(String code) throws JsonProcessingException {
        GithubToken accessToken = getAccessToken(code);
        ResponseEntity<String> response = new RestTemplate().exchange(USER_DATA_API, HttpMethod.GET,
                getHttpEntityWithAuthorization(accessToken), String.class);
        JsonNode jsonNode = objectMapper.readTree(response.getBody());
        return User.builder()
                .githubId(jsonNode.required("id").asInt())
                .githubName(jsonNode.required("name").asText())
                .githubEmail(jsonNode.required("email").asText())
                .build();
    }

    private HttpEntity<String> getHttpEntityWithAuthorization(GithubToken githubToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(githubToken.getAccessToken());
        return new HttpEntity<>(headers);
    }
}
