//
//  TTUIStackViewExtension.swift
//  TutorFoundation
//
//  参考:
//  https://stackoverflow.com/questions/32999159/how-can-i-create-uistackview-with-variable-spacing-between-views
//  https://nshipster.com/uistackview/
//
//  Created by 郭栋 on 2019/12/24.
//

import Foundation

extension UIStackView {

    open func addFullSizeArrangedSubview(_ arrangedSubview: UIView) {
        addCenteredArrangedSubview(arrangedSubview, size: 0, aligmentSpacing: 0)
    }

    open func addFullSizeArrangedSubview(_ arrangedSubview: UIView, size: CGFloat) {
        addCenteredArrangedSubview(arrangedSubview, size: size, aligmentSpacing: 0)
    }

    open func addCenteredArrangedSubview(_ arrangedSubview: UIView, aligmentSpacing: CGFloat) {
        addCenteredArrangedSubview(arrangedSubview, size: 0, aligmentSpacing: aligmentSpacing)
    }

    open func addCenteredArrangedSubview(_ arrangedSubview: UIView, size: CGFloat, aligmentSpacing: CGFloat) {
        addArrangedSubview(arrangedSubview, size: size, leadSpacing: aligmentSpacing, tailSpacing: aligmentSpacing)
    }

    open func addArrangedSubview(_ arrangedSubview: UIView,
                                 size: CGFloat,
                                 leadSpacing: CGFloat,
                                 tailSpacing: CGFloat) {
        addArrangedSubview(arrangedSubview)
        switch axis {
        case .vertical:
            arrangedSubview.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(leadSpacing)
                make.right.equalToSuperview().offset(-1 * tailSpacing)
                if size > 0 {
                    make.height.equalTo(size)
                }
            }
        case .horizontal:
            arrangedSubview.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(leadSpacing)
                make.bottom.equalToSuperview().offset(-1 * tailSpacing)
                if size > 0 {
                    make.width.equalTo(size)
                }
            }
        default:
            return
        }
    }
    
    open func addSpacing(_ spacing: CGFloat) {
        guard let lastView = arrangedSubviews.last else { return }
        addSpacing(spacing, after: lastView)
    }

    open func addSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        guard let index = arrangedSubviews.firstIndex(of: arrangedSubview) else {
            return
        }
        if index == arrangedSubviews.count - 1 ||
            arrangedSubviews[index + 1].accessibilityIdentifier != "spacer" {
            let separatorView = UIView(frame: .zero)
            separatorView.accessibilityIdentifier = "spacer"
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            switch axis {
            case .horizontal:
                separatorView.widthAnchor.constraint(equalToConstant: spacing).isActive = true
            case .vertical:
                separatorView.heightAnchor.constraint(equalToConstant: spacing).isActive = true
            default:
                return
            }
            insertArrangedSubview(separatorView, at: index + 1)
        } else {
            arrangedSubviews[index + 1].updateConstraint(axis == .horizontal ? .width : .height, to: spacing)
        }
    }

    open func removeSpacing(after arrangedSubview: UIView) {
        if let index = indexofSpacingView(after: arrangedSubview) {
            arrangedSubviews[index + 1].removeFromStack()
        }
    }

    open func showSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        if let index = indexofSpacingView(after: arrangedSubview) {
            arrangedSubviews[index + 1].updateConstraint(axis == .horizontal ? .width : .height, to: spacing)
        }
    }

    open func hideSpacing(after arrangedSubview: UIView) {
        if let index = indexofSpacingView(after: arrangedSubview) {
            arrangedSubviews[index + 1].updateConstraint(axis == .horizontal ? .width : .height, to: 0)
        }
    }

    public func removeAllSubviews() {
        for subview in arrangedSubviews {
            subview.removeFromSuperview()
        }
    }

    private func indexofSpacingView(after arrangedSubview: UIView) -> Int? {
        guard let index = arrangedSubviews.firstIndex(of: arrangedSubview),
            index < arrangedSubviews.count - 1,
            arrangedSubviews[index + 1].accessibilityIdentifier == "spacer" else {
            return nil
        }
        return index
    }
}

extension UIView {

    fileprivate func updateConstraint(_ attribute: NSLayoutConstraint.Attribute, to constant: CGFloat) {
        for constraint in constraints {
            if constraint.firstAttribute == attribute {
                constraint.constant = constant
            }
        }
    }

    fileprivate func removeFromStack() {
        if let stack = superview as? UIStackView, stack.arrangedSubviews.contains(self) {
            stack.removeArrangedSubview(self)
            removeFromSuperview()
        }
    }
}
