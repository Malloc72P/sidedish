package com.codesquad.sidedish.category.domain.dto;

import com.codesquad.sidedish.category.domain.SidedishItem;
import com.codesquad.sidedish.event.domain.SidedishEvent;
import com.codesquad.sidedish.event.domain.dto.SidedishEventDTO;

import java.util.List;
import java.util.Set;

public class SidedishDetailItemDTO {

    private final Long id;
    private final List<String> detailImages;
    private final List<String> descriptionImages;
    private final String name;
    private final String description;
    private final int normalPrice;
    private final int salePrice;
    private final Set<SidedishEventDTO> eventBadgeList;
    private final int PointRate;
    private final boolean isPurchasable;
    private final String DeliveryInfo;
    private final String DeliveryFee;

    public SidedishDetailItemDTO(SidedishItem item, Set<SidedishEvent> eventBadgeList,
                                 List<String> detailImages, List<String> descriptionImages) {
        this.id = item.getId();
        this.name = item.getItemName();
        this.description = item.getItemDescription();
        this.normalPrice = item.getItemNormalPrice();
        this.salePrice = item.calculateSalePrice(eventBadgeList);
        this.PointRate = item.getPointRate();
        this.DeliveryInfo = item.getItemDeliveryInfo();
        this.DeliveryFee = item.getItemDeliveryFee();

        this.detailImages = detailImages;
        this.descriptionImages = descriptionImages;

        this.isPurchasable = item.isPurchasable();
        this.eventBadgeList = SidedishEventDTO.eventSetToDtoSet(eventBadgeList);
    }


    public Long getId() {
        return id;
    }

    public List<String> getDetailImages() {
        return detailImages;
    }

    public List<String> getDescriptionImages() {
        return descriptionImages;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public int getNormalPrice() {
        return normalPrice;
    }

    public int getSalePrice() {
        return salePrice;
    }

    public Set<SidedishEventDTO> getEventBadgeList() {
        return eventBadgeList;
    }

    public int getPointRate() {
        return PointRate;
    }

    public boolean isPurchasable() {
        return isPurchasable;
    }

    public String getDeliveryInfo() {
        return DeliveryInfo;
    }

    public String getDeliveryFee() {
        return DeliveryFee;
    }

    @Override
    public String toString() {
        return "SidedishItemDetailDTO{" +
                "id=" + id +
                ", detailImages=" + detailImages + '\n' +
                ", descriptionImages=" + descriptionImages + '\n' +
                ", name='" + name + '\n' +
                ", description='" + description + '\n' +
                ", normalPrice=" + normalPrice +
                ", salePrice=" + salePrice +
                ", eventBadgeList=" + eventBadgeList +
                ", PointRate=" + PointRate +
                ", isPurchasable=" + isPurchasable +
                ", DeliveryInfo='" + DeliveryInfo + '\n' +
                ", DeliveryFee='" + DeliveryFee + '\n' +
                '}';
    }
}
