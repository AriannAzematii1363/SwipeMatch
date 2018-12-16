//
//  CardViewModel.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Arian Azemati on 2018-12-15.
//  Copyright © 2018 Arian. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}


struct CardViewModel {
    // we'll define the prperties that our view will display/render out
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}

//what exactly do we do with this cardviewmodel thing
