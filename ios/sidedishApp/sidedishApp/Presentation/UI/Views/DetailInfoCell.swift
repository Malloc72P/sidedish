//
//  DetailInfoCell.swift
//  sidedishApp
//
//  Created by 김지선 on 2021/04/22.
//

import UIKit
import Combine

class DetailInfoCell: UICollectionViewCell {
    class var reuseIdentifier: String {
        return "\(self)"
    }
    
    private var cancellables: Set<AnyCancellable> = []
    private var orderViewModel: OrderViewModel!
    private var item: Detail!
    
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
        self.orderViewModel.plus(price: self.item.getSalePrice())
    }
    
    @IBAction func subtractQuantituButtonTouched(_ sender: Any) {
        self.orderViewModel.minus(price: self.item.getSalePrice())
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
        self.orderViewModel = OrderViewModel(order: (1, item.getSalePrice()))
        self.item = item
        self.fetchOrderData()
        self.updateOrder()
    }
    
    private func configureUI() {
        orderButton.layer.cornerRadius = 5
    }
    
    private func fetchOrderData() {
        self.orderViewModel.dataChanged
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateOrder()
            }
            .store(in: &cancellables)
    }
    
    private func updateOrder() {
        self.quantityLabel.text = "\(orderViewModel.getOder().quantity)"
        self.totalPriceLabel.text = "\(orderViewModel.getOder().amount)"
    }
}
