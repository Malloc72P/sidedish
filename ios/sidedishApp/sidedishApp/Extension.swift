//
//  Extension.swift
//  sidedishApp
//
//  Created by 김지선 on 2021/04/28.
//

import Foundation
import UIKit

extension UIColor {
    class func hexStringToUIColor(hex: String) -> UIColor {
        let hexString = hex.trimmingCharacters(in: ["#"])
        var rgbValue:UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
