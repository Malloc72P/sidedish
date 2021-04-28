//
//  OrderViewModelType.swift
//  sidedishApp
//
//  Created by zombietux on 2021/04/28.
//

import Foundation
import Combine

protocol OrderViewModelType {
    var dataChanged: PassthroughSubject<Void, Never> { get }
    func getOder() -> (quantity: Int, amount: Int)
    func plus(price: Int)
    func minus(price: Int)
    func order(quantity:Int, path category: String, path id: Int)
}
