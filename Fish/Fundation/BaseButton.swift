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

    @objc open var hitOffset = UIEdgeInsets.zero
    private let highlightedAlpha: CGFloat

    init(highlightedAlpha: CGFloat = 0.7) {
        self.highlightedAlpha = highlightedAlpha
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard hitOffset != UIEdgeInsets.zero && isEnabled && !isHidden else {
            return super.point(inside: point, with: event)
        }
        return bounds.inset(by: hitOffset).contains(point)
    }

    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)
        if state == .normal || state == .selected {
            setTitleColor(color?.withAlphaComponent(highlightedAlpha), for: [state, .highlighted])
        }
    }

    override func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        super.setBackgroundColor(color, for: state)
        if state == .normal || state == .selected {
            setBackgroundColor(color?.withAlphaComponent(highlightedAlpha), for: [state, .highlighted])
        }
    }

    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        if state == .normal || state == .selected {
            super.setImage(image?.alpha(highlightedAlpha), for: [state, .highlighted])
        }
    }

    override func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        super.setBackgroundImage(image, for: state)
        if state == .normal || state == .selected {
            super.setBackgroundImage(image?.alpha(highlightedAlpha), for: [state, .highlighted])
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
