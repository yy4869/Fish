//
//  MainTimeLineViewController.swift
//  Fish
//
//  Created by 媛小仙女 on 2020/9/2.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import UIKit

class MainTimeLineViewController: BaseViewController {

    private lazy var addMoreButton: BaseButton = {
        let button = BaseButton()
        button.setBackgroundImage(UIImage(named: "PlusCircle"), for: .normal)
        button.addTarget(self, action: #selector(addMoreButtonPressed(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var toolsBar: FishToolBarStackView = {
        let view = FishToolBarStackView()
        view.delegate = self
        return view
    }()

    private lazy var noteButton: BaseCornerRadiusButton = {
        let button = BaseCornerRadiusButton()
        button.backgroundColor = .gray
        button.setTitle("笔记", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNavigationBar = true
        setupUserInterface()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        showLoginView()
    }

    private func setupUserInterface() {
        view.addSubview(addMoreButton)
        addMoreButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
        }

        view.addSubview(noteButton)
        noteButton.snp.makeConstraints { make in
            make.leading.top.equalTo(headerView).offset(16)
            make.size.equalTo(CGSize(width: 80, height: 36))
        }

        view.addSubview(toolsBar)
        toolsBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Metric.horizonMargin)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(Metric.buttonHeight)
        }
    }

    private func showLoginView() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }

    @objc private func addMoreButtonPressed(_ sender: UIButton) {
        hiddenNavigationBar = !hiddenNavigationBar
    }
}

extension MainTimeLineViewController: FishToolBarStackViewDelegate {
    func toolBarStackView(_ view: FishToolBarStackView, didPressButton type: FishToolType) {
        FishPrint("press \(type.desc())")
    }
}
