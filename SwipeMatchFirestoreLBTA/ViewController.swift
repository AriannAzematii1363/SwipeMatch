//
//  ViewController.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Arian Azemati on 2018-12-15.
//  Copyright © 2018 Arian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let topStackView = TopNavigationStackView()
     let buttonsStackView = HomeBottomControlsStackView()
     let cardsDeckView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayOut()
        setupDummyCards()
    }
    
    fileprivate func setupDummyCards() {
        print("Setting up dummy cards")
        let cardView = CardView(frame: .zero)
        cardsDeckView.addSubview(cardView)
        cardView.fillSuperview()
    }
    
    
    // MARK:- Fileprivate
    fileprivate func setupLayOut() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
    


}

