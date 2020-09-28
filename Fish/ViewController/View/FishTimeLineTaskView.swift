//
//  FishTimeLineTaskView.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/28.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import UIKit

class FishTimeLineTaskView: BaseControl {
    let type: FishToolType

    init(type: FishToolType) {
        self.type = type
        super.init(frame: .zero)
        setupUI()
        addTarget(self, action: #selector(taskViewPressed(_:)), for: .touchUpInside)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = type.backGroundColor()
        layer.cornerRadius = 8
        clipsToBounds = true
    }

    @objc private func taskViewPressed(_ button: UIControl) {
        FishPrint("press taskView")
    }
}
