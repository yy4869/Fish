//
//  UINavigationController+TTAutorotation.swift
//  Fish
//
//  Created by yaoyuan on 2021/5/13.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation

extension UINavigationController {

    open override var shouldAutorotate: Bool {
        if topViewControllerShouldRotate() {
            return true
        }
        return FishOrientationUtils.shouldAutorotate()
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if topViewControllerShouldRotate() {
            return (topViewController?.supportedInterfaceOrientations)!
        }
        return FishOrientationUtils.supportedInterfaceOrientations()
    }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if topViewControllerShouldRotate() {
            return (topViewController?.preferredInterfaceOrientationForPresentation)!
        }
        return FishOrientationUtils.preferredInterfaceOrientationForPresentation()
    }

    func topViewControllerShouldRotate() -> Bool {
        if topViewController == nil {
            return false
        }
        return false
    }
}

extension UINavigationController {
    func popViewController(animated: Bool, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion()
        }
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func pushViewController(_ vc:UIViewController, animated: Bool, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion()
        }
        pushViewController(vc, animated: animated)
        CATransaction.commit()
    }
}
