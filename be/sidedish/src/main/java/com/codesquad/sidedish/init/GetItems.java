package com.codesquad.sidedish.init;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;
import java.util.Map;

public class GetItems {

    public String mainListUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/main";
    public String soupListUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/soup";
    public String sideListUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/side";
    private RestTemplateBuilder builder = new RestTemplateBuilder();
    private RestTemplate template = builder.build();
    private String detailUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/detail";


    public Map<String, DetailItem.Body.Item> getDetailItem() {
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        HttpEntity<DetailItem> httpEntity = new HttpEntity<>(headers);
        DetailItem body = template.exchange(detailUrl, HttpMethod.GET, httpEntity, DetailItem.class).getBody();

        return body.returnMap();
    }

    public ListItem getListItem(String listUrl) {
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        HttpEntity<ListItem> httpEntity = new HttpEntity<>(headers);
        ListItem body = template.exchange(listUrl, HttpMethod.GET, httpEntity, ListItem.class).getBody();

        return body;
    }


    public String getMainListUrl() {
        return mainListUrl;
    }

    public String getSoupListUrl() {
        return soupListUrl;
    }

    public String getSideListUrl() {
        return sideListUrl;
    }
}
