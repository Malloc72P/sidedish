package com.codesquad.sidedish.user.controller;

import com.codesquad.sidedish.user.dto.AuthorizationInfo;
import com.codesquad.sidedish.user.dto.ReceiveAccessTokenDTO;
import com.codesquad.sidedish.user.dto.UserInfoDTO;
import com.codesquad.sidedish.user.service.GoogleApiRequester;
import com.codesquad.sidedish.user.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static com.codesquad.sidedish.util.UrlConstant.LOGIN_PAGE_URL;

@Controller
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
    public String oauthCallBack(AuthorizationInfo authorizationInfo, Model model) {
        ReceiveAccessTokenDTO receiveAccessTokenDTO = googleApiRequester.requestAccessToken(authorizationInfo.getCode());
        UserInfoDTO userInfoDTO = googleApiRequester.requestUserInfo(receiveAccessTokenDTO.getAccess_token());
        String jwtToken = userService.login(userInfoDTO);
        model.addAttribute("token", jwtToken);
        return "token";
    }
}
