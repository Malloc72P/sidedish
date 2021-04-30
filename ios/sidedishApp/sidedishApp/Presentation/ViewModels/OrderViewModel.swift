//
//  OrderViewModel.swift
//  sidedishApp
//
//  Created by zombietux on 2021/04/27.
//

import Foundation
import Combine

class OrderViewModel: OrderViewModelType {
    private var item = Detail()
    private var order: (quantity: Int, amount: Int)!
    private var statusCode = Int()
    private var orderUseCase: OrderUseCasePort!
    private(set) var dataChanged = PassthroughSubject<Void, Never>()
    private(set) var responseChanged = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init(order: (Int, Int), orderUseCase: OrderUseCasePort = OrderUseCase()) {
        self.order = order
        self.orderUseCase = orderUseCase
    }
    
    func getOder() -> (quantity: Int, amount: Int) {
        return self.order
    }
    
    func getStatusCode() -> Int {
        return self.statusCode
    }
    
    func plus(price: Int) {
        self.order.quantity += 1
        self.order.amount += price
        self.dataChanged.send()
    }
    
    func minus(price: Int) {
        if self.order.quantity > 1 {
            self.order.quantity -= 1
            self.order.amount -= price
            self.dataChanged.send()
        }
    }
    
    func order(quantity:Int, path category: String, path id: Int) {
        self.orderUseCase.order(quantity: quantity, path: category, path: id)
            .receive(on: DispatchQueue.global())
            .sink { result in
                switch result {
                case .finished: break
                case .failure(_):
                    self.statusCode = 400
                    self.responseChanged.send()
                }
            } receiveValue: { statusCode in
                self.statusCode = statusCode
                self.responseChanged.send()
            }
            .store(in: &cancellables)
    }
}
