//
//  UIView+Preview.swift
//  Fish
//
//  Created by yaoyuan on 2021/1/14.
//  Copyright © 2021 Tutor. All rights reserved.
//

import UIKit

#if DEBUG
import SwiftUI

@available(iOS 13, *)
extension UIView {
    private struct Preview: UIViewRepresentable {
        let view: UIView

        func updateUIView(_ uiView: UIViewType, context: Context) {}

        func makeUIView(context: Context) -> some UIView {
            view
        }
    }

    func toPreview() -> some View {
        Preview(view: self)
    }
}
#endif
