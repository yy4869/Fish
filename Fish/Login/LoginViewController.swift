//
//  LoginViewController.swift
//  Fish
//
//  Created by yaoyuan on 2020/8/27.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LoginViewController: UIViewController {

    let disposeBag = DisposeBag()

    struct Metric {
        static let buttonHeight: CGFloat = 50
        static let buttonMargin: CGFloat = 20
        static let commonMargin: CGFloat = 16
        static let labelHeight: CGFloat = 30
        static let marginRate: CGFloat = 3
        static let buttonSize: CGFloat = 24
    }
    
    private lazy var topMargin: UILayoutGuide = UILayoutGuide()
    private lazy var bottomMargin: UILayoutGuide = UILayoutGuide()

    // 用户名输入框、以及验证结果显示标签
    private lazy var usernameTextField: BaseTextField = {
        let view = BaseTextField()
        view.placeholder = "用户名"
        return view
    }()

    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    // 密码输入框、以及验证结果显示标签
    private lazy var passwordTextField: BaseTextField = {
        let view = BaseTextField()
        view.placeholder = "密码"
        return view
    }()

    private lazy var passwordValidationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    // 重复密码输入框、以及验证结果显示标签
    private lazy var repeatedPasswordTextField: BaseTextField = {
        let view = BaseTextField()
        view.placeholder = "重复密码"
        return view
    }()

    private lazy var repeatedPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    //注册按钮
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("注册", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.UI_darkMediumColor, for: .disabled)
        button.setBackgroundColor(.UI_orangeColor, for: .normal)
        button.setBackgroundColor(.UI_greyLightColor, for: .disabled)
        button.clipsToBounds = true
        button.layer.cornerRadius = 6
        return button
    }()
    
    private lazy var adminButton: UIButton = {
        let btn = UIButton()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = Metric.buttonSize / 2
        btn.setBackgroundColor(.green, for: .normal)
        btn.setBackgroundColor(UIColor.green.withAlphaComponent(0.5), for: .highlighted)
        btn.addTarget(self, action: #selector(adminButtonPressed(_:)), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "🐟"
        setupUserInterface()
        bind()
        test()
    }

    private func test() {
    }

    private func setupUserInterface() {
        view.backgroundColor = .white

        view.addLayoutGuide(topMargin)
        topMargin.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(FishLayoutUtils.topMargin)
            make.leading.trailing.equalToSuperview()
        }

        view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Metric.commonMargin)
            make.top.equalTo(topMargin.snp.bottom)
            make.height.equalTo(Metric.buttonHeight)
        }

        view.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(usernameTextField)
            make.top.equalTo(usernameTextField.snp.bottom)
            make.height.equalTo(Metric.labelHeight)
        }

        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Metric.commonMargin)
            make.top.equalTo(usernameLabel.snp.bottom).offset(Metric.buttonMargin)
            make.height.equalTo(Metric.buttonHeight)
        }

        view.addSubview(passwordValidationLabel)
        passwordValidationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom)
            make.height.equalTo(Metric.labelHeight)
        }

        view.addSubview(repeatedPasswordTextField)
        repeatedPasswordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Metric.commonMargin)
            make.top.equalTo(passwordValidationLabel.snp.bottom).offset(Metric.buttonMargin)
            make.height.equalTo(Metric.buttonHeight)
        }

        view.addSubview(repeatedPasswordLabel)
        repeatedPasswordLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(repeatedPasswordTextField)
            make.top.equalTo(repeatedPasswordTextField.snp.bottom)
            make.height.equalTo(Metric.labelHeight)
        }

        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Metric.commonMargin)
            make.height.equalTo(Metric.buttonHeight)
            make.top.equalTo(repeatedPasswordLabel.snp.bottom).offset(Metric.buttonMargin)
        }

        view.addLayoutGuide(bottomMargin)
        bottomMargin.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(topMargin.snp.height).multipliedBy(3)
            make.top.equalTo(signUpButton.snp.bottom)
        }
        
        view.addSubview(adminButton)
        adminButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-50)
            make.top.equalToSuperview().offset(50 + FishLayoutUtils.topMargin)
            make.size.equalTo(24)
        }
    }

    private func bind() {
        //初始化ViewModel
        let viewModel = GitHubSignupViewModel(
            input: (
                username: usernameTextField.rx.text.orEmpty.asDriver(),
                password: passwordTextField.rx.text.orEmpty.asDriver(),
                repeatedPassword: repeatedPasswordTextField.rx.text.orEmpty.asDriver(),
                loginTaps: signUpButton.rx.tap.asSignal()
            ),
            dependency: (
                networkService: GitHubNetworkService(),
                signupService: GitHubSignupService()
            )
        )
        
        //用户名验证结果绑定
        viewModel.validatedUsername
            .drive(usernameLabel.rx.validationResult)
            .disposed(by: disposeBag)

        //密码验证结果绑定
        viewModel.validatedPassword
            .drive(passwordValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)

        //再次输入密码验证结果绑定
        viewModel.validatedPasswordRepeated
            .drive(repeatedPasswordLabel.rx.validationResult)
            .disposed(by: disposeBag)

        //注册按钮是否可用
        viewModel.signupEnabled
            .drive(onNext: { [weak self] valid  in
                self?.signUpButton.isEnabled = valid
                self?.signUpButton.alpha = valid ? 1.0 : 0.3
            })
            .disposed(by: disposeBag)

        //注册结果绑定
        viewModel.signupResult
            .drive(onNext: { [unowned self] success in
                self.showMessage("注册" + (success ? "成功" : "失败") + "!")
                if success {
                    self.dismissLoginView()
                }
            })
            .disposed(by: disposeBag)
    }

    //详细提示框
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func dismissLoginView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func adminButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil,
                                                message: "主人，你来啦～",
                                                preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "确定", style: .default) { _ in
            let success = alertController.textFields?.first?.text == "4869"
            ToastView.show(hint: success ? "起飞～" : "不对👁")
            if success {
                self.dismissLoginView()
            }
        }
        alertController.addAction(confirmAction)
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alertController.addTextField { textField in
            textField.placeholder = "验明真身"
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
}
