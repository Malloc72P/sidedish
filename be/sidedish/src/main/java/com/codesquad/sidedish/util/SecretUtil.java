package com.codesquad.sidedish.util;

import com.codesquad.sidedish.init.dto.ServerSecretDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;

public class SecretUtil {
    private static final Logger logger = LoggerFactory.getLogger(SecretUtil.class);
    private static final String SECRET_FILE_IO_ERROR = "server.secret.json파일을 읽어오는 과정에서 문제가 발생했습니다!";
    private static ServerSecretDTO SERVER_SECRET_DTO;

    private SecretUtil() {
    }

    public static void initServerSecretDto() {
        try {
            InputStream inputStream = SecretUtil.class.getResourceAsStream("/server.secret.json");
            ObjectMapper objectMapper = new ObjectMapper();
            SERVER_SECRET_DTO = objectMapper.readValue(inputStream, ServerSecretDTO.class);
        } catch (IOException | IllegalArgumentException e) {
            onSecretFileIoException(e);
        }
    }

    private static void onSecretFileIoException(Exception e) {
        logger.error(SECRET_FILE_IO_ERROR);
        e.printStackTrace();
        System.exit(1);
    }

    public static String clientId() {
        return SERVER_SECRET_DTO.getClientId();
    }

    public static String clientSecret() {
        return SERVER_SECRET_DTO.getClientSecret();
    }

    public static String serverSecret() {
        return SERVER_SECRET_DTO.getServerSecret();
    }
}
