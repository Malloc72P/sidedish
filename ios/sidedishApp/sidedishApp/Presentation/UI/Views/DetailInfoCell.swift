//
//  DetailInfoCell.swift
//  sidedishApp
//
//  Created by 김지선 on 2021/04/22.
//

import UIKit

class DetailInfoCell: UICollectionViewCell {

    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        configureUI()
    }
    
    func configureCell(item: Detail) {
        backgroundColor = .red
//        nameLabel.text = item.getName()
//        descriptionLabel.text = item.getDescription()
//        salePriceLabel.text = "\(item.getSalePrice())"
//        normalPriceLabel.text = "\(item.getNormalPrice())"
//        pointPriceLabel.text = "\(item.getPointRate())"
    }
    
    private func configureUI() {
        nameLabel.text = ""
        descriptionLabel.text = ""
        salePriceLabel.text = ""
        normalPriceLabel.text = ""
        pointPriceLabel.text = ""
        orderButton.layer.cornerRadius = 5
    }
    
    class var reuseIdentifier: String {
        return "\(self)"
    }
}
