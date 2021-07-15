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
        return true
    }

    class func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .all
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

    class func landPresent(
        vc: UIViewController,
        from viewController: UIViewController,
        with transitionStyle: YTKRouterTransitionStyle
    ) {
        guard UIApplication.shared.statusBarOrientation.isPortrait
              || transitionStyle == .present else {
            YTKRouterTransitionUtils.show(
                vc,
                from: viewController,
                with: transitionStyle
            )
            return
        }
        let navi = ForceLandscapeNavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        navi.setNavigationBarHidden(true, animated: false)
        viewController.present(navi, animated: true, completion: nil)
    }

    class func portraitPresent(
        vc: UIViewController,
        from viewController: UIViewController,
        with transitionStyle: YTKRouterTransitionStyle
    ) {
        guard UIApplication.shared.statusBarOrientation.isLandscape
              || transitionStyle == .present  else {
            YTKRouterTransitionUtils.show(
                vc,
                from: viewController,
                with: transitionStyle
            )
            return
        }
        let navi = ForcePortraitNavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        navi.setNavigationBarHidden(true, animated: false)
        viewController.present(navi, animated: true, completion: nil)
    }    
}
