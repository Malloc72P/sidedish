//
//  DetailImageCell.swift
//  sidedishApp
//
//  Created by 김지선 on 2021/04/22.
//

import UIKit

class DetailImageCell: UICollectionViewCell {
    static let identifier = "DetailImageCell"
    let imageView = RemoteImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        backgroundColor = .blue
    }
}
