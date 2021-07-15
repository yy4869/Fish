//
//  UIViewController+TTPresentHelper.swift
//  Fish
//
//  Created by yaoyuan on 2021/5/12.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation

extension UIViewController {
    func presentNavigationControllerWrappedViewController(_ vc: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: animated, completion: completion)
    }

    func forceLandscape(_ vc: UIViewController) {
        let navi = ForceLandscapeNavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        navi.setNavigationBarHidden(true, animated: false)
        present(navi, animated: true, completion: nil)
    }
    
    func forceLandscapeAndDismissSelf(_ vc: UIViewController) {
        let navi = ForceLandscapeNavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        navi.setNavigationBarHidden(true, animated: false)
        present(navi, animated: true) {
            FishViewControllerUtils.removeUselessViewController(self)
        }
    }
    
    func forcePortrait(_ vc: UIViewController) {
        let navi = ForcePortraitNavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        navi.setNavigationBarHidden(true, animated: false)
        present(navi, animated: true, completion: nil)
    }
    
    func forcePortraitAndDismissSelf(_ vc: UIViewController) {
        let navi = ForcePortraitNavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        present(navi, animated: true) {
            FishViewControllerUtils.removeUselessViewController(self)
        }
    }
    
    func pushNextVCAndDismissSelf(_ nextVC: UIViewController, animated: Bool) {
        navigationController?.pushViewController(nextVC, animated: true, completion: {
            FishViewControllerUtils.removeUselessViewController(self)
        })
    }
}
