package com.codesquad.sidedish.user.controller;

import com.codesquad.sidedish.user.dto.AuthorizationInfo;
import com.codesquad.sidedish.user.dto.JwtTokenResponse;
import com.codesquad.sidedish.user.dto.ReceiveAccessTokenDTO;
import com.codesquad.sidedish.user.dto.UserInfoDTO;
import com.codesquad.sidedish.user.service.GoogleApiRequester;
import com.codesquad.sidedish.user.service.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static com.codesquad.sidedish.util.UrlConstant.LOGIN_PAGE_URL;

@RestController
@RequestMapping("/users")
public class UserController {

    private final GoogleApiRequester googleApiRequester;
    private final UserService userService;

    public UserController(GoogleApiRequester googleApiRequester, UserService userService) {
        this.googleApiRequester = googleApiRequester;
        this.userService = userService;
    }

    @GetMapping("/login")
    public void login(HttpServletResponse response) throws IOException {
        response.sendRedirect(LOGIN_PAGE_URL);
    }

    @GetMapping("/callback")
    public JwtTokenResponse oauthCallBack(AuthorizationInfo authorizationInfo) throws JsonProcessingException {
        ReceiveAccessTokenDTO receiveAccessTokenDTO = googleApiRequester.requestAccessToken(authorizationInfo.getCode());
        UserInfoDTO userInfoDTO = googleApiRequester.requestUserInfo(receiveAccessTokenDTO.getAccess_token());
        String jwtToken = userService.login(userInfoDTO);
        return new JwtTokenResponse(jwtToken);
    }
}
