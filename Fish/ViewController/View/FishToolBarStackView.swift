//
//  FishToolBarStackView.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/24.
//  Copyright © 2020 Tutor. All rights reserved.
//

import UIKit

enum FishToolType: Int, CaseIterable {
    case diary
    case note
    case task
    case schedule

    func desc() -> String {
        switch self {
        case .diary:
            return "日记"
        case .note:
            return "笔记"
        case .task:
            return "待办"
        case .schedule:
            return "日程"
        }
    }
}

protocol FishToolBarStackViewDelegate: AnyObject {
    func toolBarStackView(_ view: FishToolBarStackView, didPressButton type: FishToolType)
}

class FishToolBarStackView: UIStackView {

    weak var delegate: FishToolBarStackViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        alignment = .center
        axis = .horizontal
        spacing = 10

        setupUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        for type in FishToolType.allCases {
            let tool = BaseCornerRadiusButton()
            tool.backgroundColor = .UI_greyLightColor
            tool.setTitle(type.desc(), for: .normal)
            tool.addTarget(self, action: #selector(toolBarPressed(_:)), for: .touchUpInside)
            tool.tag = type.rawValue
            addArrangedSubview(tool)
        }
    }

    @objc private func toolBarPressed(_ button: UIButton) {
        delegate?.toolBarStackView(self, didPressButton: FishToolType(rawValue: button.tag) ?? .diary)
    }
}
