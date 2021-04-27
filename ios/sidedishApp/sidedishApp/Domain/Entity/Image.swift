//
//  File.swift
//  sidedishApp
//
//  Created by 김지선 on 2021/04/27.
//

import Foundation

struct Image: Codable, Hashable, Equatable {
    private var image: String
    
    init(image: String  = "") {
        self.image = image
    }
    
    func getImage() -> String {
        return image
    }
}
