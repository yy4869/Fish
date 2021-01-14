//
//  MainTimeLineTableCell.swift
//  Fish
//
//  Created by yaoyuan on 2020/9/29.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import UIKit

class MainTimeLineTableCell: UITableViewCell {
    static let reuseIdentifier = "MainTimeLineTableCell"

    private lazy var timeStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalCentering
        view.alignment = .center
        return view
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .UI_greyLightColor
        label.text = "下午 6:02"
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .UI_greyLightColor
        label.text = "9/30 周二"
        return label
    }()

    private lazy var timeLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    private lazy var icon: UIImageView = {
        let view = UIImageView(image: UIImage.imageWithColor(.UI_greyLightColor))
        view.clipsToBounds = true
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .UI_darkColor
        label.text = "呵呵"
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUserInterface()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUserInterface() {
        backgroundColor = .clear
        contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(48)
        }

        contentView.addSubview(timeLine)
        timeLine.snp.makeConstraints { make in
            make.center.equalTo(icon)
            make.top.equalTo(icon).offset(-32)
            make.bottom.equalTo(icon).offset(32)
            make.width.equalTo(2)
            make.top.bottom.equalToSuperview()
        }

        contentView.addSubview(timeStackView)
        timeStackView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.trailing.equalTo(icon.snp.leading)
        }
        timeStackView.addArrangedSubview(timeLabel)
        timeStackView.addArrangedSubview(dateLabel)

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing)
            make.trailing.centerY.equalToSuperview()
        }
    }

    func bind(model: TimeLimeTaskModel) {
        titleLabel.text = model.title
        icon.image = UIImage.imageWithColor(model.type.backGroundColor())
//        根据时间确认大小
//        icon.snp.updateConstraints { make in
//            make.size.equalTo(36)
//        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct MainTimeLineTableCellPreview: PreviewProvider {
    static var previews: some View {
        MainTimeLineTableCell().toPreview()
    }
}
#endif
