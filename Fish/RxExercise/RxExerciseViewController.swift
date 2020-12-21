//
//  RxExerciseViewController.swift
//  Fish
//
//  Created by yaoyuan on 2020/12/3.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RxExerciseViewController: BaseViewController {
    let disposeBag = DisposeBag()

    private lazy var textField1: BaseTextField = {
        let view = BaseTextField()
        view.placeholder = "username"
        return view
    }()

    private lazy var textField2: BaseTextField = {
        let view = BaseTextField()
        view.placeholder = "password"
        return view
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("submit", for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.setTitleColor(.orange, for: .normal)
        button.isEnabled = false
        button.backgroundColor = .blue
        return button
    }()

    private lazy var segmentView: UISegmentedControl = {
        let view = UISegmentedControl()
        view.insertSegment(withTitle: "first", at: 1, animated: true)
        view.insertSegment(withTitle: "second", at: 2, animated: true)
        view.insertSegment(withTitle: "third", at: 3, animated: true)
        view.selectedSegmentTintColor = .orange
        return view
    }()

    private lazy var mySwitch: UISwitch = {
        let view = UISwitch()
        view.onTintColor = .blue
        return view
    }()

    private lazy var indicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView()
    }()

    private lazy var mySlider: UISlider = {
        let view = UISlider()
        return view
    }()

    private lazy var myStepper: UIStepper = {
        let view = UIStepper()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNavigationBar = false
        setupUserInterface()
        transform()
    }

    private func setupUserInterface() {
        view.backgroundColor = .white

        view.addSubview(segmentView)
        segmentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.height.equalTo(50)
        }

        view.addSubview(mySwitch)
        mySwitch.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.top.equalTo(segmentView.snp.bottom).offset(10)
        }

        view.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.leading.equalTo(mySwitch.snp.trailing).offset(50)
            make.centerY.equalTo(mySwitch)
        }

        view.addSubview(mySlider)
        mySlider.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.top.equalTo(mySwitch.snp.bottom).offset(50)
            make.width.equalTo(200)
        }

        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalTo(mySlider.snp.trailing).offset(50)
            make.centerY.equalTo(mySlider)
        }

        view.addSubview(myStepper)
        myStepper.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.top.equalTo(mySlider.snp.bottom).offset(50)
            make.width.equalTo(200)
        }

    }

    private func transform() {
        mySwitch.rx.isOn.bind(to: indicator.rx.isAnimating).disposed(by: disposeBag)
//        myStepper.rx.value.debug().map { Float($0 / 10) }.bind(to: mySlider.rx.value).disposed(by: disposeBag)
//        mySlider.rx.value.debug().map {
//            "当前:" + String(format: "%.2f", $0)
//        }.bind(to: label.rx.text).disposed(by: disposeBag)

        
    }
}
