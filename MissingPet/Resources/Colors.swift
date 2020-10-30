//
//  Colors.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 24.10.2020.
//

import Foundation
import UIKit

enum CustomColor: String {
    case mainWhite = "MainWhite"
    case lightGray = "LightGray"
    case mediumGray = "MediumGray"
    case darkGray = "DarkGray"
    case lightBlue = "LightBlue"
    case blue = "Blue"
    case darkBlue = "DarkBlue"
    case tabBarShadowColor = "TabBarShadowColor"
}

extension UIColor {
    static func custom(_ color: CustomColor) -> UIColor {
        return UIColor(named: color.rawValue)!
    }
}
