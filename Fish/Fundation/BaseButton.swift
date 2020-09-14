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
    private let disabledAlpha: CGFloat = 0.2


    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        if state == .normal {
            let highlightedImage = image?.alpha(highlightedAlpha)
            let disabledImage = image?.alpha(disabledAlpha)
            super.setImage(highlightedImage, for: .highlighted)
            super.setImage(disabledImage, for: .disabled)
        } else if state == .selected {
            let highlightedImage = image?.alpha(highlightedAlpha)
            let disabledImage = image?.alpha(disabledAlpha)
            super.setImage(highlightedImage, for: [.highlighted, .selected])
            super.setImage(disabledImage, for: [.disabled, .selected])
        }
    }

    override func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        super.setBackgroundImage(image, for: state)
        if state == .normal {
            let highlightedImage = image?.alpha(highlightedAlpha)
            let disabledImage = image?.alpha(disabledAlpha)
            super.setBackgroundImage(highlightedImage, for: .highlighted)
            super.setBackgroundImage(disabledImage, for: .disabled)
        } else if state == .selected {
            let highlightedImage = image?.alpha(highlightedAlpha)
            let disabledImage = image?.alpha(disabledAlpha)
            super.setBackgroundImage(highlightedImage, for: [.highlighted, .selected])
            super.setBackgroundImage(disabledImage, for: [.disabled, .selected])
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
