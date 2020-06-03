package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.domain.GithubToken;
import com.codesquad.airbnb5.domain.User;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.Collections;
import java.util.Objects;

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

    public User getUser(String code) throws JsonProcessingException {
        String accessToken = getAccessToken(code);
        ResponseEntity<String> response = new RestTemplate().exchange(USER_DATA_API, HttpMethod.GET,
                getHttpEntityWithAuthorization(accessToken), String.class);
        JsonNode jsonNode = objectMapper.readTree(response.getBody());
        return User.builder()
                .id(jsonNode.required("id").asInt())
                .name(jsonNode.required("name").asText())
                .email(jsonNode.required("email").asText())
                .build();
    }

    private String getAccessToken(String code) {
        GithubToken githubToken = new RestTemplate().postForEntity(getUrlForAccessToken(code),
                getHttpEntityWithSetAcceptJson(), GithubToken.class)
                .getBody();
        return Objects.requireNonNull(githubToken).getAccessToken();
    }

    private String getUrlForAccessToken(String code) {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("client_id", CLIENT_ID);
        params.add("client_secret", CLIENT_SECRET);
        params.add("code", code);
        return UriComponentsBuilder.fromHttpUrl(ACCESS_TOKEN_URL)
                .queryParams(params)
                .toUriString();
    }

    private HttpEntity<String> getHttpEntityWithSetAcceptJson() {
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        return new HttpEntity<>(headers);
    }

    private HttpEntity<String> getHttpEntityWithAuthorization(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        return new HttpEntity<>(headers);
    }

}
