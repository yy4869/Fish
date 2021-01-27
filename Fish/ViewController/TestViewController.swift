//
//  TestViewController.swift
//  Fish
//
//  Created by yaoyuan on 2021/1/26.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation
import RxSwift

class TestViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("click me", for: .normal)
        return button
    }()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        transform()
    }

    private func setupUserInterface() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.size.equalTo(100)
        }
    }

    private func transform() {
        button.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.pushViewController(MainTimeLineViewController(), animated: true)
        }).disposed(by: disposeBag)
        
    }
}
