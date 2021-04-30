//
//  TokenManager.swift
//  sidedishApp
//
//  Created by zombietux on 2021/04/29.
//

import Foundation

class TokenManager {
    static let key = "TokenManager"
    
    class func save(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: key)
    }
    
    class func load() -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    
    class func delete() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
