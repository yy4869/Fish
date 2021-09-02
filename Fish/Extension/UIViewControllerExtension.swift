//
//  UIViewController+TTPresentHelper.swift
//  Fish
//
//  Created by yaoyuan on 2021/5/12.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation

extension UIViewController {
    func forceLandscape(_ vc: UIViewController, completion: (() -> Void)? = nil) {
        let navi = ForceLandscapeNavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        navi.setNavigationBarHidden(true, animated: false)
        present(navi, animated: true, completion: completion)
    }

    func forceLandscapeAndDismissSelf(_ vc: UIViewController) {
        forceLandscape(vc) {
            FishViewControllerUtils.removeUselessViewController(self)
        }
    }

    func forcePortrait(_ vc: UIViewController, completion: (() -> Void)? = nil) {
        let navi = ForcePortraitNavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        navi.setNavigationBarHidden(true, animated: false)
        present(navi, animated: true, completion: completion)
    }

    func forcePortraitAndDismissSelf(_ vc: UIViewController) {
        forcePortrait(vc) {
            FishViewControllerUtils.removeUselessViewController(self)
        }
    }

    func pushNextVCAndDismissSelf(_ nextVC: UIViewController, animated: Bool) {
        navigationController?.pushViewController(nextVC, animated: true, completion: {
            FishViewControllerUtils.removeUselessViewController(self)
        })
    }
}
