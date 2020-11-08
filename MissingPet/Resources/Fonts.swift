//
//  Fonts.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 03.11.2020.
//

import Foundation
import UIKit

extension UIFont {
    
    static let defaultFontSize: CGFloat = 14.0
    
    enum CustomName: String {
        case sfUiDisplayBold = "SFUIDisplay-Bold"
        case sfUiDisplayRegular = "SFUIDisplay-Regular"
    }
    
    static func custom(_ customName: CustomName, size: CGFloat) -> UIFont {
        return UIFont(name: customName.rawValue, size: size)!
    }
    
}
