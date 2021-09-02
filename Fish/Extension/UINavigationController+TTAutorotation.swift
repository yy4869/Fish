//
//  UINavigationController+TTAutorotation.swift
//  Fish
//
//  Created by yaoyuan on 2021/5/13.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation

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
