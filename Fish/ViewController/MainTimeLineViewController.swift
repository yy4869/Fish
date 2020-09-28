//
//  MainTimeLineViewController.swift
//  Fish
//
//  Created by 媛小仙女 on 2020/9/2.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

public typealias TTPermissionCallback = () -> Void

class MainTimeLineViewController: BaseViewController {

    private var countTime = 0

    struct Constant {
        static let taskHeight: CGFloat = 100
        static let taskMargin: CGFloat = 32
    }

    private lazy var timeDashLine: DashLine = {
        let view = DashLine(lineColor: .UI_greyColor, isVertical: true, lineDash: 4, margin: 4)
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()

    private lazy var taskContainerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = Constant.taskMargin
        view.alignment = .fill
        return view
    }()

    private lazy var searchButton: BaseCornerRadiusButton = {
        let button = BaseCornerRadiusButton()
        button.setBackgroundColor(.UI_greyLightColor, for: .normal)
        button.setTitle("🔍", for: .normal)
        button.addTarget(self, action: #selector(clearData(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var addMoreButton: BaseButton = {
        let button = BaseButton()
        button.setBackgroundImage(UIImage(named: "PlusCircle"), for: .normal)
        button.hitOffset = UIEdgeInsets(top: -10, left: -10, bottom: -20, right: -20)
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
        view.addSubview(timeDashLine)
        timeDashLine.snp.makeConstraints { make in
            make.centerX.top.bottom.equalToSuperview()
            make.width.equalTo(2)
        }

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        scrollView.addSubview(taskContainerView)
        taskContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(16)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView).priorityLow()
            make.height.equalTo(0)
        }
        scrollView.contentInset = UIEdgeInsets(top: FishLayoutUtils.topMargin, left: 0, bottom: FishLayoutUtils.bottomPadding, right: 0)

        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.leading.top.equalTo(headerView).offset(16)
            make.size.equalTo(40)
        }

        view.addSubview(addMoreButton)
        addMoreButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
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
        countTime += 1
        let height = (CGFloat)(countTime) * (Constant.taskHeight + Constant.taskMargin) - Constant.taskMargin
        let view = FishTimeLineTaskView(type: FishToolType(rawValue: (countTime - 1) % 4) ?? .diary)
        taskContainerView.addArrangedSubview(view)
        taskContainerView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
    }

    @objc private func clearData(_ sender: UIButton) {
        for view in taskContainerView.arrangedSubviews {
            taskContainerView.removeArrangedSubview(view)
        }
        countTime = 0
        taskContainerView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
    }

    @objc private func taskItemPressed(_ sender: UIControl) {
        FishPrint("press task")
    }
}

extension MainTimeLineViewController: FishToolBarStackViewDelegate {
    func toolBarStackView(_ view: FishToolBarStackView, didPressButton type: FishToolType) {
        FishPrint("press \(type.desc())")
    }
}
