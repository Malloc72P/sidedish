//
//  DetailItem.swift
//  sidedishApp
//
//  Created by 김지선 on 2021/04/21.
//

import Foundation

struct DetailItem: Codable, Hashable, Equatable{
    private let id: Int
    private let detailImages: [String]
    private let descriptionImages: [String]
    private let name: String
    private let description: String
    private let normalPrice: Int
    private let salePrice: Int
    private let eventBadgeList: [EventBadge]
    private let pointRate: Int
    private let purchasable: Bool
    private let deliveryInfo: String
    private let deliveryFee: String
    
    init(id: Int, detailImages: [String], descriptionImages: [String], name: String, description: String, normalPrice: Int, salePrice: Int, eventBadgeList: [EventBadge],pointRate: Int, purchasable: Bool, deliveryInfo: String, deliveryFee: String) {
        self.id = id
        self.detailImages = detailImages
        self.descriptionImages = descriptionImages
        self.name = name
        self.description = description
        self.normalPrice = normalPrice
        self.salePrice = salePrice
        self.eventBadgeList = eventBadgeList
        self.pointRate = pointRate
        self.purchasable = purchasable
        self.deliveryInfo = deliveryInfo
        self.deliveryFee = deliveryFee
    }
    
    func getDetailImage(at index: Int) -> String {
        return self.detailImages[index]
    }
    
    func getDescriptionImage(at index: Int) -> String {
        return self.descriptionImages[index]
    }
    
    func getDetailImages() -> [String] {
        return self.detailImages
    }
    
    func getDescriptionImages() -> [String] {
        return self.descriptionImages
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getDescription() -> String {
        return self.description
    }
    
    func getNormalPrice() -> Int {
        return self.normalPrice
    }
    
    func getSalePrice() -> Int {
        return self.salePrice
    }
    
    func getPointRate() -> Int {
        return self.pointRate
    }
    
    func getIsPurchasable() -> Bool {
        return self.purchasable
    }
}
