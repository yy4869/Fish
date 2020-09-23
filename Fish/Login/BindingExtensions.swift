//
//  BindingExtensions.swift
//  Fish
//
//  Created by yaoyuan on 2020/8/27.
//  Copyright © 2020 Tutor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//扩展UILabel
extension Reactive where Base: UILabel {
    //让验证结果（ValidationResult类型）可以绑定到label上
    var validationResult: Binder<ValidationResult> {
        return Binder(base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}
