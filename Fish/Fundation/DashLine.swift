//
//  DashLine.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/24.
//  Copyright © 2020 Tutor. All rights reserved.
//

import UIKit

public class DashLine: UIView {
    var lineColor: UIColor {
        didSet {
            setNeedsDisplay()
        }
    }

    var isVertical: Bool {
        didSet {
            setNeedsDisplay()
        }
    }

    var lineDash: CGFloat {
        didSet {
            setNeedsDisplay()
        }
    }

    var margin: CGFloat {
        didSet {
            setNeedsDisplay()
        }
    }

    public override var bounds: CGRect {
        didSet {
            setNeedsDisplay()
        }
    }

    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        context?.setLineWidth(width)
        context?.setStrokeColor(lineColor.cgColor)
        context?.setLineDash(phase: 0, lengths: [lineDash, margin])
        context?.move(to: CGPoint(x: 0, y: 0))
        if isVertical {
            context?.addLine(to: CGPoint(x: 0, y: height))
        } else {
            context?.addLine(to: CGPoint(x: width, y: 0))
        }
        context?.strokePath()
    }

    public init(lineColor: UIColor, isVertical: Bool, lineDash: CGFloat, margin: CGFloat) {
        self.lineColor = lineColor
        self.isVertical = isVertical
        self.lineDash = lineDash
        self.margin = margin
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
