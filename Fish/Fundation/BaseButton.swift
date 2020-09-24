//
//  BaseButton.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/3.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import UIKit

class BaseButton: UIButton {

    private let highlightedAlpha: CGFloat = 0.7

    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)
        if state == .normal {
            setTitleColor(color?.withAlphaComponent(highlightedAlpha), for: .highlighted)
        }
    }

    override func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        super.setBackgroundColor(color, for: state)
        if state == .normal {
            setBackgroundColor(color?.withAlphaComponent(highlightedAlpha), for: .highlighted)
        }
    }

    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        if state == .normal {
            super.setImage(image?.alpha(highlightedAlpha), for: .highlighted)
        }
    }

    override func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        super.setBackgroundImage(image, for: state)
        if state == .normal {
            super.setBackgroundImage(image?.alpha(highlightedAlpha), for: .highlighted)
        }
    }

    override var isHighlighted: Bool {
        didSet {
            guard let color = layer.borderColor else { return }
            if isHighlighted {
                layer.borderColor = UIColor(cgColor: color).withAlphaComponent(highlightedAlpha).cgColor
            } else {
                layer.borderColor = UIColor(cgColor: color).withAlphaComponent(1.0).cgColor
            }
        }
    }
}

class BaseCornerRadiusButton: BaseButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
}
