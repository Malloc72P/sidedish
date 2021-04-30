//
//  BadgeLabel.swift
//  sidedishApp
//
//  Created by zombietux on 2021/04/21.
//

import UIKit

class BadgeLabel: UILabel {
    var padding : UIEdgeInsets
    
    func configureLabel(text: String, color: String) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.padding = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        self.sizeToFit()
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.textColor = .systemBackground
        self.font = UIFont.boldSystemFont(ofSize: 16)
        self.backgroundColor = UIColor.hexStringToUIColor(hex: color)
        self.text = text
    }
    
    required init(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)) {
        self.padding = padding
        super.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        padding = UIEdgeInsets.zero
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        padding = UIEdgeInsets.zero
        super.init(coder: coder)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let width = superSizeThatFits.width + padding.left + padding.right
        let heigth = superSizeThatFits.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
}
