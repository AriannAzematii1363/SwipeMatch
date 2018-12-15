//
//  CardView.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Arian Azemati on 2018-12-15.
//  Copyright © 2018 Arian. All rights reserved.
//

import UIKit

class CardView: UIView {

    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //custom drawing code
       layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {

        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded()
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
    
    fileprivate func handleEnded() {
        
        let shouldDismissCard = true
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
               
                self.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
                
                
            }else {
               self.transform = .identity
            }
            
        }) { (_) in
            //print("Completed animation,lets bring our card back")
            self.transform = .identity
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
