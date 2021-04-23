//
//  SidedishCell.swift
//  sidedishApp
//
//  Created by zombietux on 2021/04/19.
//

import UIKit

class SidedishCell: UICollectionViewCell {
    static let reuseIdentifier = "SidedishCell"
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let normalPriceLabel = UILabel()
    let salePriceLabel = UILabel()
    let eventBadgeStackView = UIStackView()
    let thumbnailImageView = RemoteImageView()
    
    private let isSale = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    func configureCell(item: Item) {
        self.nameLabel.text = item.getName()
        self.descriptionLabel.text = item.getDescription()
        
        self.salePriceLabel.text = "\(item.getSalePrice())"
        self.normalPriceLabel.text = "\(item.getNormalPrice())"
        if item.isSale() {
            normalPriceLabel.attributedText = strikeThrough(text: "\(item.getNormalPrice())")
            normalPriceLabel.font = UIFont.systemFont(ofSize: 12)
            normalPriceLabel.textColor = .systemGray2
        } else {
            self.normalPriceLabel.isHidden = true
            swap(&salePriceLabel.text, &normalPriceLabel.text)
            normalPriceLabel.font = UIFont.systemFont(ofSize: 15)
            normalPriceLabel.textColor = .black
        }
        
        guard let url = URL(string: item.getThumbnailImage()) else { return }
        self.thumbnailImageView.setImage(with: url)
        
        for view in eventBadgeStackView.subviews {
            view.removeFromSuperview()
        }
        
        item.getEventBadgeList().forEach { eventBadge in
            let badgeLabel = BadgeLabel()
            badgeLabel.padding = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
            badgeLabel.sizeToFit()
            badgeLabel.layer.cornerRadius = 8
            badgeLabel.layer.masksToBounds = true
            badgeLabel.textColor = .systemBackground
            badgeLabel.font = UIFont.boldSystemFont(ofSize: 16)
            badgeLabel.backgroundColor = UIColor.hexStringToUIColor(hex: eventBadge.getColorHex())
            badgeLabel.text = eventBadge.getName()
            eventBadgeStackView.addArrangedSubview(badgeLabel)
        }
    }
    
    private func configureUI() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 21)
        nameLabel.numberOfLines = 2
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textColor = .gray
        
        salePriceLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        let priceStack = UIStackView(arrangedSubviews: [salePriceLabel, normalPriceLabel])
        priceStack.axis = .horizontal
        priceStack.spacing = 4
        
        let textStack = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, priceStack, eventBadgeStackView])
        textStack.axis = .vertical
        textStack.alignment = .leading
        textStack.spacing = 8
        
        eventBadgeStackView.spacing = 8
        eventBadgeStackView.axis = .horizontal
        
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.layer.cornerRadius = 6
        thumbnailImageView.layer.masksToBounds = true
        
        let itemStack = UIStackView(arrangedSubviews: [thumbnailImageView, textStack])
        itemStack.axis = .horizontal
        itemStack.alignment = .center
        itemStack.spacing = 10
        
        contentView.addSubview(itemStack)
        itemStack.translatesAutoresizingMaskIntoConstraints = false
        
        let imageWidthConstraint = thumbnailImageView.widthAnchor.constraint(equalToConstant: 160)
        imageWidthConstraint.priority = .defaultHigh + 1
        
        NSLayoutConstraint.activate([
            imageWidthConstraint,
            thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, multiplier: 1),
            itemStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            itemStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            itemStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
    }
    
    func strikeThrough(text: String) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        
        return attributeString
    }
}

extension UIColor {
    class func hexStringToUIColor (hex:String) -> UIColor {
        var rgbValue:UInt64 = 0
        let hexColor = hex.trimmingCharacters(in: ["#"])
        Scanner(string: hexColor).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


