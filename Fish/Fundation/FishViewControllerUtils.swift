//
//  UIViewControllerUtils.swift
//  Fish
//
//  Created by yaoyuan on 2021/7/15.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation

class FishViewControllerUtils {
    class func removeUselessViewController(_ vc: UIViewController) {
        guard let navigationController = vc.navigationController else { return }
        var vcArays = navigationController.viewControllers
        guard let index = vcArays.firstIndex(of: vc) else { return }
        vcArays.remove(at: index)
        navigationController.viewControllers = vcArays
    }
}
