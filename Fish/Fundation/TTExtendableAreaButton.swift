//
//  TTExtendableAreaButton.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/28.
//  Copyright © 2020 Tutor. All rights reserved.
//

import UIKit

open class ExtendableAreaButton: UIButton {

    @objc open var hitOffset = UIEdgeInsets.zero

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard hitOffset != UIEdgeInsets.zero && isEnabled && !isHidden else {
            return super.point(inside: point, with: event)
        }
        return bounds.inset(by: hitOffset).contains(point)
    }
}
