package com.codesquad.sidedish.init;

import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class ListItem {

    int statusCode;
    List<Item> body;

    public int getStatusCode() {
        return statusCode;
    }

    public List<Item> getBody() {
        return body;
    }

    @Override
    public String toString() {
        return "ListItem{" +
                "statusCode=" + statusCode +
                ", body=" + body +
                '}';
    }

    public Map<String, Item> returnMap() {
        return body.stream().collect(
                Collectors.toMap(
                        Item::getDetailHash,
                        Item::getThis
                )
        );
    }

    @JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy.class)
    static class Item {
        String detailHash;
        String image;
        String alt;
        String title;
        String description;
        String sPrice;
        List<String> badge;

        public String getDetailHash() {
            return detailHash;
        }

        public String getDescription() {
            return description;
        }

        public Item getThis() {
            return this;
        }

        public String getImage() {
            return image;
        }

        public String getAlt() {
            return alt;
        }

        public String getTitle() {
            return title;
        }

        public String getsPrice() {
            return sPrice;
        }

        public List<String> getBadge() {
            return badge;
        }

        @Override
        public String toString() {
            return "Item{" +
                    "detailHash='" + detailHash + '\'' +
                    ", image='" + image + '\'' +
                    ", alt='" + alt + '\'' +
                    ", title='" + title + '\'' +
                    ", SPrice='" + sPrice + '\'' +
                    ", badge=" + badge +
                    '}';
        }
    }
}
