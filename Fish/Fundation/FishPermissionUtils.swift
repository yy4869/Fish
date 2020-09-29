//
//  FishPermissionUtils.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/28.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import Photos

public typealias TTPermissionCallback = () -> Void

class FishPermissionUtils {
    static func requestTakePhotoPermission(succ: TTPermissionCallback?, fail: TTPermissionCallback? = nil) {
        if #available(iOS 8.0, *) {
            let status = PHPhotoLibrary.authorizationStatus()
            FishPrint("\(status.rawValue)")
            if status == PHAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    succ?()
                }
            } else if status == PHAuthorizationStatus.denied {
                FishPrint("deny")
            } else if status == PHAuthorizationStatus.notDetermined {
                let handler: (PHAuthorizationStatus) -> Void = { status in
                    if status == PHAuthorizationStatus.authorized {
                        DispatchQueue.main.async {
                            succ?()
                        }
                    }
                }
                if #available(iOS 14.0, *) {
//                    PHPhotoLibrary.requestAuthorization(for: .readWrite, handler: handler)
                } else {
                    PHPhotoLibrary.requestAuthorization(handler)
                }
            }
        } else {
            // Won't be here
            DispatchQueue.main.async {
                fail?()
            }
        }
    }
}
