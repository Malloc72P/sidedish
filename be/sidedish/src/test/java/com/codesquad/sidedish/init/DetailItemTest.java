package com.codesquad.sidedish.init;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;
import java.util.Map;

class DetailItemTest {
    RestTemplateBuilder builder = new RestTemplateBuilder();
    RestTemplate template = builder.build();
    String detailUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/detail";

    String mainListUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/main";
    String soupListUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/soup";
    String sideListUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/side";

    @DisplayName("디테일 음식 리스트")
    @Test
    void getDetailItem() {
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        HttpEntity<DetailItem> httpEntity = new HttpEntity<>(headers);
        DetailItem body = template.exchange(detailUrl, HttpMethod.GET, httpEntity, DetailItem.class).getBody();

        System.out.println(body.returnMap());
    }

    @Test
    @DisplayName("메인 음식 리스트")
    Map<String, ListItem.Item> getListItem(String listUrl) {
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        HttpEntity<ListItem> httpEntity = new HttpEntity<>(headers);
        ListItem body = template.exchange(listUrl, HttpMethod.GET, httpEntity, ListItem.class).getBody();

        return body.returnMap();
    }

//    @Test
//    void mapToMap() {
//        Map<String, DetailItem.Body.Item> detailItem = getDetailItem();
//        Map<String, ListItem.Item> listItem = getListItem(mainListUrl);
//
//        for (String hash : listItem.keySet()) {
//            DetailItem.Body.Item item = detailItem.get(hash);
//            System.out.println(item);
//        }
//    }

}