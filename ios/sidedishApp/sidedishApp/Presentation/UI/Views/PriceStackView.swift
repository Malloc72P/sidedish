//
//  PriceStackView.swift
//  sidedishApp
//
//  Created by 김지선 on 2021/04/28.
//

import UIKit

class PriceStackView: UIStackView {
    let normalPriceLabel = UILabel()
    let salePriceLabel = UILabel()
    
    func configureSideDish(normalPrice: Int, salePrice: Int) {
        if salePrice == -1 {
            configureNotSale()
            normalPriceLabel.text = "\(normalPrice)원"
            addArrangedSubview(normalPriceLabel)
        } else {
            configureSale()
            normalPriceLabel.text = "\(normalPrice)원"
            normalPriceLabel.attributedText =  normalPriceLabel.text?.strikeThrough()
            salePriceLabel.text = "\(salePrice)원"
            
            addArrangedSubview(salePriceLabel)
            addArrangedSubview(normalPriceLabel)
        }
        
        self.axis = .horizontal
        self.spacing = 8
    }
    
    func configureDetail(normalPrice: Int, salePrice: Int) {
        if salePrice == -1 {
            normalPriceLabel.font = UIFont.boldSystemFont(ofSize: 24)
            normalPriceLabel.textColor = .black
            normalPriceLabel.text = "\(normalPrice)원"
            addArrangedSubview(normalPriceLabel)
        } else {
            salePriceLabel.font = UIFont.boldSystemFont(ofSize: 24)
            normalPriceLabel.font = UIFont.systemFont(ofSize: 16)
            normalPriceLabel.textColor = .systemGray2
            normalPriceLabel.text = "\(normalPrice)원"
            normalPriceLabel.attributedText =  normalPriceLabel.text?.strikeThrough()
            salePriceLabel.text = "\(salePrice)원"
            
            addArrangedSubview(salePriceLabel)
            addArrangedSubview(normalPriceLabel)
        }
        
        self.axis = .horizontal
        self.spacing = 8
    }
    
    func configureNotSale() {
        normalPriceLabel.font = UIFont.boldSystemFont(ofSize: 15)
        normalPriceLabel.textColor = .black
    }
    
    func configureSale() {
        salePriceLabel.font = UIFont.boldSystemFont(ofSize: 15)
        normalPriceLabel.font = UIFont.systemFont(ofSize: 14)
        normalPriceLabel.textColor = .systemGray2
    }
}
