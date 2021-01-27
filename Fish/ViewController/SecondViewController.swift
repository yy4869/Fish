//
//  SecondViewController.swift
//  Fish
//
//  Created by yaoyuan on 2021/1/26.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation
import RxSwift
import SCRAttributedStringBuilder
//import YYText

class SecondViewController: UIViewController {
    private var count = 0

//    private lazy var introLabel: YYLabel = {
//        let label = YYLabel(frame: CGRect.zero)
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        return label
//    }()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        transform()
    }

    private func setupUserInterface() {
        view.backgroundColor = .gray
//        view.addSubview(introLabel)
//        introLabel.snp.makeConstraints { make in
//            make.center.equalTo(view)
//            make.size.equalTo(100)
//        }
    }

    private func transform() {
//        introLabel.attributedText = TestUtils.buildBlessingViewLinkString(introStr: "click me") {
//            self.count += 1
//            print("count: \(self.count)")
//        }
    }
}

class TestUtils {
    public class func buildBlessingViewLinkString(
        introStr: String,
        tapAction: (() -> Void)? = nil
    ) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 15)
        let attributedStr = AttributedStringBuilder.build { builder in
            builder.append(introStr)
                .color(UIColor.blue)
                .font(font)
                .lineHeight(20)
                .lineSpacing(2)
                .alignment(.center)
        }

//        let linkRange = NSMakeRange(0, atstributedStr.length)
//        attributedStr.yy_setTextHighlight(linkRange, color: UIColor.blue, backgroundColor: nil) { _, _, _, _ in
//            tapAction?()
//        }
        return attributedStr
    }
}
