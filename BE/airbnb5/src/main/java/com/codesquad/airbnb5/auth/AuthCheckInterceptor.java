package com.codesquad.airbnb5.auth;

import com.codesquad.airbnb5.domain.User;
import com.codesquad.airbnb5.exception.AuthorizationException;
import com.codesquad.airbnb5.service.JwtService;
import com.codesquad.airbnb5.service.UserService;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AuthCheckInterceptor implements HandlerInterceptor {
    private final String HEADER_AUTH = "Authorization";
    private final JwtService jwtService;
    private final UserService userService;

    public AuthCheckInterceptor(JwtService jwtService, UserService userService) {
        this.jwtService = jwtService;
        this.userService = userService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String jwt = request.getHeader(HEADER_AUTH);

        if (jwt != null) {
            User user = jwtService.parseJwt(jwt);
            request.setAttribute("guestId", user.getUserIndex());
        } else {
            throw AuthorizationException.emptyToken();
        }
        return true;
    }
}
