//
//  ViewController.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Arian Azemati on 2018-12-15.
//  Copyright © 2018 Arian. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    let topStackView = TopNavigationStackView()
     let buttonsStackView = HomeBottomControlsStackView()
     let cardsDeckView = UIView()
//
//    // MARK:- creating cardViewModel array using the protocole type of the viewModel
//    let cardViewModels = ([
//        User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c"),
//        User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c"),
//        Adviser(title: "Slide Out Menu", brandName: "Arian App", posterPhotoName: "slide_out_menu_poster")
//        ] as [ProducesCardViewModel]).map { (producer) -> CardViewModel in
//            return producer.toCardViewModel()
//    }
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
            User(name: "Kelly", age: 23, profession: "Music DJ", imageNames: ["kelly1", "kelly2", "kelly3"]),
            Adviser(title: "Slide Out Menu", brandName: "Arian App", posterPhotoName: "slide_out_menu_poster"),
             User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"])
            ] as [ProducesCardViewModel]
        let viewModels = producers.map(){$0.toCardViewModel()}
        return viewModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        setupLayOut()
        setupDummyCards()
        
    }
    
    @objc func handleSettings() {
        print("show registration page")
        let registrationController = RegistrationController()
        present(registrationController, animated: true, completion: nil)
    }
    
    
    fileprivate func setupDummyCards() {
        
        
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
           cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        
//        users.forEach { (user) in
//            let cardView = CardView(frame: .zero)
//            cardView.imageView.image = UIImage(named: user.imageName)
//            cardView.informationLabel.text = "\(user.name) \(user.age)\n\(user.profession)"
//
//            let attributedText = NSMutableAttributedString(string: "\(user.name)", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
//            attributedText.append(NSMutableAttributedString(string: " \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular) ]))
//
//            attributedText.append(NSMutableAttributedString(string: "\n\(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
//
//
//            cardView.informationLabel.attributedText = attributedText
//            cardsDeckView.addSubview(cardView)
//            cardView.fillSuperview()
//        }
        
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

