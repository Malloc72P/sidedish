//
//  Response.swift
//  sidedishApp
//
//  Created by zombietux on 2021/04/28.
//

import Foundation

struct Response: Decodable {
    private let reason: String
    
    init(reason: String = "") {
        self.reason = reason
    }
    
    func getReason() -> String {
        return self.reason
    }
}
