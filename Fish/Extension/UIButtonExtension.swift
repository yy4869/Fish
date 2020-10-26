//
//  UIButtonExtension.swift
//  Fish
//
//  Created by yaoyuan on 2020/8/27.
//  Copyright © 2020 Tutor. All rights reserved.
//

import UIKit

extension UIButton {
    @objc func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        if let color = color {
            let image = UIImage.imageWithColor(color)
            self.setBackgroundImage(image, for: state)
        } else {
            self.setBackgroundImage(nil, for: state)
        }
    }
}
