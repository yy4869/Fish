//
//  TestViewController.swift
//  Fish
//
//  Created by yaoyuan on 2021/1/26.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation
import RxSwift
//import SDWebImage
import SCRAttributedStringBuilder
import SwiftUI

class TestViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("click me", for: .normal)
        return button
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        transform()
    }

    private func setupUserInterface() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(100)
            make.size.equalTo(300)
        }

        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.size.equalTo(100)
            make.bottom.equalTo(view).offset(-100)
        }

        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }

    private func transform() {
        button.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.pushViewController(SecondViewController(title: "push 2"), animated: true)
        }).disposed(by: disposeBag)
    }
}

