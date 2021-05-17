//
//  TestViewControllerPreview.swift
//  Fish
//
//  Created by yaoyuan on 2021/4/2.
//  Copyright © 2021 Tutor. All rights reserved.
//
import SwiftUI
import Foundation

struct TestViewControllerVCPreview: PreviewProvider {
    static var devices = ["iPhone 11 Pro"]

    static var previews: some View {
        ForEach(devices, id: \.self) { deviceName in
            TestViewController().toPreview().previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
