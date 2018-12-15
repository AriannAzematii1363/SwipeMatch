//
//  HomeBottomControlsStackView.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Arian Azemati on 2018-12-15.
//  Copyright © 2018 Arian. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        let subviews = [#imageLiteral(resourceName: "Image"), #imageLiteral(resourceName: "Image-1"), #imageLiteral(resourceName: "Image-2"), #imageLiteral(resourceName: "Image-3"), #imageLiteral(resourceName: "Image-4")].map { (img) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }

        subviews.forEach { (v) in
            addArrangedSubview(v)
        }
       
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
