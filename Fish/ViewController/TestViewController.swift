//
//  TestViewController.swift
//  Fish
//
//  Created by yaoyuan on 2021/1/26.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation
import RxSwift
import SCRAttributedStringBuilder
import SwiftUI

class TestViewController: BaseViewController {
    private lazy var jumpView: JumpView = {
        let view = JumpView()
        view.delegate = self
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.font = FishFontUtils.regularPingFangSCFont(size: 13)
        label.textColor = .blue
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.orange.cgColor
        return label
    }()

    private lazy var gradientButton: TTGradientBorderView = {
        let button = TTGradientBorderView()
        button.title = "渐变"
        button.inset = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        button.borderLineWidth = 4
        button.backgroundColors = [.yellow, .red]
        button.borderColors = [.green, .blue]
        button.layer.cornerRadius = 16
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle("Root")
        setupUserInterface()
        hiddenReturnButton = true
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleBackToLessonHomeViewControllerNotification(_:)),
                                               name: NSNotification.Name(rawValue: "TTBackToLessonHomeViewControllerNotification"),
                                               object: nil)
    }
    
    private func setupUserInterface() {
        view.backgroundColor = .white
        view.addSubview(jumpView)
        jumpView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(600)
        }

        view.addSubview(gradientButton)
        gradientButton.snp.makeConstraints { make in
            make.top.equalTo(jumpView.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
}

extension TestViewController: JumpViewDelegate {
    func jumpViewDidPressRotateButton(_ view: JumpView) {
        isLand = !isLand
        switchDeviceToOrientation(orientation: isLand ? .landscapeLeft : .portrait)
    }
    
    func jumpViewDidPressButton(_ view: JumpView, jumpProperty: JumpProperty) {
        let vc = SecondViewController1(title: "1", isPortrait: jumpProperty.isPortrait())
//        JumpUtils.jump(toVC: vc, fromVC: self, jumpProperty: jumpProperty)
        vc.present(in: self, animated: true, completion: nil)
    }
    
    @objc private func handleBackToLessonHomeViewControllerNotification(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: false, completion: nil)
        }
    }
}

class JumpUtils {
    class func jump(toVC: UIViewController, fromVC: UIViewController, jumpProperty: JumpProperty) {
        let forceRotate = UIApplication.shared.statusBarOrientation.isPortrait && !jumpProperty.isPortrait()
            || UIApplication.shared.statusBarOrientation.isLandscape && jumpProperty.isPortrait()
        
        switch jumpProperty {
        case .push_portrait, .push_landscape:
            if forceRotate {
                ToastView.show(hint: "不支持push转屏哦～")
                if jumpProperty == .push_portrait {
                    fromVC.forcePortrait(toVC)
                } else {
                    fromVC.forceLandscape(toVC)
                }
            } else {
                fromVC.navigationController?.pushViewController(toVC, animated: true)
            }
        case .push_portrait_close, .push_landscape_close:
            if forceRotate {
                ToastView.show(hint: "不支持push转屏哦～")
            } else {
                fromVC.pushNextVCAndDismissSelf(toVC, animated: true)
            }
        case .present_portrait:
            fromVC.forcePortrait(toVC)
        case .present_portrait_close:
            fromVC.forcePortraitAndDismissSelf(toVC)
        case .present_landscape:
            fromVC.forceLandscape(toVC)
        case .present_landscape_close:
            fromVC.forceLandscapeAndDismissSelf(toVC)
        }
    }
}

enum JumpProperty {
    case push_portrait
    case push_landscape
    case present_portrait
    case present_landscape
    case push_portrait_close
    case push_landscape_close
    case present_portrait_close
    case present_landscape_close
    
    static func transToType(isPush: Bool, isPortrait: Bool, isClose: Bool) -> JumpProperty {
        if isPush, isPortrait, !isClose {
            return .push_portrait
        } else if isPush, isPortrait, isClose {
            return .push_portrait_close
        } else if !isPush, isPortrait, !isClose {
            return .present_portrait
        } else if !isPush, isPortrait, isClose {
            return .present_portrait_close
        } else if isPush, !isPortrait, !isClose {
            return .push_landscape
        } else if isPush, !isPortrait, isClose {
            return .push_landscape_close
        } else if !isPush, !isPortrait, !isClose {
            return .present_landscape
        } else if !isPush, !isPortrait, isClose {
            return .present_landscape_close
        } else {
            assert(true)
            return .push_portrait
        }
    }
    
    func isPortrait() -> Bool {
        return self == .push_portrait || self == .present_portrait || self == .push_portrait_close || self == .present_portrait_close
    }
    
    func isClose() -> Bool {
        return self == .push_portrait_close || self == .push_landscape_close || self == .present_portrait_close || self == .present_landscape_close
    }
}

protocol JumpViewDelegate: AnyObject {
    func jumpViewDidPressButton(_ view: JumpView, jumpProperty: JumpProperty)
    func jumpViewDidPressRotateButton(_ view: JumpView)
}

class JumpView: UIView {
    private lazy var jumpControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["push", "present"])
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    private lazy var directionControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["portrait", "landScape"])
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    private lazy var closeControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["retain", "close"])
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("jump", for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(.orange), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var rotateButton: UIButton = {
        let button = UIButton()
        button.setTitle("rotate", for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(.orange), for: .normal)
        button.addTarget(self, action: #selector(button2Pressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 10
        return view
    }()
    
    weak var delegate: JumpViewDelegate?
    let isPortrait: Bool
    
    init(isPortrait: Bool = true) {
        self.isPortrait = isPortrait
        super.init(frame: .zero)
        setupUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUserInterface() {
        backgroundColor = .white
        
        addSubview(jumpControl)
        jumpControl.snp.makeConstraints { make in
            if isPortrait {
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(100)
            } else {
                make.leading.equalToSuperview()
                make.top.equalToSuperview().offset(100)
            }
            make.size.equalTo(CGSize(width: 200, height: 50))
        }

        addSubview(directionControl)
        directionControl.snp.makeConstraints { make in
            if isPortrait {
                make.centerX.equalToSuperview()
                make.top.equalTo(jumpControl.snp.bottom).offset(50)
            } else {
                make.leading.equalTo(jumpControl.snp.trailing)
                make.top.equalToSuperview().offset(100)
            }
            make.size.equalTo(CGSize(width: 200, height: 50))
        }

        addSubview(closeControl)
        closeControl.snp.makeConstraints { make in
            if isPortrait {
                make.centerX.equalToSuperview()
                make.top.equalTo(directionControl.snp.bottom).offset(50)
            } else {
                make.leading.equalTo(directionControl.snp.trailing)
                make.top.equalToSuperview().offset(100)
            }
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        stackView.addArrangedSubview(button)
                button.snp.makeConstraints { make in
//                    make.center.equalTo(self)
                    make.size.equalTo(CGSize(width: 200, height: 50))
        //            make.bottom.equalTo(self).offset(-100)
                }
        
        stackView.addArrangedSubview(rotateButton)
        rotateButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 200, height: 50))
//            make.bottom.equalTo(self).offset(-100)
        }
    }
    
    @objc private func buttonPressed() {
        delegate?.jumpViewDidPressButton(
            self,
            jumpProperty: JumpProperty.transToType(
                isPush: jumpControl.selectedSegmentIndex == 0,
                isPortrait: directionControl.selectedSegmentIndex == 0,
                isClose: closeControl.selectedSegmentIndex == 1
            )
        )
    }
    
    @objc private func button2Pressed() {
        delegate?.jumpViewDidPressRotateButton(self)
    }
}
