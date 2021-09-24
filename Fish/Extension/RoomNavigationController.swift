//
//  RoomNavigationController.swift
//  TutorLiveSDK
//
//  Created by Liang You on 2021/4/27.
//

import UIKit

// 控制屏幕方向的 UINavigationController，所有教室都用该类
class RoomNavigationController: UINavigationController {
    override var shouldAutorotate: Bool {
//        return topViewController?.shouldAutorotate ?? false
        true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return topViewController?.supportedInterfaceOrientations ?? .landscape
        [.landscapeLeft, .landscapeRight]
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        if let topViewController = self.topViewController {
//            return topViewController.preferredInterfaceOrientationForPresentation
//        }

        let orientation = UIApplication.shared.statusBarOrientation
        if orientation.isLandscape {
            return orientation
        } else {
            return .landscapeRight
        }
    }
}

extension UIViewController {
    func present(
        in controller: UIViewController,
        animated: Bool,
        completion: (() -> Void)?
    ) {
        let navController = RoomNavigationController(rootViewController: self)
        navController.modalPresentationStyle = .fullScreen
        controller.present(navController, animated: animated, completion: completion)
    }
}
