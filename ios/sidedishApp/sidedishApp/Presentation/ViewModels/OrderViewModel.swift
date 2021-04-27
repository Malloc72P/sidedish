//
//  OrderViewModel.swift
//  sidedishApp
//
//  Created by zombietux on 2021/04/27.
//

import Foundation
import Combine

class OrderViewModel {
    private var item = Detail()
    private var order: (quantity: Int, amount: Int)!
    private(set) var dataChanged = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init(order: (Int, Int)) {
        self.order = order
    }
    
    func getOder() -> (quantity: Int, amount: Int) {
        return self.order
    }
    
    func plus(price: Int) {
        self.order.quantity += 1
        self.order.amount += price
        self.dataChanged.send()
    }
    
    func minus(price: Int) {
        self.order.quantity -= 1
        self.order.amount -= price
        self.dataChanged.send()
    }
}
