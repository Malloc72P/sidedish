//
//  File.swift
//  sidedishApp
//
//  Created by 김지선 on 2021/04/27.
//

import Foundation

struct Images: Codable, Hashable, Equatable {
    private var images: [String]
    
    init(images: [String] = [""]) {
        self.images = images
    }
    
    func getImage(at index: Int) -> String {
        return images[index]
    }
    
    func getImages() -> [String] {
        return images
    }
    
}
