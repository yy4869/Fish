//
//  FishOrientationUtils.swift
//  Fish
//
//  Created by yaoyuan on 2021/5/13.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation

//  Converted to Swift 5.4 by Swiftify v5.4.24202 - https://swiftify.com/

class FishOrientationUtils {
    class func shouldAutorotate() -> Bool {
        return false
    }

    class func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .portrait
    }

    class func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        let orientation = UIDevice.current.orientation
        if orientation != .unknown {
            let interfaceOrientation = self.convert(orientation)
            if interfaceOrientation == .unknown {
                return UIApplication.shared.statusBarOrientation
            }
            return interfaceOrientation
        } else {
            return .portrait
        }
    }

    class func convert(_ orientation: UIDeviceOrientation) -> UIInterfaceOrientation {
        switch orientation {
            case .portrait:
                return .portrait
            case .landscapeLeft:
                return .landscapeRight
            case .landscapeRight:
                return .landscapeLeft
            case .portraitUpsideDown:
                return .portraitUpsideDown
            default:
                return .unknown
        }
        return .unknown
    }
}
