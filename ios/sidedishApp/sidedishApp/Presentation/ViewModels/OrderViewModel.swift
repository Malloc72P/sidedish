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
    private var response = String()
    private var orderUseCase: OrderUseCasePort!
    private(set) var dataChanged = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init(order: (Int, Int), orderUseCase: OrderUseCasePort = OrderUseCase()) {
        self.order = order
        self.orderUseCase = orderUseCase
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
    
    func order(quantity:Int, path category: String, path id: Int) {
        self.orderUseCase.order(quantity: quantity, path: category, path: id)
            .receive(on: DispatchQueue.global())
            .sink { result in
                switch result {
                case .finished: break
                case .failure(_): break }
            } receiveValue: { response in
                // response 처리해줘야 함
                print(response)
            }
            .store(in: &cancellables)
    }
}
