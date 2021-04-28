//
//  OrderNetworkManager.swift
//  sidedishApp
//
//  Created by zombietux on 2021/04/27.
//

import Foundation
import Combine

protocol OrderNetworkManagerProtocol: class {
    func order(quantity: Int, path category: String, path id: Int) -> AnyPublisher<Int, NetworkError>
}

class OrderNetworkManager: OrderNetworkManagerProtocol {
    private var networkManager: HttpPostMethodProtocol!
    
    init(networkManager: HttpPostMethodProtocol = PostNetworkManager()) {
        self.networkManager = networkManager
    }
    
    func order(quantity: Int, path category: String, path id: Int) -> AnyPublisher<Int, NetworkError> {
        let endpoint = Endpoint.post(path: category, path: id)
        return networkManager.post(quantity: quantity, url: endpoint.url)
    }
}
