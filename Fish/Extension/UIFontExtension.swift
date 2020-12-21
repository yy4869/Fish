//
//  UIFontExtension.swift
//  Fish
//
//  Created by yaoyuan on 2020/12/3.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    /// 等宽字体
    func monospacedDigitFont() -> UIFont {
        let oriDesc = fontDescriptor

        let attri = [
            UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
            UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector
        ]

        let fontAttrs = [UIFontDescriptor.AttributeName.featureSettings: [attri]]
        let monospacedDigitFontDesc = oriDesc.addingAttributes(fontAttrs)
        return UIFont(descriptor: monospacedDigitFontDesc, size: pointSize)
    }
}
