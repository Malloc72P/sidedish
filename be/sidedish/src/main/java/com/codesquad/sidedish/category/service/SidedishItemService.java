package com.codesquad.sidedish.category.service;

import com.codesquad.sidedish.category.domain.SidedishCategory;
import com.codesquad.sidedish.category.domain.SidedishCategoryRepository;
import com.codesquad.sidedish.category.domain.SidedishItem;
import com.codesquad.sidedish.category.domain.SidedishDetailItemDTO;
import com.codesquad.sidedish.category.domain.dto.DetailItemDtoWrapper;
import com.codesquad.sidedish.category.domain.dto.OrderDTO;
import com.codesquad.sidedish.category.domain.dto.PreviewListDtoWrapper;
import com.codesquad.sidedish.category.domain.dto.SidedishItemPreviewDTO;
import com.codesquad.sidedish.category.exception.CategoryNotFoundException;
import com.codesquad.sidedish.event.exception.EventNotFoundException;
import com.codesquad.sidedish.event.domain.SidedishEvent;
import com.codesquad.sidedish.event.domain.SidedishEventDTO;
import com.codesquad.sidedish.event.domain.SidedishEventItem;
import com.codesquad.sidedish.event.domain.SidedishEventRepository;
import com.codesquad.sidedish.image.domain.SidedishImage;
import com.codesquad.sidedish.image.domain.SidedishImageRepository;
import com.codesquad.sidedish.image.domain.SidedishImageTypeEnum;
import com.codesquad.sidedish.image.domain.SidedishItemImage;
import com.codesquad.sidedish.image.exception.ImageItemNotFoundException;
import com.codesquad.sidedish.image.exception.ImageNotFoundException;
import com.codesquad.sidedish.util.DefaultImageUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
public class SidedishItemService {

    private final SidedishCategoryRepository sidedishCategoryRepository;
    private final SidedishEventRepository sidedishEventRepository;
    private final SidedishImageRepository sidedishImageRepository;

    public SidedishItemService(SidedishCategoryRepository sidedishCategoryRepository,
                               SidedishEventRepository sidedishEventRepository,
                               SidedishImageRepository sidedishImageRepository) {
        this.sidedishCategoryRepository = sidedishCategoryRepository;
        this.sidedishEventRepository = sidedishEventRepository;
        this.sidedishImageRepository = sidedishImageRepository;
    }

    public PreviewListDtoWrapper showItemList(String categoryName) {
        SidedishCategory category = sidedishCategoryRepository.findByCategoryName(categoryName).orElseThrow(CategoryNotFoundException::new);
        List<SidedishItem> items = category.getSidedishItemList();

        List<SidedishItemPreviewDTO> itemDTOs = new ArrayList<>();
        Map<Long, SidedishEvent> eventMap = new HashMap<>();

        for (SidedishItem item : items) {
            Set<SidedishEventDTO> eventSet = createEventDtoSet(item, eventMap);
            SidedishImage thumbnailImage = findThumbnailImage(item);
            itemDTOs.add(new SidedishItemPreviewDTO(item, eventSet, thumbnailImage));
        }
        return new PreviewListDtoWrapper(itemDTOs);
    }

    public DetailItemDtoWrapper showItem(String categoryName, Long itemId) {
        SidedishCategory sidedishCategory = sidedishCategoryRepository.findByCategoryName(categoryName).orElseThrow(CategoryNotFoundException::new);
        SidedishItem sidedishItem = sidedishCategory.findItem(itemId);

        Set<SidedishEventDTO> eventSet = createEventDtoSet(sidedishItem);
        List<SidedishImage> detailImages = findImagesByType(sidedishItem, SidedishImageTypeEnum.DETAIL);
        List<SidedishImage> descriptionImages = findImagesByType(sidedishItem, SidedishImageTypeEnum.DESCRIPTION);
        SidedishDetailItemDTO sidedishDetailItemDTO = new SidedishDetailItemDTO(sidedishItem, eventSet, detailImages, descriptionImages);
        return new DetailItemDtoWrapper(sidedishDetailItemDTO);
    }

    private SidedishImage findThumbnailImage(SidedishItem item) {
        SidedishItemImage sidedishItemImage = null;
        try {
            sidedishItemImage = item.getSidedishItemImages().stream()
                    .filter(SidedishItemImage::isThumbnailImage)
                    .findFirst()
                    .orElseThrow(ImageItemNotFoundException::new);
        } catch (ImageItemNotFoundException e) {
            return DefaultImageUtil.getNotFoundImage();
        }
        return sidedishImageRepository.findById(sidedishItemImage.getSidedishImage()).orElseThrow(ImageNotFoundException::new);
    }

    private List<SidedishImage> findImagesByType(SidedishItem item, SidedishImageTypeEnum imageTypeEnum) {
        List<Long> itemImageList = item.getSidedishItemImages().stream()
                .filter(image -> image.isSameType(imageTypeEnum))
                .map(SidedishItemImage::getSidedishImage)
                .collect(Collectors.toList());
        return sidedishImageRepository.findAllById(itemImageList);
    }

    private Set<SidedishEventDTO> createEventDtoSet(SidedishItem item, Map<Long, SidedishEvent> eventMap) {
        for (SidedishEventItem eventItem : item.getEventItems()) {
            Long eventId = eventItem.getSidedishEvent();
            if (!eventMap.containsKey(eventId)) {
                eventMap.put(eventId, sidedishEventRepository.findById(eventId).orElseThrow(EventNotFoundException::new));
            }
        }
        return item.getEventItems().stream()
                .map(eventItem -> eventMap.get(eventItem.getSidedishEvent()))
                .map(SidedishEventDTO::new)
                .collect(Collectors.toSet());
    }

    private Set<SidedishEventDTO> createEventDtoSet(SidedishItem item) {
        Set<SidedishEventDTO> eventDtoSet = new HashSet<>();
        for (SidedishEventItem eventItem : item.getEventItems()) {
            Long eventId = eventItem.getSidedishEvent();
            SidedishEvent sidedishEvent = sidedishEventRepository.findById(eventId).orElseThrow(EventNotFoundException::new);
            eventDtoSet.add(new SidedishEventDTO(sidedishEvent));
        }
        return eventDtoSet;
    }

    @Transactional
    public void order(String categoryName, Long id, OrderDTO orderDTO) {
        SidedishCategory category = sidedishCategoryRepository.findByCategoryName(categoryName).orElseThrow(CategoryNotFoundException::new);
        SidedishItem item = category.findItem(id);
        item.order(orderDTO);
        sidedishCategoryRepository.save(category);
    }
}
