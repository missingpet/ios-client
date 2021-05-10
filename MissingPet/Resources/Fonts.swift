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
        case sUiDisplayBlack = "SFUIDisplay-Black"
        case sfUiDisplayBold = "SFUIDisplay-Bold"
        case sfUiDisplayHeavy = "SFUIDisplay-Heavy"
        case sfUiDisplayLigth = "SFUIDisplay-Light"
        case sfUiDisplayMedium = "SFUIDisplay-Medium"
        case sfUiDisplayRegular = "SFUIDisplay-Regular"
        case sfUiDisplaySemibold = "SFUIDisplay-Semibold"
        case sfUiDisplayThin = "SFUIDisplay-Thin"
        case sfUiDisplayUltralight = "SFUIDisplay-Ultralight"

        case sfUiTextBold = "SFUIText-Bold"
        case sfUiTextBoldItalic = "SFUIText-BoldItalic"
        case sfUiTextHeavy = "SFUIText-Heavy"
        case sfUiTextHeavyItalic = "SFUIText-HeavyItalic"
        case sfUiTextLight = "SFUIText-Light"
        case sfUiTextLightItalic = "SFUIText-LightItalic"
        case sfUiTextMedium = "SFUIText-Medium"
        case sfUiTextMediumItalic = "SFUIText-MediumItalic"
        case sfUiTextRegular = "SFUIText-Regular"
        case sfUiTextRegularItalic = "SFUIText-RegularItalic"
        case sfUiTextSemibold = "SFUIText-Semibold"
        case sfUiTextSemiboldItalic = "SFUIText-SemiboldItalic"
    }

    static func custom(_ customName: CustomName, size: CGFloat) -> UIFont {
        return UIFont(name: customName.rawValue, size: size)!
    }

}
