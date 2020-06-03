package com.codesquad.airbnb5.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.UNAUTHORIZED)
public class AuthorizationException extends RuntimeException {

    public static AuthorizationException emptyToken() {
        return new AuthorizationException("Token doesn't exist");
    }

    public AuthorizationException(String msg) {
        super(msg);
    }
}
