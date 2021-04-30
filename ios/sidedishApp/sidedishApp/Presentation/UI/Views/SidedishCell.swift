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

    let priceStack = PriceStackView()
    let badgeLabel = BadgeLabel()
    let eventBadgeStackView = UIStackView()
    let thumbnailImageView = RemoteImageView()
    
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
        
        guard let url = URL(string: item.getThumbnailImage()) else { return }
        self.thumbnailImageView.setImage(with: url)
        
        priceStack.configureSideDish(normalPrice: item.getNormalPrice(), salePrice: item.getSalePrice())
        
        for view in eventBadgeStackView.subviews {
            view.removeFromSuperview()
        }
        item.getEventBadgeList().forEach { eventBadge in
            let badgeLabel = BadgeLabel()
            badgeLabel.configureLabel(text: eventBadge.getName(), color: eventBadge.getColorHex())
            
            eventBadgeStackView.addArrangedSubview(badgeLabel)
        }
    }
    
    private func configureUI() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 21)
        nameLabel.numberOfLines = 2
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textColor = .gray
        
        eventBadgeStackView.spacing = 8
        eventBadgeStackView.axis = .horizontal
        
        let textStack = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, priceStack, eventBadgeStackView])
        textStack.axis = .vertical
        textStack.alignment = .leading
        textStack.spacing = 8
        
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
}
