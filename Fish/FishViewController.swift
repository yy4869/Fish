//
//  FishViewController.swift
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

class FishViewController: UIViewController {

    private lazy var topMargin: UILayoutGuide = UILayoutGuide()
    private lazy var bottomMargin: UILayoutGuide = UILayoutGuide()

    // 用户名输入框、以及验证结果显示标签
    private lazy var usernameTextField: YYTextField = {
        let view = YYTextField()
        view.placeholder = "用户名"
        return view
    }()

    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    // 密码输入框、以及验证结果显示标签
    private lazy var passwordTextField: YYTextField = {
        let view = YYTextField()
        view.placeholder = "密码"
        return view
    }()

    private lazy var passwordValidationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    // 重复密码输入框、以及验证结果显示标签
    private lazy var repeatedPasswordTextField: YYTextField = {
        let view = YYTextField()
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
        button.setBackgroundColor(.UI_orangeColor, forState: .normal)
        button.setBackgroundColor(.UI_greyLightColor, forState: .disabled)
        button.clipsToBounds = true
        button.layer.cornerRadius = 6
        return button
    }()

    let disposeBag = DisposeBag()

    struct Metric {
        static let buttonHeight: CGFloat = 50
        static let buttonMargin: CGFloat = 20
        static let commonMargin: CGFloat = 16
        static let labelHeight: CGFloat = 30
        static let marginRate: CGFloat = 3
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "🐟"
        setupUserInterface()
        bind()
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
            .drive(onNext: { [unowned self] result in
                self.showMessage("注册" + (result ? "成功" : "失败") + "!")
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
}
