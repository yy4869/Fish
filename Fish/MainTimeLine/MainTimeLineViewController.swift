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

class MainTimeLineViewController: BaseViewController {

    struct Constant {
        static let taskHeight: CGFloat = 100
        static let taskMargin: CGFloat = 32
    }

    private lazy var timeDashLine: DashLine = {
        let view = DashLine(lineColor: .UI_greyColor, isVertical: true, lineDash: 4, margin: 4)
        return view
    }()

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.register(MainTimeLineTableCell.self, forCellReuseIdentifier: MainTimeLineTableCell.reuseIdentifier)
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

    private lazy var dataController: MainTimeLineDataController = {
        let dc = MainTimeLineDataController()
        return dc
    }()

    private lazy var debugButton: BaseCornerRadiusButton = {
        let button = BaseCornerRadiusButton()
        button.setBackgroundColor(.UI_greyLightColor, for: .normal)
        button.setTitle("🐞", for: .normal)
        button.addTarget(self, action: #selector(debugButtonPressed(_:)), for: .touchUpInside)
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
        view.addSubview(timeDashLine)
        timeDashLine.snp.makeConstraints { make in
            make.centerX.top.bottom.equalToSuperview()
            make.width.equalTo(2)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

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

        view.addSubview(debugButton)
        debugButton.snp.makeConstraints { make in
            make.trailing.equalTo(headerView).offset(-16)
            make.top.equalTo(headerView).offset(16)
            make.size.equalTo(40)
        }

        view.addSubview(toolsBar)
        toolsBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Metric.horizonMargin)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(30)
        }
    }

    private func setupData() {
        tableView.reloadData()
    }

    private func showLoginView() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
}

// MARK: Button
extension MainTimeLineViewController {
    @objc private func clearData(_ sender: UIButton) {
        dataController.clearTasks()
        tableView.reloadData()
    }

    @objc private func addMoreButtonPressed(_ sender: UIControl) {
        dataController.addTask()
        tableView.reloadData()
    }

    @objc private func debugButtonPressed(_ sender: UIControl) {
//        let vc = RxExerciseViewController()
//        navigationController?.pushViewController(vc, animated: true)
        let vc = UIHostingController(rootView: SwiftUIExerciseView())
        present(vc, animated: true, completion: nil)
    }
}

extension MainTimeLineViewController: FishToolBarStackViewDelegate {
    func toolBarStackView(_ view: FishToolBarStackView, didSelectType type: FishToolType) {
        dataController.updateSelectType(type: type)
        tableView.reloadData()
    }
}

extension MainTimeLineViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataController.currentTaskCount > 0 ? 1 : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.currentTaskCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTimeLineTableCell.reuseIdentifier, for: indexPath) as? MainTimeLineTableCell else {
            return UITableViewCell()
        }
        cell.bind(model: dataController.currentTasks[indexPath.row])
        return cell
    }
}

extension MainTimeLineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
//        present(MyCardViewController(), animated: true, completion: nil)
        present(SFGBaseViewController(), animated: true, completion: nil)
    }
}

#if DEBUG

import SwiftUI

@available(iOS 13, *)
struct MainTimeLineVCPreview: PreviewProvider {
    static var devices = ["iPhone 11 Pro", "iPhone SE (1st generation)"]

    static var previews: some View {
        ForEach(devices, id: \.self) { deviceName in
            SFGBaseViewController().toPreview().previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}

#endif
