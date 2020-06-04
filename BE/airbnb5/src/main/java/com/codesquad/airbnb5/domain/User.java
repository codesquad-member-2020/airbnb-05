package com.codesquad.airbnb5.domain;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class User {

    private int userIndex;
    private int githubId;
    private String githubName;
    private String githubEmail;
}
