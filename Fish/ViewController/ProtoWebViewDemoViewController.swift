//
//  ProtoWebViewDemoViewController.swift
//  Fish
//
//  Created by yaoyuan on 2021/5/17.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation
import UIKit

enum Direction: String {
    case horizontal
    case vertical
    case empty = ""
}

struct EntryProto {
    let transparentNavigation: Bool = false
    let title = "Proto"
    let direction: Direction = .vertical
}

class BaseProtoWebViewController: UIViewController {

    lazy var safeHeader: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        return view
    }()

    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
        return view
    }()

    lazy var headerShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "PingFangSC-Medium", size: 17)
        label.textColor = UIColor.black
        label.text = entry.title
        label.textAlignment = .center
        return label
    }()

    lazy var leftButton: BaseButton = {
        let button = BaseButton()
        button.imageView?.contentMode = .center
        button.setImage(UIImage(named: "TTNavigationBarBack"), for: .normal)
        button.addTarget(self, action: #selector(returnButtonPressed), for: .touchUpInside)
        return button
    }()

    lazy var rightButton: BaseButton = {
        let button = BaseButton()
        button.imageView?.contentMode = .center
        return button
    }()

    lazy var webContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()


    private lazy var setTopBarButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("setTopBar", for: .normal)
        button.addTarget(self, action: #selector(setButtonPressed), for: .touchUpInside)
        button.backgroundColor = .orange
        return button
    }()

    private lazy var controlNavButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("controlNav", for: .normal)
        button.addTarget(self, action: #selector(controlPressed), for: .touchUpInside)
        button.backgroundColor = .orange
        return button
    }()

    let entry: EntryProto

    // 包含状态栏、导航栏和左右按钮
    var hiddenNavigationAndStateBar: Bool = false {
        didSet {
            leftButton.isHidden = hiddenNavigationBar
            rightButton.isHidden = hiddenNavigationBar
            headerView.isHidden = hiddenNavigationBar
            safeHeader.isHidden = hiddenNavigationBar
        }
    }

    // 包含导航栏和左右按钮
    var hiddenNavigationBar: Bool = false {
        didSet {
            leftButton.isHidden = hiddenNavigationBar
            rightButton.isHidden = hiddenNavigationBar
            headerView.isHidden = hiddenNavigationBar
        }
    }

    // 只隐藏 headerView，左右按钮保持不变
    var hiddenHeaderView: Bool = false {
        didSet {
            headerView.isHidden = hiddenNavigationBar
        }
    }

    var setTopBar: Bool = false
    var controlNav: Bool = false

    init(entry: EntryProto) {
        self.entry = entry
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
    }

    // MARK: - layout

    private func setupUserInterface() {
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = .white
        setupNavigationAndStateBar()

        webContainerView.addSubview(setTopBarButton)
        webContainerView.addSubview(controlNavButton)
        setTopBarButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        controlNavButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(40)
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
    }

    private func setupNavigationAndStateBar() {
        view.addSubview(safeHeader)
        safeHeader.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(view)
            make.height.equalTo(20)
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
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

        view.addSubview(webContainerView)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        if entry.transparentNavigation {
            leftButton.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(buttonLeft)
                make.top.equalToSuperview().offset(buttonTop)
            }
            rightButton.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(buttonRight)
                make.top.equalToSuperview().offset(buttonTop)
            }
            webContainerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        } else {
            leftButton.snp.makeConstraints { make in
                make.centerX.equalTo(headerView.snp.leading).offset(24)
                make.width.height.equalTo(44)
                make.centerY.equalTo(headerView)
            }
            rightButton.snp.makeConstraints { make in
                make.trailing.equalTo(headerView).offset(-2)
                make.width.height.greaterThanOrEqualTo(44)
                make.centerY.equalTo(headerView)
            }
            webContainerView.snp.makeConstraints { make in
                make.leading.trailing.bottom.equalTo(self.view)
                make.top.equalTo(headerView.snp.bottom)
            }
        }

        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(headerView)
            make.leading.greaterThanOrEqualTo(leftButton.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(rightButton.snp.leading).offset(-10)
        }
        rightButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        rightButton.setContentHuggingPriority(.required, for: .horizontal)
    }


    @objc private func returnButtonPressed() {
        ToastView.show(hint: "return")
    }

    @objc private func setButtonPressed() {
        ToastView.show(hint: "set")
        guard !entry.transparentNavigation else {
            // 导航栏透明时，没有headerView
            return
        }
        if setTopBar || headerView.isHidden {
            webContainerView.snp.updateConstraints({ make in
                make.top.equalTo(headerView.snp.bottom)
                    .offset(-headerView.height - safeHeader.height)
            })
        } else {
            webContainerView.snp.updateConstraints({ make in
                make.top.equalTo(headerView.snp.bottom)
            })
        }
        setTopBar = !setTopBar
    }

    @objc private func controlPressed() {
        ToastView.show(hint: "control")
        guard !entry.transparentNavigation else {
            leftButton.isHidden = controlNav
            rightButton.isHidden = controlNav
            return
        }
        headerView.isHidden = controlNav
        if controlNav {
            webContainerView.snp.updateConstraints({ make in
                make.top.equalTo(headerView.snp.bottom)
                    .offset(-headerView.height)
            })
        } else {
            webContainerView.snp.updateConstraints({ make in
                make.top.equalTo(headerView.snp.bottom)
            })
        }
        controlNav = !controlNav
    }
}

extension BaseProtoWebViewController {
    var safeHeaderHeight: CGFloat {
        entry.direction == .horizontal ? 0 : 20.0
    }

    var buttonTop: CGFloat {
        if entry.direction == .vertical {
            return 24
        } else {
            return 36
        }
    }

    var buttonLeft: CGFloat {
        if entry.direction == .vertical {
            return 12
        } else {
            return 24
        }
    }

    var buttonRight: CGFloat {
        if entry.direction == .vertical {
            return -8
        } else {
            return -24
        }
    }
}

#if DEBUG

import SwiftUI

@available(iOS 13, *)
struct BaseProtoWebViewControllerPreview: PreviewProvider {
    static var devices = ["iPhone 11 Pro"]

    static var previews: some View {
        ForEach(devices, id: \.self) { deviceName in
            BaseProtoWebViewController(entry: EntryProto()).toPreview().previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}

#endif
