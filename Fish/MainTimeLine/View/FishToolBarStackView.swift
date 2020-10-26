//
//  FishToolBarStackView.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/24.
//  Copyright © 2020 Tutor. All rights reserved.
//

import UIKit

enum FishToolType: Int, CaseIterable, Codable {
    case none = -1
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
        case .none:
            return ""
        }
    }

    func backGroundColor() -> UIColor {
        var color: UIColor
        switch self {
        case .diary:
            color = .UI_diaryColor
        case .note:
            color = .UI_noteColor
        case .task:
            color = .UI_taskColor
        case .schedule:
            color = .UI_scheduleColor
        case .none:
            color = .UI_greyButtonColor
        }
        return color
    }
}

protocol FishToolBarStackViewDelegate: AnyObject {
    func toolBarStackView(_ view: FishToolBarStackView, didPressButton type: FishToolType)
}

class FishToolBarStackView: UIStackView {

    weak var delegate: FishToolBarStackViewDelegate?
    var selectedType: FishToolType? {
        didSet {

        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        alignment = .fill
        axis = .horizontal
        spacing = 10

        setupUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        for type in FishToolType.allCases {
            if type == .none { continue }
            let tool = FishToolButton(highlightedAlpha: 0.7)
//            tool.setBackgroundColor(.UI_greyButtonColor, for: [.normal, .highlighted])
            tool.setBackgroundColor(.UI_greyButtonColor, for: [.normal])
//            tool.setBackgroundColor(type.backGroundColor(), for: [.highlighted])
            tool.setBackgroundColor(type.backGroundColor(), for: [.selected])
            tool.adjustsImageWhenHighlighted = false
            tool.setTitle(type.desc(), for: .normal)
            tool.setTitleColor(.white, for: .normal)
            tool.titleLabel?.font = .systemFont(ofSize: 13)
            tool.addTarget(self, action: #selector(toolBarPressed(_:)), for: .touchDown)
            tool.tag = type.rawValue
            addArrangedSubview(tool)
        }
    }

    @objc private func toolBarPressed(_ button: UIButton) {
//        let pressedType = FishToolType(rawValue: button.tag) ?? .none
//        guard let button = arrangedSubviews[button.tag] as? BaseCornerRadiusButton else { return }
//
//        if let selectedType = selectedType {
//            if selectedType == pressedType {
//                button.setBackgroundColor(.UI_greyButtonColor, for: .normal)
//            } else {
//                button.setBackgroundColor(pressedType.backGroundColor(), for: .normal)
//                // 之前
//            }
//        } else {
//            selectedType = pressedType
//            button.setBackgroundColor(pressedType.backGroundColor(), for: .normal)
//        }
////        selectedType = FishToolType(rawValue: button.tag) ?? .none
        button.isSelected = !button.isSelected
        delegate?.toolBarStackView(self, didPressButton: FishToolType(rawValue: button.tag) ?? .none)
    }
}

class FishToolButton: BaseCornerRadiusButton {
//    override func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
//        super.setBackgroundColor(color, for: state)
//        if state == .normal || state == .selected {
//            setBackgroundColor(color?.withAlphaComponent(0.7), for: .highlighted)
//        }
//    }
    override var isHighlighted: Bool {
        didSet {
            print(backgroundColor)
            self.backgroundImage(for: .normal)
            setBackgroundColor(backgroundColor?.withAlphaComponent(0.7), for: .highlighted)
        }
    }

}
