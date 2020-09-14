//
//  UIImageExtension.swift
//  Fish
//
//  Created by yaoyuan on 2020/8/27.
//  Copyright © 2020 Tutor. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage? {
        var realSize = size
        if realSize == CGSize.zero {
            realSize = CGSize(width: 1, height: 1)
        }
        UIGraphicsBeginImageContextWithOptions(realSize, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        color.setFill()
        context.fill(CGRect(x: 0, y: 0, width: realSize.width, height: realSize.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
