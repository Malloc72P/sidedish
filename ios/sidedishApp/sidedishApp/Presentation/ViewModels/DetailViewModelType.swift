//
//  DetailViewModelType.swift
//  sidedishApp
//
//  Created by 김지선 on 2021/04/21.
//

import Foundation
import Combine

protocol DetailViewModelType {
    var dataChanged: PassthroughSubject<Void, Never> { get }
    func getDetailItem() -> Detail
    func getDetailImages() -> [Image]
    
    func getDescriptionImages() -> [Image]
    func fetchData(path category: String, path id: Int)
}
