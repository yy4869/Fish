//
//  FishImageUtils.swift
//  Fish
//
//  Created by yaoyuan on 2021/7/1.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation

class FishImageUtils {
    class func captureImage(from view: UIView) -> UIImage? {
        let screenRect = view.bounds
        UIGraphicsBeginImageContextWithOptions(screenRect.size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        if let ctx = ctx {
            view.layer.render(in: ctx)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func placeholder(size: CGSize) -> UIImage? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.backgroundColor = UIColor.red
        let iconImage = UIImage(named: "logo")?.scaleTo(0.3)
        view.layer.contents = iconImage?.cgImage
        view.layer.contentsGravity = .center
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        if let ctx = ctx {
            view.layer.render(in: ctx)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

