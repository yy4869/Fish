//
//  UIViewController+Preview.swift
//  Fish
//
//  Created by yaoyuan on 2021/1/14.
//  Copyright © 2021 Tutor. All rights reserved.
//

import UIKit

#if DEBUG
import SwiftUI

@available(iOS 13, *)
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        
        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }
    }

    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif
