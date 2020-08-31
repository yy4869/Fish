//
//  UIButtonExtension.swift
//  Fish
//
//  Created by yaoyuan on 2020/8/27.
//  Copyright © 2020 Tutor. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setBackgroundColor(_ color: UIColor?, forState state: UIControl.State) {
        if let color = color {
            let image = UIImage.imageWithColor(color, size: CGSize(width: 1, height: 1))
            self.setBackgroundImage(image, for: state)
        } else {
            self.setBackgroundImage(nil, for: state)
        }
    }
}
