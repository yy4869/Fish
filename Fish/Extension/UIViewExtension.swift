//
//  UIViewExtension.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/24.
//  Copyright © 2020 Tutor. All rights reserved.
//

import UIKit

extension UIView {

    var x: CGFloat { frame.origin.x }
    var y: CGFloat { frame.origin.y }
    var width: CGFloat { frame.size.width }
    var height: CGFloat { frame.size.height }
    var size: CGSize { frame.size }
}
