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
    func toolBarStackView(_ view: FishToolBarStackView, didSelectType type: FishToolType)
}

class FishToolBarStackView: UIStackView {

    weak var delegate: FishToolBarStackViewDelegate?
    private var selectedType: FishToolType = .none {
        didSet {
            delegate?.toolBarStackView(self, didSelectType: selectedType)
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
            let tool = BaseCornerRadiusButton(highlightedAlpha: 0.7)
            tool.setTitle(type.desc(), for: .normal)
            tool.setTitleColor(.white, for: .normal)
            tool.titleLabel?.font = .systemFont(ofSize: 13)
            tool.setBackgroundColor(.UI_greyButtonColor, for: .normal)
            tool.setBackgroundColor(type.backGroundColor(), for: .selected)
            tool.addTarget(self, action: #selector(toolBarPressed(_:)), for: .touchUpInside)

            tool.tag = type.rawValue
            addArrangedSubview(tool)
        }
    }

    @objc private func toolBarPressed(_ button: UIButton) {
        let pressedType = FishToolType(rawValue: button.tag) ?? .none
        guard let buttons = arrangedSubviews as? [BaseCornerRadiusButton] else { return }
        for btn in buttons {
            btn.isSelected = false
        }
        if pressedType == selectedType {
            selectedType = .none
        } else {
            selectedType = pressedType
            button.isSelected = true
        }
    }
}

#if DEBUG
import SwiftUI

struct FishToolBarStackViewRepresentable: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {}

    func makeUIView(context: Context) -> some UIView {
        FishToolBarStackView()
    }
}

@available(iOS 13.0, *)
struct FishToolBarStackViewPreview: PreviewProvider {
    static var previews: some View {
        FishToolBarStackViewRepresentable()
    }
}
#endif
