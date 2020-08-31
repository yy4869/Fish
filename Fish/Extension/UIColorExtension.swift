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


public extension UIColor {
    /**
     The shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.

     - parameter hex3: Three-digit hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.
     */
    convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue = CGFloat(hex3 & 0x00F) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     The shorthand four-digit hexadecimal representation of color with alpha.
     #RGBA defines to the color #RRGGBBAA.

     - parameter hex4: Four-digit hexadecimal value.
     */
    convenience init(hex4: UInt16) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green = CGFloat((hex4 & 0x0F00) >> 8) / divisor
        let blue = CGFloat((hex4 & 0x00F0) >> 4) / divisor
        let alpha = CGFloat(hex4 & 0x000F) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.

     - parameter hex6: Six-digit hexadecimal value.
     */
    convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
        let blue = CGFloat(hex6 & 0x0000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.

     - parameter hex8: Eight-digit hexadecimal value.
     */
    convenience init(hex8: UInt32) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex8 & 0xFF00_0000) >> 24) / divisor
        let green = CGFloat((hex8 & 0x00FF_0000) >> 16) / divisor
        let blue = CGFloat((hex8 & 0x0000_FF00) >> 8) / divisor
        let alpha = CGFloat(hex8 & 0x0000_00FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, throws error.

     - parameter rgba: String value.
     */
    convenience init(rgba_throws rgba: String) throws {
        guard rgba.hasPrefix("#") else {
            throw UIColorInputError.missingHashMarkAsPrefix
        }

        let hexString: String = String(rgba[rgba.index(after: rgba.startIndex)...])
        var hexValue: UInt32 = 0
        if !Scanner(string: hexString).scanHexInt32(&hexValue) {
            throw UIColorInputError.unableToScanHexValue
        }

        switch hexString.count {
        case 3:
            self.init(hex3: UInt16(hexValue))
        case 4:
            self.init(hex4: UInt16(hexValue))
        case 6:
            self.init(hex6: hexValue)
        case 8:
            self.init(hex8: hexValue)
        default:
            throw UIColorInputError.mismatchedHexStringLength
        }
    }

    /**
     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, fails to default color.

     - parameter rgba: String value.
     */
    convenience init(rgba: String, defaultColor: UIColor = UIColor.clear) {
        guard let color = try? UIColor(rgba_throws: rgba) else {
            self.init(cgColor: defaultColor.cgColor)
            return
        }
        self.init(cgColor: color.cgColor)
    }

    /**
     Hex string of a UIColor instance.

     - parameter rgba: Whether the alpha should be included.
     */
    func hexString(_ includeAlpha: Bool) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)

        if includeAlpha {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }

    func blendDarken(density: CGFloat = 0.8) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0

        guard getRed(&red, green: &green, blue: &blue, alpha: nil) else {
            return self
        }

        red *= density
        green *= density
        blue *= density
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
