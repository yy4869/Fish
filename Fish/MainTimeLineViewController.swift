//
//  MainTimeLineViewController.swift
//  Fish
//
//  Created by 媛小仙女 on 2020/9/2.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import UIKit

class MainTimeLineViewController: UIViewController {

    private lazy var addMoreButton: BaseButton = {
        let button = BaseButton()
        button.setBackgroundImage(UIImage(named: "PlusCircle"), for: .normal)
        button.addTarget(self, action: #selector(addMoreButtonPressed(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        showLoginView()
    }

    private func setupUserInterface() {
        view.backgroundColor = .white
        view.addSubview(addMoreButton)
        addMoreButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
        }
    }

    private func showLoginView() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }

    @objc private func addMoreButtonPressed(_ sender: UIButton) {
        ToastView.show(hint: "+1")
        let vc = SpringInterfaceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
