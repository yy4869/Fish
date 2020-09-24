//
//  FishUtils.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/24.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation

func FishPrint(_ message: String) {
    #if DEBUG
        print("🐟 [\(message)]")
    #endif
}
