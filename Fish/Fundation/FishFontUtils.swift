//
//  FishFontUtils.swift
//  Fish
//
//  Created by yaoyuan on 2021/2/24.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation

class FishFontUtils {
    class func regularPingFangSCFont(size: CGFloat) -> UIFont {
        let font = UIFont(name: "PingFangSC-Regular", size: size)
        return font ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }

    class func mediumPingFangSCFont(size: CGFloat) -> UIFont {
        let font = UIFont(name: "PingFangSC-Medium", size: size)
        return font ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }

    class func semiBoldPingFangSCFont(size: CGFloat) -> UIFont {
        let font = UIFont(name: "PingFangSC-Semibold", size: size)
        return font ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
}
