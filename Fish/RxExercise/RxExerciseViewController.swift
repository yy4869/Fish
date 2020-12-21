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
import SCRAttributedStringBuilder

enum StackViewOptionType {
    case distribution
    case alignment
}

class RxExerciseViewController: BaseViewController {
    private lazy var distributionStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 10
        return view
    }()

    private lazy var alignmentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 10
        return view
    }()

    private lazy var stackViewLabel: UILabel = {
        let label = UILabel()
        label.text = "distribution: , alignment:"
        return label
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 40
        return view
    }()

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


    let disposeBag = DisposeBag()
    let distributionArray = [("fill", "fill"), ("fillE", "fillEqually"), ("fillP", "fillProportionally"), ("equalS", "equalSpacing"), ("equalC", "equalCentering")]
    let alignmentArray = [("fill", "fill"), ("lead", "leading"), ("firstB", "firstBaseline"), ("center", "center"), ("trail", "trailing"), ("lastB", "lastBaseline")]
    private var distributionName: String = "" {
        didSet {
            stackViewLabel.text = "distribution: \(distributionName), alignment: \(alignmentName)"
        }
    }
    private var alignmentName: String = "" {
        didSet {
            stackViewLabel.text = "distribution: \(distributionName), alignment: \(alignmentName)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNavigationBar = false
        setupUserInterface()
        transform()
    }

    private func setupUserInterface() {
        view.backgroundColor = .white

//        view.addSubview(stackView)
//        stackView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalToSuperview().offset(300)
//            make.bottom.equalToSuperview().offset(-100)
//        }
//
//        stackView.addArrangedSubview(textField1)
//        stackView.addArrangedSubview(textField2)
//        stackView.addArrangedSubview(button)
//
//        textField1.snp.makeConstraints { make in
//            make.width.equalTo(200)
//            make.height.equalTo(50)
//        }
//
//        textField2.snp.makeConstraints { make in
//            make.width.equalTo(200)
//            make.height.equalTo(50)
//        }
//
//        button.snp.makeConstraints { make in
//            make.width.equalTo(80)
//            make.height.equalTo(40)
//        }
//
//        view.addSubview(distributionStackView)
//        distributionStackView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(headerView.snp.bottom).offset(10)
//            make.height.equalTo(50)
//        }
//
//        view.addSubview(alignmentStackView)
//        alignmentStackView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(distributionStackView.snp.bottom).offset(10)
//            make.height.equalTo(50)
//        }
//
//        for (index, typeName) in distributionArray.enumerated() {
//            distributionStackView.addArrangedSubview(getOptionButton(name: typeName, typeIndex: index, type: .distribution))
//        }
//
//        for (index, typeName) in alignmentArray.enumerated() {
//            alignmentStackView.addArrangedSubview(getOptionButton(name: typeName, typeIndex: index, type: .alignment))
//        }
//
//        view.addSubview(stackViewLabel)
//        stackViewLabel.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(alignmentStackView.snp.bottom).offset(10)
//        }

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

    private func getOptionButton(name: (String, String), typeIndex: Int, type: StackViewOptionType) -> UIButton {
        let button = BaseButton()
        button.setBackgroundColor(type == .distribution ? .UI_noteColor : .UI_taskColor, for: .normal)
        button.setTitle(name.0, for: .normal)
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.rx.tap.subscribe(onNext: { [weak self] _ in
            if type == .distribution {
                self?.stackView.distribution = UIStackView.Distribution.init(rawValue: typeIndex) ?? .equalCentering
                self?.distributionName = name.1
            } else {
                self?.stackView.alignment = UIStackView.Alignment.init(rawValue: typeIndex) ?? .center
                self?.alignmentName = name.1
            }
        }).disposed(by: disposeBag)

        return button
    }

    private func transform() {
//        textField.rx.text.bind(to: label.rx.text).disposed(by: disposeBag)

//        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
//        timer.map(formatTimeInterval(ms:)).bind(to: label.rx.attributedText).disposed(by: disposeBag)

//        let input = textField1.rx.text.orEmpty.asDriver().throttle(0.3)
//        input.map { "count: \($0.count)" }.drive(label.rx.text).disposed(by: disposeBag)
//        input.map { $0.count > 5 }.drive(button.rx.isEnabled).disposed(by: disposeBag)
//        button.rx.tap.subscribe(onNext: {
//            ToastView.show(hint: "submit button pressed")
//        }).disposed(by: disposeBag)

//        Observable.combineLatest(textField1.rx.text.orEmpty, textField2.rx.text.orEmpty) {
//            "号码：\($0) - \($1)"
//        }.bind(to: label.rx.text).disposed(by: disposeBag)

//        textField1.rx.controlEvent(.editingDidBegin).subscribe({_ in
//            print("textField1 editingDidBegin")
//        }).disposed(by: disposeBag)
//
//        textField1.rx.controlEvent(.editingDidEndOnExit).subscribe({ [weak self] event in
//            self?.textField2.becomeFirstResponder()
//        }).disposed(by: disposeBag)
//
//        textField2.rx.controlEvent(.editingDidEndOnExit).subscribe({ [weak self] event in
//            self?.textField2.resignFirstResponder()
//        }).disposed(by: disposeBag)

//        updateButtonUI(stackView: distributionStackView)
//        updateButtonUI(stackView: alignmentStackView)



//        let selectedSegment = segmentView.rx.selectedSegmentIndex.asObservable().map {
//            "选中 \($0)"
//        }
//        selectedSegment.bind(to: label.rx.text).disposed(by: disposeBag)
        mySwitch.rx.isOn.bind(to: indicator.rx.isAnimating).disposed(by: disposeBag)
//        myStepper.rx.value.debug().map { Float($0 / 10) }.bind(to: mySlider.rx.value).disposed(by: disposeBag)
//        mySlider.rx.value.debug().map {
//            "当前:" + String(format: "%.2f", $0)
//        }.bind(to: label.rx.text).disposed(by: disposeBag)

        
    }

    private func updateButtonUI(stackView: UIStackView) {
        guard let buttons = stackView.arrangedSubviews as? [UIButton] else { return }
        let selectedButton = Observable.from(
            buttons
                .map { button in
                button.rx.tap.map { button }
            }
        ).merge()
        for button in buttons {
            selectedButton.map { $0 == button }.bind(to: button.rx.isSelected).disposed(by: disposeBag)
        }
    }

    func formatTimeInterval(ms: Int) -> NSAttributedString {
        let string = String(format: "%02d:%02d.%02d", (ms / 600) % 600, (ms / 60 ) % 60, ms % 60)
        let attributedStr = AttributedStringBuilder.build { builder in
            builder.append(string)
                .color(.orange)
                .font(UIFont.systemFont(ofSize: 14).monospacedDigitFont())
                .lineHeight(17)
                .alignment(.justified)
        }
        return attributedStr
    }
}
