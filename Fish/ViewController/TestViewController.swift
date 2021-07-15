//
//  TestViewController.swift
//  Fish
//
//  Created by yaoyuan on 2021/1/26.
//  Copyright © 2021 Tutor. All rights reserved.
//

import Foundation
import RxSwift
//import SDWebImage
import SCRAttributedStringBuilder
import SwiftUI

class TestViewController: UIViewController {
    static var count: Int = 0
    
     var statusBarstyle: UIStatusBarStyle = .default {
         didSet {
             super.setNeedsStatusBarAppearanceUpdate()
         }
     }
    
    var statusBarHidden: Bool = false {
        didSet {
            super.setNeedsStatusBarAppearanceUpdate()
        }
    }

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("click me", for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(.red), for: .normal)
        return button
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue.withAlphaComponent(0.3)
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var videoErrorImage: UIImage = {
        var image = FishImageUtils.placeholder(size: CGSize(width: 100, height: 100))
        return image ?? UIImage()
    }()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        transform()
    }

    private func setupUserInterface() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.size.equalTo(100)
            make.bottom.equalTo(view).offset(-100)
        }
    }
    
    private func transform() {
        button.rx.tap.subscribe(onNext: { [weak self] in
            let vc = SecondViewController2(title: "push 2")
//            vc.enablePrintLifeCycle = true
//            self?.navigationController?.pushViewController(vc, animated: true)
//            print("test yy button pressed", #function)
//            
            self?.forceLandscape(vc)
        }).disposed(by: disposeBag)
    }
    
    private func getCountdownString(hours: Int, minutes: Int, seconds: Int) -> NSAttributedString {
        let font: UIFont = FishFontUtils.regularPingFangSCFont(size: 13)
        let mediumFont: UIFont = FishFontUtils.mediumPingFangSCFont(size: 13)
        let color = UIColor.orange
        let margin: Float = 4
        let attr = AttributedStringBuilder.build({ builder in
            builder
                .append("距离开播").font(font).color(color).appendSpacing( 6)
                .all().lineHeight(21).baselineOffset(1)
                .appendImage(getCountdownNumberImage(hours) ?? UIImage(), font)
                .appendSpacing(margin).append(":").font(mediumFont).color(color).baselineOffset(2).appendSpacing(margin)
                .appendImage(getCountdownNumberImage(minutes) ?? UIImage(), font)
                .appendSpacing(margin).append(":").font(mediumFont).color(color).baselineOffset(2).appendSpacing(margin)
                .appendImage(getCountdownNumberImage(seconds) ?? UIImage(), font)
        })
        return attr
    }

    private func getReadyToStartString() -> NSAttributedString {
        let font: UIFont = FishFontUtils.regularPingFangSCFont(size: 13)
        let color = UIColor.orange
        let attr = AttributedStringBuilder.build({ builder in
            builder
                .append("直播即将开始").font(font).color(color)
                .all().lineHeight(20)
        })
        return attr
    }
    
    private func getCountdownNumberImage(_ number: Int) -> UIImage? {
        let numberStr = number > 999 ? "999" : String(format: "%02d", number)
        let labelWidth: CGFloat = number > 99 ? 27 : 20

        let label = UILabel()
        label.text = numberStr
        label.font = FishFontUtils.semiBoldPingFangSCFont(size: 13).monospacedDigitFont()
        label.textColor = UIColor.orange
        label.backgroundColor = UIColor.green
        label.layer.cornerRadius = 1
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: labelWidth, height: 20)

        return FishImageUtils.captureImage(from: label)
    }

}

extension TestViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarstyle
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
}
