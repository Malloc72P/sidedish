package com.codesquad.sidedish.init;

import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class DetailItem {

    int statusCode;
    List<Body> body;

    public DetailItem() {
    }

    public Map<String, Body.Item> returnMap() {
        return body.stream()
                .collect(Collectors.toMap(
                        Body::getHash,
                        Body::getData)
                );
    }

    public List<Body> getBody() {
        return body;
    }

    public int getStatusCode() {
        return statusCode;
    }

    @Override
    public String toString() {
        return "GetItem{" +
                "statusCode=" + statusCode +
                ", body=" + body +
                '}';
    }

    static class Body {

        String hash;
        Item data;

        public Body() {
        }

        public String getHash() {
            return hash;
        }

        public Item getData() {
            return data;
        }

        @Override
        public String toString() {
            return "Body{" +
                    "hash='" + hash + '\'' +
                    ", data=" + data +
                    '}';
        }

        @JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy.class)
        static class Item {
            String topImage;
            List<String> thumbImages;
            String productDescription;
            String deliveryInfo;
            String deliveryFee;
            List<String> prices;
            List<String> detailSection;

            public Item() {
            }

            public String getTopImage() {
                return topImage;
            }

            public List<String> getThumbImages() {
                return thumbImages;
            }

            public String getProductDescription() {
                return productDescription;
            }

            public String getDeliveryInfo() {
                return deliveryInfo;
            }

            public String getDeliveryFee() {
                return deliveryFee;
            }

            public List<String> getPrices() {
                return prices;
            }

            public int nomalPrice() {
                return Integer.parseInt(prices.get(0)
                        .replace(",", "")
                        .replace("원", ""));
            }

            public List<String> getDetailSection() {
                return detailSection;
            }

            @Override
            public String toString() {
                return "Item{" +
                        "topImage='" + topImage + '\'' +
                        ", thumbImages=" + thumbImages +
                        ", productDescription='" + productDescription + '\'' +
                        ", deliveryInfo='" + deliveryInfo + '\'' +
                        ", deliveryFee='" + deliveryFee + '\'' +
                        ", prices=" + prices +
                        ", detailSection=" + detailSection +
                        '}';
            }
        }
    }
}
