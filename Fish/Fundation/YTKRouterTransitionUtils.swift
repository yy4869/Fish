//
//  YTKRouterTransitionUtils.swift
//  Fish
//
//  Created by yaoyuan on 2021/5/17.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation

enum YTKRouterTransitionStyle : Int {
    ///  Push destined viewController in source viewController.navigationController.
    case push
    ///  Present a new UINavigationController and set its rootViewController as destined viewController.
    case present
    ///  Replace source viewController.navigationController.topViewController with destined viewController.
    case replace
    ///  Replace source viewController.navigationController.topViewController with destined viewController, no animation.
    case replaceWithoutAnimation
}

class YTKRouterTransitionUtils: NSObject {
    class func show(
        _ viewController: UIViewController,
        from fromViewController: UIViewController,
        with transitionStyle: YTKRouterTransitionStyle
    ) {
        switch transitionStyle {
            case .push:
                fromViewController.navigationController?.pushViewController(viewController, animated: true)
            case .present:
                let navi = UINavigationController(rootViewController: viewController)
                navi.modalPresentationStyle = .fullScreen
                fromViewController.present(navi, animated: true)
            case .replace:
                replace(fromViewController, with: viewController, animated: true)
            case .replaceWithoutAnimation:
                replace(fromViewController, with: viewController, animated: false)
        }
    }

    class func replace(
        _ oldViewController: UIViewController,
        with newViewController: UIViewController,
        animated: Bool
    ) {
        let navi = oldViewController.navigationController
        if navi == nil {
            return
        }
        let count = navi?.viewControllers.count ?? 0
        let stackVCs = Array<UIViewController>(navi?.viewControllers.prefix(count - 1 ) ?? [])
        navi?.setViewControllers(stackVCs, animated: animated)
     }
}
