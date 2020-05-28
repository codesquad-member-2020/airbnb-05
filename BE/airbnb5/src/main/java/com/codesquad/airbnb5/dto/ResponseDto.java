package com.codesquad.airbnb5.dto;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
public class ResponseDto {

    @JsonProperty("status_code")
    private int statusCode;

    @JsonProperty("data")
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Object data;

    public ResponseDto(int statusCode) {
        this.statusCode = statusCode;
    }

    public ResponseDto(int statusCode, Object data) {
        this.statusCode = statusCode;
        this.data = data;
    }
}
