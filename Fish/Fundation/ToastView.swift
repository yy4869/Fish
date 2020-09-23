//
//  ToastView.swift
//  TutorTeacherHD
//
//  Created by yhq on 16/4/26.
//  Copyright © 2016年 fenbi. All rights reserved.
//

import UIKit
import SnapKit

public enum ToastViewType {
    case normal
    case fullCover
}

open class ToastView: UIView {
    fileprivate let yMargin: Double = 25
    fileprivate let xMargin: Double = 26

    private lazy var imageView: UIImageView = UIImageView()

    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private lazy var textLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = .systemFont(ofSize: 18)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.82)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()

    class func show(hint: String) {
        guard let keyWindow = FishLayoutUtils.keyWindow else { return }
        show(inView: keyWindow, hint: hint)
    }

    public class func show(inView view: UIView, hint text: String?, image: UIImage? = nil, afterDelay delay: Double = 1.5) {
        let toastView = ToastView()
        toastView.textLabel.text = text ?? ""
        toastView.imageView.image = image

        DispatchQueue.main.async {
            view.addSubview(toastView)
            view.bringSubviewToFront(toastView)

            toastView.snp.remakeConstraints { make in
                make.edges.equalTo(view)
            }
            toastView.indicatorView.snp.updateConstraints { make in
                make.top.equalTo(toastView.contentView).offset(0)
                make.width.height.equalTo(0)
            }
            if image == nil {
                toastView.imageView.snp.updateConstraints { make in
                    make.top.equalTo(toastView.indicatorView.snp.bottom).offset(0)
                }
            } else {
                toastView.imageView.snp.updateConstraints { make in
                    make.top.equalTo(toastView.indicatorView.snp.bottom).offset(toastView.yMargin)
                }
            }

            UIView.animate(withDuration: 0.2, animations: {
                toastView.alpha = 1
            })

            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                toastView.hide()
            }
        }
    }

    public class func showLayoutView(inView view: UIView,
                                     hint text: String? = "正在加载",
                                     font: UIFont,
                                     layout: ((_ toastView: ToastView) -> Void)? = nil) {
        let toastView = ToastView()
        toastView.textLabel.text = text ?? ""
        toastView.textLabel.textColor = .white
        toastView.textLabel.font = font
        toastView.textLabel.numberOfLines = 0

        DispatchQueue.main.async {
            view.addSubview(toastView)
            view.bringSubviewToFront(toastView)

            if let layout = layout {
                layout(toastView)
            } else {
                toastView.snp.remakeConstraints { make in
                    make.edges.equalTo(view)
                }
            }
            toastView.indicatorView.snp.updateConstraints { make in
                make.top.equalTo(toastView.contentView).offset(0)
                make.width.height.equalTo(0)
            }
            toastView.imageView.snp.updateConstraints { make in
                make.top.equalTo(toastView.indicatorView.snp.bottom).offset(0)
            }

            UIView.animate(withDuration: 0.2, animations: {
                toastView.alpha = 1
            })

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                toastView.hide()
            }
        }
    }

    public class func showLoadingView(inView view: UIView,
                                      hint text: String? = "正在加载",
                                      type: ToastViewType = .normal,
                                      layout: ((_ toastView: ToastView) -> Void)? = nil) {
        let toastView = ToastView()
        toastView.textLabel.text = text ?? ""

        DispatchQueue.main.async {
            view.addSubview(toastView)
            view.bringSubviewToFront(toastView)

            if let layout = layout {
                layout(toastView)
            } else {
                toastView.snp.remakeConstraints { make in
                    make.edges.equalTo(view)
                }
            }

            toastView.indicatorView.snp.updateConstraints { make in
                make.top.equalTo(toastView.contentView).offset(toastView.yMargin)
                make.width.height.equalTo(35)
            }
            toastView.imageView.snp.updateConstraints { make in
                make.top.equalTo(toastView.indicatorView.snp.bottom).offset(0)
            }

            if type == .fullCover {
                toastView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                toastView.contentView.backgroundColor = .clear
            }

            toastView.indicatorView.startAnimating()
            UIView.animate(withDuration: 0.2, animations: {
                toastView.alpha = 1
            })
        }
    }

    public class func hideLoadingView(inView view: UIView) {
        DispatchQueue.main.async {
            for subview in view.subviews.reversed() {
                if let toastView = subview as? ToastView {
                    toastView.hide()
                }
            }
        }
    }

    // MARK: - private

    fileprivate func hide() {
        UIView.animate(withDuration: 0.2,
                       animations: {
                           self.alpha = 0
                       }, completion: { _ in
                           self.removeFromSuperview()
                       })
    }

    override fileprivate init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear

        addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
        contentView.addSubview(indicatorView)

        contentView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.leading.greaterThanOrEqualTo(self).offset(50)
            make.trailing.lessThanOrEqualTo(self).offset(-50)
        }
        indicatorView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(yMargin)
            make.width.height.equalTo(0)
            make.centerX.equalTo(contentView)
            make.leading.greaterThanOrEqualTo(contentView).offset(xMargin)
            make.trailing.lessThanOrEqualTo(contentView).offset(-xMargin)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(indicatorView.snp.bottom).offset(yMargin)
            make.centerX.equalTo(contentView)
            make.leading.greaterThanOrEqualTo(contentView).offset(xMargin)
            make.trailing.lessThanOrEqualTo(contentView).offset(-xMargin)
        }
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(yMargin)
            make.centerX.equalTo(contentView)
            make.leading.greaterThanOrEqualTo(contentView).offset(xMargin)
            make.trailing.lessThanOrEqualTo(contentView).offset(-xMargin)
            make.bottom.equalTo(contentView).offset(-yMargin)
            make.width.lessThanOrEqualTo(180)
            make.leading.trailing.equalTo(contentView).priority(.medium)
        }
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
