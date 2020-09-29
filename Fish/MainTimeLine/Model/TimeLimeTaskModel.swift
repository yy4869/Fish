//
//  TimeLimeTaskModel.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/29.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation

class TimeLimeTaskModel: Codable {
    var type: FishToolType
    var title: String
    var content: String?
    var date: Date?

    init(type: FishToolType = .diary, title: String = "") {
        self.type = type
        self.title = title
    }
}
