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
    var enablePrintLifeCycle: Bool = false
    var enableRotate: Bool = false
    var delayClose = false
    var isLand: Bool = false
    
    typealias BackAlert = () -> Void
    var backButtonTapAlert: BackAlert?

    struct Metric {
        static let navigationBarHeight: CGFloat = 44
        static let horizonMargin: CGFloat = 16
        static let buttonHeight: CGFloat = 36
    }

    lazy var headerView: UIView = {
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

    private lazy var returnButton: BaseButton = {
        let button = BaseButton()
        button.imageView?.contentMode = .center
        button.setImage(UIImage(named: "TTNavigationBarBack"), for: .normal)
        button.addTarget(self, action: #selector(returnButtonPressed(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var rightButton: BaseButton = {
        let button = BaseButton()
        button.imageView?.contentMode = .center
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 隐藏系统自带导航栏，如果需要，使用自定义导航栏
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .UI_whiteBackgroundColor
        setTitle("🐟")
        setupNavigationBar()

        printLifeCycle(#function)
    }

    deinit {
        FishPrint("\(self.classForCoder) deinit")
    }

    func dismissSelf() {
        FishPrint("\(self.classForCoder) return")
        isLand = false
        switchDeviceToOrientation(orientation: .portrait)
        let array = navigationController?.viewControllers
        if array?.count ?? 0 > 0 {
            if self == array?.first {
                if let presentingVC = presentingViewController as? UINavigationController,
                   presentingVC.viewControllers.count == 0 {
                    presentingVC.presentingViewController?.dismiss(animated: true) { [weak self] in
                        self?.backButtonTapAlert?()
                    }
                    return
                }
                presentingViewController?.dismiss(animated: true) { [weak self] in
                    self?.backButtonTapAlert?()
                }
            } else {
                navigationController?.popViewController(animated: true)
            }
        } else {
            dismiss(animated: true) { [weak self] in
                self?.backButtonTapAlert?()
            }
        }
    }

    @objc public func returnButtonPressed(_ sender: UIControl) {
        dismissSelf()
    }
    
    func goBackToHome() {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "TTBackToLessonHomeViewControllerNotification"),
            object: self
        )
    }
    
    private func setupNavigationBar() {
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(Metric.navigationBarHeight)
        }

        headerView.addSubview(headerShadowView)
        headerShadowView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(headerView)
            make.height.equalTo(0.5)
        }

        headerView.addSubview(returnButton)
        returnButton.snp.makeConstraints { make in
            make.centerX.equalTo(headerView.snp.leading).offset(24)
            make.width.height.equalTo(Metric.navigationBarHeight)
            make.centerY.equalTo(headerView)
        }

        headerView.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.trailing.equalTo(headerView).offset(-2)
            make.width.height.greaterThanOrEqualTo(Metric.navigationBarHeight)
            make.centerY.equalTo(headerView)
        }

        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(headerView)
            make.leading.greaterThanOrEqualTo(returnButton.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(rightButton.snp.leading).offset(-10)
        }
        rightButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        rightButton.setContentHuggingPriority(.required, for: .horizontal)
    }

    /// 是否隐藏导航栏
    var hiddenNavigationBar = true {
        didSet {
            headerView.isHidden = hiddenNavigationBar
            headerView.snp.updateConstraints { make in
                make.height.equalTo(hiddenNavigationBar ? 0 : Metric.navigationBarHeight)
            }
        }
    }
    
    /// 是否隐藏导航栏
    var hiddenReturnButton = false {
        didSet {
            returnButton.isHidden = hiddenReturnButton
        }
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}

extension BaseViewController {
    private func printLifeCycle(_ message: String) {
        guard enablePrintLifeCycle else { return }
        FishPrint("\(self.classForCoder) \(message)")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        printLifeCycle(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printLifeCycle(#function)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        printLifeCycle(#function)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        printLifeCycle(#function)
    }
}

extension BaseViewController {
    func switchDeviceToOrientation(orientation: UIDeviceOrientation) {
        UIDevice.current.setValue(UIDeviceOrientation.unknown.rawValue, forKey: "orientation")
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
    }
}

extension BaseViewController {
    override open var shouldAutorotate: Bool {
        true
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .all
    }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .portrait
    }    
}
