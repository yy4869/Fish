//
//  YYTextField.swift
//  Fish
//
//  Created by yaoyuan on 2020/8/27.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import UIKit

class YYTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserInterface()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUserInterface() {
        placeholder = "请输入..."
        clearButtonMode = .whileEditing
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.UI_whiteBoundryColor.cgColor
        font = UIFont.systemFont(ofSize: 16)
        textColor = .black
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 5.5))
        leftViewMode = .always
        layer.cornerRadius = 6
        clipsToBounds = true
        backgroundColor = .white

        if #available(iOS 11.0, *) {
            smartInsertDeleteType = .no
        }
    }
}
