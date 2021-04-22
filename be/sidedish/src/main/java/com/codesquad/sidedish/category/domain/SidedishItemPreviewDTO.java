package com.codesquad.sidedish.category.domain;

import com.codesquad.sidedish.event.domain.SidedishEvent;
import com.codesquad.sidedish.event.domain.SidedishEventDTO;
import com.codesquad.sidedish.image.domain.SidedishImage;

import java.util.List;
import java.util.Set;

public class SidedishItemPreviewDTO {

    private Long id;
    private String thumbnailImage;
    private String name;
    private String description;
    private int normalPrice;
    private int salePrice;
    private Set<SidedishEventDTO> eventBadgeList;

    public SidedishItemPreviewDTO(SidedishItem item, Set<SidedishEventDTO> eventBadgeList, SidedishImage thumbnailImageUrl) {
        this.id = item.getId();
        this.thumbnailImage = thumbnailImageUrl.getImageUrl();
        this.name = item.getItemName();
        this.description = item.getItemDescription();
        this.normalPrice = item.getItemNormalPrice();
        this.salePrice = item.getItemSalePrice();
        this.eventBadgeList = eventBadgeList;
    }

    @Override
    public String toString() {
        return "SidedishItemPreviewDTO{" +
                "id=" + id +
                ", thumbnailImage='" + thumbnailImage + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", normalPrice=" + normalPrice +
                ", salePrice=" + salePrice +
                ", eventBadgeList=" + eventBadgeList +
                '}';
    }
}
