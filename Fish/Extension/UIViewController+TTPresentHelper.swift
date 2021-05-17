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
}
