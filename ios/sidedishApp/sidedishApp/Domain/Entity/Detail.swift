//
//  Detail.swift
//  sidedishApp
//
//  Created by 김지선 on 2021/04/21.
//

import Foundation

struct Detail: Codable, Hashable, Equatable {
    private let item: DetailItem
    
    init() {
        let id = 0
        let detailImages = [""]
        let descriptionImages = [""]
        let name = ""
        let description = ""
        let normalPrice = 0
        let salePrice = 0
        let eventBadgeList = [EventBadge(name: "", colorHex: "")]
        let pointRate = 1
        let purchasable = false
        let deliveryInfo = ""
        let deliveryFee = ""
        self.item = DetailItem(id: id, detailImages: detailImages, descriptionImages: descriptionImages, name: name, description: description, normalPrice: normalPrice, salePrice: salePrice, eventBadgeList: eventBadgeList, pointRate: pointRate, purchasable: purchasable, deliveryInfo: deliveryInfo, deliveryFee: deliveryFee)
        
    }
    
    func getDetailImage(at index: Int) -> Image {
        return self.item.getDetailImage(at: index)
    }
    
    func getDescriptionImage(at index: Int) -> Image {
        return self.item.getDescriptionImage(at: index)
    }
    
    func getDetailImages() -> [Image] {
        return item.getDetailImages()
    }
    
    func getDescriptionImages() -> [Image] {
        return item.getDetailImages()
    }
    
    func getName() -> String {
        return item.getName()
    }
    
    func getDescription() -> String {
        return item.getDescription()
    }
    
    func getNormalPrice() -> Int {
        return item.getNormalPrice()
    }
    
    func getSalePrice() -> Int {
        return item.getSalePrice()
    }
    
    func getPointRate() -> Int {
        return item.getPointRate()
    }
    
    func getIsPurchasable() -> Bool {
        return item.getIsPurchasable()
    }
}

