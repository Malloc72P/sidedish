package com.codesquad.sidedish.init;

import com.codesquad.sidedish.category.domain.SidedishCategory;
import com.codesquad.sidedish.category.domain.SidedishCategoryRepository;
import com.codesquad.sidedish.category.domain.SidedishItem;
import com.codesquad.sidedish.category.exception.CategoryNotFoundException;
import com.codesquad.sidedish.event.domain.SidedishEvent;
import com.codesquad.sidedish.event.domain.SidedishEventRepository;
import com.codesquad.sidedish.image.domain.SidedishImage;
import com.codesquad.sidedish.image.domain.SidedishImageRepository;
import com.codesquad.sidedish.util.DefaultImageUtil;
import com.codesquad.sidedish.util.JwtUtil;
import com.codesquad.sidedish.util.SecretUtil;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class InitDataCommandLineRunner implements CommandLineRunner {

    private final SidedishCategoryRepository sidedishCategoryRepository;
    private final SidedishEventRepository eventRepository;
    private final SidedishImageRepository imageRepository;
    private final GetItems getItems;
    private Map<String, DetailItem.Body.Item> detailItem;

    public InitDataCommandLineRunner(SidedishCategoryRepository sidedishCategoryRepository,
                                     SidedishEventRepository eventRepository, SidedishImageRepository imageRepository) {
        this.sidedishCategoryRepository = sidedishCategoryRepository;
        this.eventRepository = eventRepository;
        this.imageRepository = imageRepository;
        this.getItems = new GetItems();
        detailItem = getItems.getDetailItem();
    }

    @Override
    public void run(String... args) {
        SecretUtil.initServerSecretDto();
        JwtUtil.initServerSecretKey();
        DefaultImageUtil.initNotFoundImage(createSidedishImage(DefaultImageUtil.NOT_FOUND_IMAGE_URL));

        List<SidedishCategory> categoryList = new ArrayList<>();
        categoryList.add(sidedishCategoryRepository.findByCategoryName("main").orElseThrow(CategoryNotFoundException::new));
        categoryList.add(sidedishCategoryRepository.findByCategoryName("soup").orElseThrow(CategoryNotFoundException::new));
        categoryList.add(sidedishCategoryRepository.findByCategoryName("side").orElseThrow(CategoryNotFoundException::new));

        String[] url = {getItems.mainListUrl, getItems.soupListUrl, getItems.sideListUrl};
        for (int i = 0; i < categoryList.size(); i++) {
            registerItems(categoryList.get(i), url[i]);
        }

        sidedishCategoryRepository.saveAll(categoryList);
    }

    private void registerItems(SidedishCategory category, String url) {

        SidedishEvent event1 = createSidedishEvent("이벤트특가", "#86C6FF", 30);
        SidedishEvent event2 = createSidedishEvent("론칭특가", "#82D32D", 10);
        SidedishEvent[] events = new SidedishEvent[2];
        events[0] = event1;
        events[1] = event2;

        Map<String, SidedishItem> items = createSidedishItem(url);

        int count = 1;
        for (String key : items.keySet()) {
            DetailItem.Body.Item item = detailItem.get(key);

            String topImage = item.getTopImage();
            List<String> thumbImages = item.getThumbImages();
            List<String> detailImage = item.getDetailSection();

            SidedishItem sidedishItem = items.get(key);
            registerThumbnailImage(sidedishItem, topImage);
            registerDetailImages(sidedishItem, thumbImages);
            registerDescriptionImages(sidedishItem, detailImage);

            if (0 == (count % 2)) {
                registerEvent(sidedishItem, events);
            }
            count++;
            category.addSidedishItem(sidedishItem);
        }

        sidedishCategoryRepository.save(category);
    }

    private Map<String, SidedishItem> createSidedishItem(String url) {
        ListItem listItem = getItems.getListItem(url);
        Map<String, SidedishItem> items = new HashMap<>();

        for (ListItem.Item item : listItem.getBody()) {
            DetailItem.Body.Item detailItem = this.detailItem.get(item.getDetailHash());
            items.put(item.getDetailHash(), new SidedishItem(item.getTitle(), item.getDescription(), detailItem.nomalPrice(), 30, 1
                    , detailItem.getDeliveryInfo(), detailItem.getDeliveryFee()));
        }

        return items;
    }

    private void registerThumbnailImage(SidedishItem item, String imageUrl) {
        SidedishImage image = createSidedishImage(imageUrl);
        item.addThumbnailImage(image);
    }

    private void registerDetailImages(SidedishItem item, List<String> imageUrls) {
        for (String imageUrl : imageUrls) {
            SidedishImage image = createSidedishImage(imageUrl);
            item.addDetailImage(image);
        }
    }

    private void registerDescriptionImages(SidedishItem item, List<String> imageUrls) {
        for (String imageUrl : imageUrls) {
            SidedishImage image = createSidedishImage(imageUrl);
            item.addDescriptionImage(image);
        }
    }

    private void registerEvent(SidedishItem item, SidedishEvent[] events) {
        for (SidedishEvent event : events) {
            item.addEvent(event);
        }
    }

    private SidedishEvent createSidedishEvent(String eventName, String eventColor, int eventSaleRate) {
        return eventRepository.save(new SidedishEvent(eventName, eventColor, eventSaleRate));
    }

    private SidedishImage createSidedishImage(String imageUrl) {
        return imageRepository.save(new SidedishImage(imageUrl));
    }
}
