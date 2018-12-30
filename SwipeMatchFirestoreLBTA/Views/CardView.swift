//
//  CardView.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Arian Azemati on 2018-12-15.
//  Copyright © 2018 Arian. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
            // accessing  index 0 will crash if imageNames.count == 0
            let imageName = cardViewModel.imageNames.first ?? ""
            imageView.image = UIImage(named: imageName)
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = barDeselectedColor
                barsStackView.addArrangedSubview(barView)
            }
            barsStackView.arrangedSubviews.first?.backgroundColor = .white
            setupImageIndexObserver()
        }
    }
    
    fileprivate func setupImageIndexObserver() {
        cardViewModel.imageIndexObserver = { [weak self](idx, image) in
            guard let strongSelf = self else { return }
            strongSelf.imageView.image = image
            strongSelf.barsStackView.arrangedSubviews.forEach({ (v) in
                v.backgroundColor = strongSelf.barDeselectedColor
            })
            strongSelf.barsStackView.arrangedSubviews[idx].backgroundColor = .white
            print("changing photo from view model")
        }
    }
    
    //encapsulation
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    let gradientLayer = CAGradientLayer()
    fileprivate let informationLabel = UILabel()
    
    //Configurations
    fileprivate let threshold: CGFloat = 80
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        print("Handling tap and cyclying photoes")
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        
        
        if shouldAdvanceNextPhoto {
            cardViewModel.advanceToNextPhoto()
        }else {
            cardViewModel.goToPreviousePhoto()
        }
    }
   
    
    fileprivate func setUpLayout() {
        //custom drawing code
        layer.cornerRadius = 10
        
        clipsToBounds = true
        
        
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        setUpBarsStackView()
        
        
        // add a gradient layer somehow

        setUpGradientLayer()
        
        addSubview(informationLabel)
        
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
        
        informationLabel.textColor = .white
        
        informationLabel.numberOfLines = 0
    }
    
    fileprivate let barsStackView = UIStackView()
    
    fileprivate func setUpBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
        //some dummy bars for now
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually
     
    }
    
     fileprivate func setUpGradientLayer() {
        // how we can draw a gradient with swift
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        // self.frame is actually zero frame
        layer.addSublayer(gradientLayer)
    }
    
    
    override func layoutSubviews() {
        // in here you know what your cardView frame will be
        gradientLayer.frame = self.frame
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {

        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        //rotation
        // some not that scary math here to convert radians to degree
        
        let degrees:CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let transactionDirection:CGFloat = gesture.translation(in: self).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x ) > threshold
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
               
                self.frame = CGRect(x: 1000 * transactionDirection, y: 0, width: self.frame.width, height: self.frame.height)
                
                
            }else {
               self.transform = .identity
            }
            
        }) { (_) in
            self.transform = .identity
            if shouldDismissCard {
                self.removeFromSuperview()
            }
//            self.removeFromSuperview()
//            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
