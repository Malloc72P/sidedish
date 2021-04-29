package com.codesquad.sidedish.user.dto;

public class JwtTokenResponse {
    private String token;

    public JwtTokenResponse() {
    }

    public JwtTokenResponse(String token) {
        this.token = token;
    }

    public String getToken() {
        return token;
    }
}
