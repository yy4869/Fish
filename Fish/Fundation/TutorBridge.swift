//
//  TutorBridge.swift
//  Fish
//
//  Created by yaoyuan on 2021/7/23.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation

extension UIColor {
    // 品牌色
    static func tt_Orange_01() -> UIColor {
        return UIColor(rgbValue: 0xFF7400)
    }
}

class TTFontUtils {
    static func mediumPingFangSCFont(withSize: CGFloat) -> UIFont {
        return FishFontUtils.mediumPingFangSCFont(size: withSize)
    }
}
