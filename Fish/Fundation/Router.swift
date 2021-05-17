//
//  Router.swift
//  Fish
//
//  Created by yaoyuan on 2021/5/17.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation

@objc public class ForcePortraitNavigationController: UINavigationController {
    override open var shouldAutorotate: Bool {
        return false
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}

class ForceLandscapeNavigationController: UINavigationController {
    override open var shouldAutorotate: Bool {
        false
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscape
    }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        let orientation = UIApplication.shared.statusBarOrientation
        if orientation.isLandscape {
            return orientation
        } else {
            return .landscapeRight
        }
    }
}

