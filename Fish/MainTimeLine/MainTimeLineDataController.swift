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
    var taskCount: Int {
        tasks.count
    }

    private(set) var selectType: FishToolType = .none

    var tasks: [TimeLimeTaskModel] {
        if selectType == .none {
            return allTasks
        }
        return allTasks.filter { $0.type == selectType }
    }
    var allTasks: [TimeLimeTaskModel] = []

    func addTask() {
        let task = TimeLimeTaskModel(type: FishToolType(rawValue: taskCount % 4) ?? .diary, title: "\(taskCount)")
        allTasks.append(task)
    }

    func clearTasks() {
        allTasks.removeAll()
    }

    func updateSelectType(type: FishToolType) {
        selectType = selectType == type ? .none : type
    }
}
