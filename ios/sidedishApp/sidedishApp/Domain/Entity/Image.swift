//
//  File.swift
//  sidedishApp
//
//  Created by 김지선 on 2021/04/27.
//

import Foundation

struct Image: Hashable, Equatable {
    private var image: String
    private let id = UUID()
    
    init(image: String  = "") {
        self.image = image
    }
    
    func getImage() -> String {
        return image
    }
    
    static func ==(lhs: Image, rhs: Image) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
}
