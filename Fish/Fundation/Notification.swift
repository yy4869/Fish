//
//  Notification.swift
//  Fish
//
//  Created by yaoyuan on 2021/5/12.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation

// MARK: - Notification Name for ObjC
@objcMembers public class FishNotificationName: NSObject {}

public extension Notification.Name {
    static let dismiss = Self(rawValue: "DismissNotification")
    static let dismiss2 = Self(rawValue: "Dismiss2Notification")
    static let dismiss3 = Self(rawValue: "Dismiss3Notification")
    static let dismiss4 = Self(rawValue: "Dismiss4Notification")
    static let dismiss5 = Self(rawValue: "Dismiss5Notification")
    static let dismiss6 = Self(rawValue: "Dismiss6Notification")
    static let dismiss7 = Self(rawValue: "Dismiss7Notification")
    static let appConfigDidFailUpdate = Self(rawValue: "AppConfigDidFailUpdateNotification")
}

public extension FishNotificationName {
    static let appConfigDidUpdate = Notification.Name.dismiss.rawValue
    static let appConfigDidFailUpdate = Notification.Name.appConfigDidFailUpdate.rawValue
}
