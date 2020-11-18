//
//  MainTimeLineDataController.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/29.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainTimeLineDataController: NSObject {
    private var currentType: FishToolType = .none
    private var allTasks: [TimeLimeTaskModel] = []
    private var taskCount: Int {
        allTasks.count
    }

    var currentTaskCount: Int {
        currentTasks.count
    }

    var currentTasks: [TimeLimeTaskModel] {
        if currentType == .none {
            return allTasks
        }
        return allTasks.filter { $0.type == currentType }
    }
}

extension MainTimeLineDataController {
    func updateSelectType(type: FishToolType) {
        currentType = type
    }

    // TODO: debug
    func addTask() {
        let task = TimeLimeTaskModel(type: FishToolType(rawValue: taskCount % 4) ?? .diary, title: "\(taskCount)")
        allTasks.append(task)
    }

    func clearTasks() {
        allTasks.removeAll()
    }
}
