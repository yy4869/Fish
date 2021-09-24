//
//  GradientBorderView.swift
//  Fish
//
//  Created by yaoyuan on 2021/9/23.
//  Copyright © 2021 Tutor. All rights reserved.
//

import UIKit

class TTGradientBorderView: UIView {
    var backgroundColors: [UIColor] = [.white, .black] {
        didSet {
            backgroundLayer.colors = backgroundColors.map { $0.cgColor }
        }
    }

    var borderColors: [UIColor] = [.black, .white] {
        didSet {
            borderLayer.colors = borderColors.map { $0.cgColor }
        }
    }

    var borderLineWidth: CGFloat = 1 {
        didSet {
            shapeLayer.lineWidth = borderLineWidth
        }
    }

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            titleLabel.snp.remakeConstraints { make in
                make.edges.equalToSuperview().inset(inset)
            }
        }
    }

    var gradientLayer: CAGradientLayer {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.locations = [0, 1]
        return layer
    }

    private lazy var backgroundLayer: CAGradientLayer = {
        let gradientLayer = gradientLayer
        gradientLayer.colors = backgroundColors.map { $0.cgColor }
        return gradientLayer
    }()

    private lazy var borderLayer: CAGradientLayer = {
        let gradientLayer = gradientLayer
        gradientLayer.colors = borderColors.map { $0.cgColor }
        return gradientLayer
    }()

    private lazy var shapeLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.lineWidth = borderLineWidth
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        return shape
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TTFontUtils.mediumPingFangSCFont(withSize: 16)
        label.textColor = UIColor.white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.masksToBounds = true
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(borderLayer)
        borderLayer.mask = shapeLayer
        addSubview(titleLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame = bounds
        borderLayer.frame = bounds
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
