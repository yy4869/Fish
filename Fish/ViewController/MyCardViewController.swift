//
//  MyCardViewController.swift
//  Fish
//
//  Created by yaoyuan on 2020/11/19.
//  Copyright © 2020 Tutor. All rights reserved.
//

import Foundation
import RxCocoa
import CardParts

class MyCardViewController: CardsViewController {

    let cards: [CardController] = [TestCardController()]

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCards(cards: cards)
    }
}

class TestCardController: CardPartsViewController  {

    var viewModel = TestViewModel()
    var titlePart = CardPartTitleView(type: .titleWithActionableButton)
    var textPart = CardPartTextView(type: .normal)

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.title.asObservable().bind(to: titlePart.rx.title).disposed(by: bag)
        viewModel.text.asObservable().bind(to: textPart.rx.text).disposed(by: bag)

        setupCardParts([titlePart, textPart])
    }
}

class TestViewModel {

    var title = BehaviorRelay(value: "")
    var text = BehaviorRelay(value: "")

    init() {

        // When these values change, the UI in the TestCardController
        // will automatically update
        title.accept("Hello, world!")
        text.accept("CardParts is awesome!")
    }
}
