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
        configureUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    func configureCell(image: String){
        guard let url = URL(string: image) else { return }
        self.imageView.setImage(with: url)
    }
    
    private func configureUI() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }
}
