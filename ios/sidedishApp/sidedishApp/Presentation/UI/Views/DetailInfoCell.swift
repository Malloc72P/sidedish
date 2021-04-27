//
//  DetailInfoCell.swift
//  sidedishApp
//
//  Created by 김지선 on 2021/04/22.
//

import UIKit

class DetailInfoCell: UICollectionViewCell {
    class var reuseIdentifier: String {
        return "\(self)"
    }

    @Published var quantity = 0
    @Published var totalPrice = 0
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var normalPriceLabel: UILabel!
    @IBOutlet weak var pointPriceLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!

    @IBAction func orderButtonTouched(_ sender: Any) {
    }

    @IBOutlet weak var eventBadgeStackView: UIStackView!
    
    @IBAction func addQuantityButtonTouched(_ sender: Any) {
        quantity += 1
        
    }
    @IBAction func subtractQuantituButtonTouched(_ sender: Any) {
        quantity -= 1
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureCell(item: Detail) {

        nameLabel.text = item.getName()
        descriptionLabel.text = item.getDescription()
        salePriceLabel.text = "\(item.getSalePrice())원"
        normalPriceLabel.text = "\(item.getNormalPrice())원"
        pointPriceLabel.text = "\(item.getPointRate())"
        quantityLabel.text = "\(quantity)"
        totalPriceLabel.text = "\(totalPrice)원"
    }
    
    private func configureUI() {
        orderButton.layer.cornerRadius = 5
    }
    

}
