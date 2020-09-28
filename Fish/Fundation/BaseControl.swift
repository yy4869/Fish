//
//  BaseControl.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/28.
//  Copyright © 2020 Tutor. All rights reserved.
//

import UIKit

class BaseControl: UIControl {
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.7 : 1.0
        }
    }
}
