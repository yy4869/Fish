//
//  BaseViewController.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/23.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    struct Metric {
        static let buttonHeight: CGFloat = 50
        static let buttonMargin: CGFloat = 20
        static let commonMargin: CGFloat = 16
        static let labelHeight: CGFloat = 30
        static let marginRate: CGFloat = 3
        static let buttonSize: CGFloat = 24
    }

    private lazy var safeHeader: UILayoutGuide = UILayoutGuide()
    //    private lazy var safeHeader: UIView = {
    //        let view = UIView()
    //        view.backgroundColor = .white
    //        return view
    //    }()

    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var headerShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .UI_greyLightColor
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "PingFangSC-Medium", size: 17)
        label.textColor = .UI_darkColor
        label.textAlignment = .center
        return label
    }()

    lazy var leftButton: BaseButton = {
        let button = BaseButton()
        button.imageView?.contentMode = .center
        button.setImage(UIImage(named: "TTNavigationBarBack"), for: .normal)
        return button
    }()

    lazy var rightButton: BaseButton = {
        let button = BaseButton()
        button.imageView?.contentMode = .center
        return button
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .UI_whiteBackgroundColor
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "🐟"
        setupUserInterface()
    }

    private func setupUserInterface() {
        view.backgroundColor = .white

        view.addLayoutGuide(safeHeader)
        safeHeader.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalTo(safeHeader.snp.bottom)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(44)
        }
        headerView.addSubview(headerShadowView)
        headerShadowView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(headerView)
            make.height.equalTo(0.5)
        }
        headerView.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.centerX.equalTo(headerView.snp.leading).offset(24)
            make.width.height.equalTo(44)
            make.centerY.equalTo(headerView)
        }
        headerView.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.trailing.equalTo(headerView).offset(-2)
            make.width.height.greaterThanOrEqualTo(44)
            make.centerY.equalTo(headerView)
        }
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(headerView)
            make.leading.greaterThanOrEqualTo(leftButton.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(rightButton.snp.leading).offset(-10)
        }
        rightButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        rightButton.setContentHuggingPriority(.required, for: .horizontal)

        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
