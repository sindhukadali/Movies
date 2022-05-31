//
//  UIColor+Extensions.swift
//  Movies
//
//  Created by Sindhu on 31/05/22.
//

import UIKit

extension UIColor {
    static func getRgb(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: (red/255.0), green: (green/255.0), blue: (blue/255.0), alpha: alpha)
    }

    static let appColor = UIColor.getRgb(80, green: 197, blue: 185)
    static let lightGrayTextColor = UIColor.getRgb(130, green: 130, blue: 130)
}
