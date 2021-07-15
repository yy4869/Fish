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

class SecondViewController2: BaseViewController {
    private var count = 0

    private let disposeBag = DisposeBag()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("click me", for: .normal)
        return button
    }()

    private let titleStr: String
    init(title: String = "") {
        self.titleStr = title
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("test 2 deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleStr)
        setupUserInterface()
        transform()
        setupNotification()
    }

    func setupNotification() {
        [
            (Notification.Name.dismiss2, #selector(returnButtonPressed(_:))),
        ].forEach {
            NotificationCenter.default.addObserver(self, selector: $0.1, name: $0.0, object: nil)
        }
    }

    private func setupUserInterface() {
        view.backgroundColor = .gray
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.size.equalTo(100)
            make.bottom.equalTo(view).offset(-100)
        }
    }

    private func transform() {
        button.rx.tap.subscribe(onNext: { [weak self] in
            let vc = SecondViewController3(title: "push 3")
//            vc.enablePrintLifeCycle = true
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
}

class SecondViewController3: BaseViewController {
    private var count = 0

    private let disposeBag = DisposeBag()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("click me", for: .normal)
        return button
    }()

    private let titleStr: String
    init(title: String = "") {
        self.titleStr = title
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("test 3 deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleStr)
        setupUserInterface()
        transform()
        setupNotification()
    }

    func setupNotification() {
        [
            (Notification.Name.dismiss3, #selector(returnButtonPressed(_:))),
        ].forEach {
            NotificationCenter.default.addObserver(self, selector: $0.1, name: $0.0, object: nil)
        }
    }

    private func setupUserInterface() {
        view.backgroundColor = .gray
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.size.equalTo(100)
            make.bottom.equalTo(view).offset(-100)
        }
    }

    private func transform() {
        button.rx.tap.subscribe(onNext: { [weak self] in
            guard let sself = self else { return }
            let vc = SecondViewController4(title: "present 4")
//            sself.forcePortrait(vc)
            sself.forcePortraitAndDismissSelf(vc)
        }).disposed(by: disposeBag)
    }
}

class SecondViewController4: BaseViewController {
    private var count = 0

    private let disposeBag = DisposeBag()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("click me", for: .normal)
        return button
    }()

    private let titleStr: String
    init(title: String = "") {
        self.titleStr = title
        super.init(nibName: nil, bundle: nil)
//        enableRotate = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleStr)
        setupUserInterface()
        transform()
        setupNotification()


//        switchDeviceToOrientation(orientation: .landscapeLeft)
    }

    func setupNotification() {
        [
            (Notification.Name.dismiss4, #selector(returnButtonPressed(_:))),
        ].forEach {
            NotificationCenter.default.addObserver(self, selector: $0.1, name: $0.0, object: nil)
        }
    }
    
    override func returnButtonPressed(_ sender: UIControl) {
        super.returnButtonPressed(sender)
    }

    private func setupUserInterface() {
        view.backgroundColor = .gray
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.size.equalTo(100)
            make.bottom.equalTo(view).offset(-100)
        }
    }

    private func transform() {
        button.rx.tap.subscribe(onNext: { [weak self] in
            let vc = SecondViewController5(title: "push 5")
            self?.pushNextVCAndDismissSelf(vc, animated: true)
//            self?.navigationController?.pushViewController(vc, animated: true)
//            self?.presentNavigationControllerWrappedViewController(SecondViewController5(title: "push 5"))
        }).disposed(by: disposeBag)
    }
}

// MARK: Utils
private extension SecondViewController4 {
    func switchDeviceToOrientation(orientation: UIDeviceOrientation) {
        if UIDevice.current.orientation != orientation {
            UIView.performWithoutAnimation {
                UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
            }
//            UIView.setAnimationsEnabled(false)
        }
    }
}

class SecondViewController5: BaseViewController {
    private var count = 0

    private let disposeBag = DisposeBag()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("click me", for: .normal)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 6
        view.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        return view
    }()

    private let titleStr: String
    init(title: String = "") {
        titleStr = title
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleStr)
        setupUserInterface()
        transform()
        setupNotification()
    }

    func setupNotification() {
        [
            (Notification.Name.dismiss5, #selector(returnButtonPressed(_:))),
        ].forEach {
            NotificationCenter.default.addObserver(self, selector: $0.1, name: $0.0, object: nil)
        }
    }
        
    private func setupUserInterface() {
        view.backgroundColor = .gray
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.size.equalTo(100)
            make.bottom.equalTo(view).offset(-100)
        }

        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(520)
        }

        let dismissButton = UIButton()
        dismissButton.setTitle("root", for: .normal)
        dismissButton.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        dismissButton.addTarget(self, action: #selector(sendDismiss), for: .touchUpInside)

        let dismissButton2 = UIButton()
        dismissButton2.setTitle("2", for: .normal)
        dismissButton2.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        dismissButton2.addTarget(self, action: #selector(sendDismiss2), for: .touchUpInside)

        let dismissButton3 = UIButton()
        dismissButton3.setTitle("3", for: .normal)
        dismissButton3.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        dismissButton3.addTarget(self, action: #selector(sendDismiss3), for: .touchUpInside)

        let dismissButton4 = UIButton()
        dismissButton4.setTitle("4", for: .normal)
        dismissButton4.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        dismissButton4.addTarget(self, action: #selector(sendDismiss4), for: .touchUpInside)

        let dismissButton5 = UIButton()
        dismissButton5.setTitle("5", for: .normal)
        dismissButton5.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        dismissButton5.addTarget(self, action: #selector(sendDismiss5), for: .touchUpInside)

        stackView.addArrangedSubview(dismissButton)
        stackView.addArrangedSubview(dismissButton2)
        stackView.addArrangedSubview(dismissButton3)
        stackView.addArrangedSubview(dismissButton4)
        stackView.addArrangedSubview(dismissButton5)
    }

    private func transform() {
        button.rx.tap.subscribe(onNext: { [weak self] in
//            let vc = SecondViewController6(title: "present 6")
//            vc.modalPresentationStyle = .overFullScreen
//            self?.present(vc, animated: true, completion: nil)
//            self?.presentNavigationControllerWrappedViewController(SecondViewController6(title: "push 6"))
            self?.navigationController?.pushViewController(SecondViewController6(title: "push 6"), animated: true)
        }).disposed(by: disposeBag)
    }
}

class SecondViewController6: BaseViewController {
    private var count = 0

    private let disposeBag = DisposeBag()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("click me", for: .normal)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 6
        view.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        return view
    }()

    private let titleStr: String
    init(title: String = "") {
        titleStr = title
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleStr)
        setupUserInterface()
        transform()
        setupNotification()
    }

    func setupNotification() {
        [
            (Notification.Name.dismiss6, #selector(returnButtonPressed(_:))),
        ].forEach {
            NotificationCenter.default.addObserver(self, selector: $0.1, name: $0.0, object: nil)
        }
    }

    private func setupUserInterface() {
        view.backgroundColor = .gray
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.size.equalTo(100)
            make.bottom.equalTo(view).offset(-100)
        }
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(520)
        }

        let dismissButton = UIButton()
        dismissButton.setTitle("root", for: .normal)
        dismissButton.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        dismissButton.addTarget(self, action: #selector(sendDismiss), for: .touchUpInside)

        let dismissButton2 = UIButton()
        dismissButton2.setTitle("2", for: .normal)
        dismissButton2.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        dismissButton2.addTarget(self, action: #selector(sendDismiss2), for: .touchUpInside)

        let dismissButton3 = UIButton()
        dismissButton3.setTitle("3", for: .normal)
        dismissButton3.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        dismissButton3.addTarget(self, action: #selector(sendDismiss3), for: .touchUpInside)

        let dismissButton4 = UIButton()
        dismissButton4.setTitle("4", for: .normal)
        dismissButton4.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        dismissButton4.addTarget(self, action: #selector(sendDismiss4), for: .touchUpInside)

        let dismissButton5 = UIButton()
        dismissButton5.setTitle("5", for: .normal)
        dismissButton5.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        dismissButton5.addTarget(self, action: #selector(sendDismiss5), for: .touchUpInside)

        let dismissButton6 = UIButton()
        dismissButton6.setTitle("6", for: .normal)
        dismissButton6.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        dismissButton6.addTarget(self, action: #selector(sendDismiss6), for: .touchUpInside)

        stackView.addArrangedSubview(dismissButton)
        stackView.addArrangedSubview(dismissButton2)
        stackView.addArrangedSubview(dismissButton3)
        stackView.addArrangedSubview(dismissButton4)
        stackView.addArrangedSubview(dismissButton5)
        stackView.addArrangedSubview(dismissButton6)
    }

    private func transform() {
        button.rx.tap.subscribe(onNext: { [weak self] in
            // 没法再来 push 了，因为 navigationController 不存在了
//            self?.navigationController?.pushViewController(SecondViewController7(title: "push 7"), animated: true)
//            self?.presentNavigationControllerWrappedViewController(SecondViewController7(title: "push 7"))
//            self?.navigationController?.pushViewController(SecondViewController7(title: "push 7"), animated: true)
        }).disposed(by: disposeBag)
    }

    
}

func push(from viewController: UIViewController, to vc: UIViewController) {
    let transition = CATransition()
    transition.duration = 0.4
    transition.type = .moveIn
    transition.subtype = .fromTop
    viewController.navigationController?.view.layer.add(transition, forKey: kCATransition)
    viewController.navigationController?.pushViewController(vc, animated: false)
}

func pop(from viewController: UIViewController) {
    let transition = CATransition()
    transition.duration = 0.4
    transition.type = .reveal
    transition.subtype = .fromBottom
    viewController.navigationController?.view.layer.add(transition, forKey: kCATransition)
    viewController.navigationController?.popViewController(animated: false)
}
