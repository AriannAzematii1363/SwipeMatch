//
//  TopNavigationStackView.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Arian Azemati on 2018-12-15.
//  Copyright © 2018 Arian. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {
    
    let settingsButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let fireImageView = UIImageView(image: #imageLiteral(resourceName: "Image-6"))
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        fireImageView.contentMode = .scaleAspectFit
        settingsButton.setImage(#imageLiteral(resourceName: "Image-5").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "Image-7").withRenderingMode(.alwaysOriginal), for: .normal)
        
        [settingsButton, UIView(), fireImageView,UIView(), messageButton].forEach { (v) in
            addArrangedSubview(v)
        }
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
