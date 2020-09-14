//
//  UIColorExtension.swift
//  Fish
//
//  Created by yaoyuan on 2020/8/27.
//  Copyright © 2020 Tutor. All rights reserved.
//

import UIKit

public enum UIColorInputError: Error {
    case missingHashMarkAsPrefix,
        unableToScanHexValue,
        mismatchedHexStringLength
}

extension UIColor {

    convenience init(rgbValue: UInt) {
        self.init(rgbValue: rgbValue, alpha: 1.0)
    }

    convenience init(rgbValue: UInt, alpha: CGFloat) {
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }

    /// 橘色 FF7400
    static let UI_orangeColor = UIColor(rgbValue: 0xFF7400)

    /// 正黑色 222222
    static let UI_darkColor = UIColor(rgbValue: 0x222222)
    /// 中黑色 333333
    static let UI_darkMediumColor = UIColor(rgbValue: 0x333333)
    /// 浅黑色 666666
    static let UI_darkLightColor = UIColor(rgbValue: 0x666666)

    /// 灰色 999999
    static let UI_greyColor = UIColor(rgbValue: 0x999999)
    /// 浅灰色 CCCCCC
    static let UI_greyLightColor = UIColor(rgbValue: 0xCCCCCC)

    /// 不刺眼白色 F3F4F5
    static let UI_whiteBackgroundColor = UIColor(rgbValue: 0xF3F4F5)
    /// 不刺眼白色 5775A8
    static let UI_whiteTabBarBackgroundColor = UIColor(rgbValue: 0xF6F6F7)
    /// 灰白色 E7E7E7
    static let UI_whiteBoundryColor = UIColor(rgbValue: 0xE7E7E7)

    /// 蓝色 5775A8
    static let UI_blueLinkColor = UIColor(rgbValue: 0x5775A8)
    /// 亮蓝色 6991FF
    static let UI_blueLightColor = UIColor(rgbValue: 0x6991FF)
}
