//
//  RegistrationViewModel.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Arian Azemati on 2018-12-29.
//  Copyright © 2018 Arian. All rights reserved.
//

import UIKit
//inside of this registration view model i want to capture the state of my form
class RegistrationViewModel {
    
    var fullName: String? {
        didSet{checkFormValidity()}
    }
    var email: String? {
        didSet{checkFormValidity()}
    }
    var password: String? {
        didSet{checkFormValidity()}
    }
    
    // Reactive Programing
    var isFormValidObserver: ((Bool) -> ())?
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
    
}
