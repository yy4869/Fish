//
//  FishLayoutUtils.swift
//  Fish
//
//  Created by yaoyuan on 2020/8/31.
//  Copyright © 2020 Tutor. All rights reserved.
//

import UIKit
import Foundation

struct FishLayoutUtils {

    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height

    static var isiPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    /// 刘海屏
    static var topPadding: CGFloat {
        isFullScreen && !isiPad ? 24 : 0
    }

    static var topMargin: CGFloat {
        topPadding + 64
    }

    /// 底部安全区高度
    static var bottomPadding: CGFloat {
        return isFullScreen ? (isiPad ? 20 : 34) : 0
    }

    static func isiphoneX() -> Bool {
        let height = max(screenWidth, screenHeight)
        return height == 896.0 || height == 812.0
    }

    static var isFullScreen: Bool {
        guard let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = delegate.window else {
            return false
        }
        return window.safeAreaInsets.bottom > 0
    }

//    首先,刘海屏在iOS 11之后才推出,而重中之重的是safeAreaInsets属性
//    以下分别是竖屏与横屏的时候,safeAreaInsets打印的值
//    UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
//    UIEdgeInsets(top: 0.0, left: 44.0, bottom: 21.0, right: 44.0)

    static var keyWindow: UIView? {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first
    }
}
