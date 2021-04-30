//
//  OrderUseCase.swift
//  sidedishApp
//
//  Created by zombietux on 2021/04/27.
//

import Foundation
import Combine

protocol OrderUseCasePort {
    func order(quantity:Int, path category: String, path id: Int) -> AnyPublisher<Int, NetworkError>
}

class OrderUseCase: OrderUseCasePort {
    private var orderNetworkManager: OrderNetworkManagerProtocol
    
    init(orderNetworkManager: OrderNetworkManagerProtocol = OrderNetworkManager()) {
        self.orderNetworkManager = orderNetworkManager
    }

    func order(quantity: Int, path category: String, path id: Int) -> AnyPublisher<Int, NetworkError> {
        return self.orderNetworkManager.order(quantity: quantity, path: category, path: id)
    }
}
