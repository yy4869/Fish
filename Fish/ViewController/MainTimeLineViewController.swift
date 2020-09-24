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

    private lazy var timeDashLine: DashLine = {
        let view = DashLine(lineColor: .UI_greyColor, isVertical: true, lineDash: 4, margin: 4)
        return view
    }()

    private lazy var searchButton: BaseCornerRadiusButton = {
        let button = BaseCornerRadiusButton()
        button.setBackgroundColor(.UI_greyLightColor, for: .normal)
        button.setTitle("🔍", for: .normal)
        return button
    }()

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

        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.leading.top.equalTo(headerView).offset(16)
            make.size.equalTo(40)
        }

        view.addSubview(timeDashLine)
        timeDashLine.snp.makeConstraints { make in
            make.centerX.top.bottom.equalToSuperview()
            make.width.equalTo(4)
        }

        view.addSubview(toolsBar)
        toolsBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Metric.horizonMargin)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(30)
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
