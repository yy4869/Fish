//
//  SecondViewController.swift
//  Fish
//
//  Created by yaoyuan on 2021/1/26.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation
import RxSwift
import SCRAttributedStringBuilder

class SecondViewController1: BaseViewController, JumpViewDelegate {

    private let titleStr: String
    private let isPortrait: Bool
    
    private lazy var jumpView: JumpView = {
        let view = JumpView(isPortrait: isPortrait)
        view.delegate = self
        return view
    }()
    
    init(title: String = "", isPortrait: Bool = false) {
        self.titleStr = title
        self.isPortrait = isPortrait
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleStr)
        setupUserInterface()
    }

    private func setupUserInterface() {
        view.backgroundColor = .white
        
        view.addSubview(jumpView)
        jumpView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
    func jumpViewDidPressButton(_ view: JumpView, jumpProperty: JumpProperty) {
        let vc = SecondViewController2(title: "2", isPortrait: jumpProperty.isPortrait())
        JumpUtils.jump(toVC: vc, fromVC: self, jumpProperty: jumpProperty)
    }
    
    func jumpViewDidPressRotateButton(_ view: JumpView) {
        isLand = !isLand
        switchDeviceToOrientation(orientation: isLand ? .landscapeLeft : .portrait)
    }
}

class SecondViewController2: BaseViewController, JumpViewDelegate {

    private let titleStr: String
    private let isPortrait: Bool
    
    private lazy var jumpView: JumpView = {
        let view = JumpView(isPortrait: isPortrait)
        view.delegate = self
        return view
    }()
    
    init(title: String = "", isPortrait: Bool = false) {
        self.titleStr = title
        self.isPortrait = isPortrait
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleStr)
        setupUserInterface()
    }

    private func setupUserInterface() {
        view.backgroundColor = .white
        
        view.addSubview(jumpView)
        jumpView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
    func jumpViewDidPressButton(_ view: JumpView, jumpProperty: JumpProperty) {
        let vc = SecondViewController3(title: "3", isPortrait: jumpProperty.isPortrait())
        JumpUtils.jump(toVC: vc, fromVC: self, jumpProperty: jumpProperty)
    }
    
    func jumpViewDidPressRotateButton(_ view: JumpView) {
        isLand = !isLand
        switchDeviceToOrientation(orientation: isLand ? .landscapeLeft : .portrait)
    }
}

class SecondViewController3: BaseViewController, JumpViewDelegate {

    private let titleStr: String
    private let isPortrait: Bool
    
    private lazy var jumpView: JumpView = {
        let view = JumpView(isPortrait: isPortrait)
        view.delegate = self
        return view
    }()
    
    init(title: String = "", isPortrait: Bool = false) {
        self.titleStr = title
        self.isPortrait = isPortrait
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleStr)
        setupUserInterface()
    }

    private func setupUserInterface() {
        view.backgroundColor = .white
        
        view.addSubview(jumpView)
        jumpView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
    func jumpViewDidPressButton(_ view: JumpView, jumpProperty: JumpProperty) {
        let vc = SecondViewController4(title: "4", isPortrait: jumpProperty.isPortrait())
        JumpUtils.jump(toVC: vc, fromVC: self, jumpProperty: jumpProperty)
    }
    
    func jumpViewDidPressRotateButton(_ view: JumpView) {
        isLand = !isLand
        switchDeviceToOrientation(orientation: isLand ? .landscapeLeft : .portrait)
    }
}

class SecondViewController4: BaseViewController, JumpViewDelegate {

    private let titleStr: String
    private let isPortrait: Bool
    
    private lazy var jumpView: JumpView = {
        let view = JumpView(isPortrait: isPortrait)
        view.delegate = self
        return view
    }()
    
    init(title: String = "", isPortrait: Bool = false) {
        self.titleStr = title
        self.isPortrait = isPortrait
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleStr)
        setupUserInterface()
    }

    private func setupUserInterface() {
        view.backgroundColor = .white
        
        view.addSubview(jumpView)
        jumpView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
    func jumpViewDidPressButton(_ view: JumpView, jumpProperty: JumpProperty) {
        ToastView.show(hint: "结束了哦～")
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "TTBackToLessonHomeViewControllerNotification"),
            object: self
        )
    }
    
    func jumpViewDidPressRotateButton(_ view: JumpView) {
        isLand = !isLand
        switchDeviceToOrientation(orientation: isLand ? .landscapeLeft : .portrait)
    }
}
