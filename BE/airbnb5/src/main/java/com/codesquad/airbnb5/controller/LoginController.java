package com.codesquad.airbnb5.controller;

import com.codesquad.airbnb5.domain.User;
import com.codesquad.airbnb5.service.JwtService;
import com.codesquad.airbnb5.service.OAuthService;
import com.codesquad.airbnb5.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;
import java.io.IOException;

@Slf4j
@RestController
public class LoginController {

    private final OAuthService oAuthService;
    private final JwtService jwtService;
    private final UserService userService;

    public LoginController(OAuthService oAuthService, JwtService jwtService, UserService userService) {
        this.oAuthService = oAuthService;
        this.jwtService = jwtService;
        this.userService = userService;
    }

    @GetMapping("/githublogin")
    public ResponseEntity<String> githubLogin(@PathParam("code") String code, HttpServletResponse response) throws IOException {
        User user = oAuthService.getUser(code);
        userService.insertOrUpdateUser(user);
        String jwt = jwtService.buildJwt(user);
        response.sendRedirect("airbnbfive://oauth?token=" + jwt);
        return ResponseEntity.ok("login 성공");
    }
}
