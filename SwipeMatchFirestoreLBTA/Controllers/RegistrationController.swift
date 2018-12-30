//
//  RegistrationController.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Arian Azemati on 2018-12-26.
//  Copyright © 2018 Arian. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

    // UI Components
    
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    
    let fullNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter full name"
        tf.addTarget(self, action: #selector(handleTextChange(textField:)), for: .editingChanged)
        tf.backgroundColor = .white
        return tf
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(handleTextChange(textField:)), for: .editingChanged)
        tf.backgroundColor = .white
        return tf
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleTextChange(textField:)), for: .editingChanged)
        tf.backgroundColor = .white
        return tf
    }()
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        if textField == fullNameTextField {
            print("Full name changing")
            registrationViewModel.fullName = textField.text
            
        }else if textField == emailTextField {
            print("Email changing")
            registrationViewModel.email = textField.text
        }else {
            print("Pasword changing")
            registrationViewModel.password = textField.text
        }
    }
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
       // button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        button.backgroundColor = .lightGray
        button.setTitleColor(.gray, for: .disabled)
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupNotificationObserver()
        setupTapGesture()
        setupRegistrationViewModelObserver()
    }
    
    //MARK: -Private
    let registrationViewModel = RegistrationViewModel()
    
    fileprivate func setupRegistrationViewModelObserver() {
        registrationViewModel.isFormValidObserver =  {[unowned self](isFormValid) in
            print("Form is changing, is it valid?",isFormValid)
            self.registerButton.isEnabled = isFormValid
//            if isFormValid {
                self.registerButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
//                self.registerButton.setTitleColor(.white, for: .normal)
//            }else {
//                self.registerButton.backgroundColor = .lightGray
//                self.registerButton.setTitleColor(.gray, for: .normal)
//            }
           (isFormValid == true) ? (self.registerButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) , self.registerButton.setTitleColor(.white, for: .normal)) : (self.registerButton.backgroundColor = .lightGray,self.registerButton.setTitleColor(.gray, for: .normal))
            
        }
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true) //dismisses keyboard
       
    }
    
    fileprivate func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self) // yoou'll have a retain cycle if you dont do it
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
       // print("keyboard will show")
        // how to figure out how tall the keyboard actually is
       // print(notification.userInfo)
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = value.cgRectValue
        print(keyboardFrame)
        
        //lets try to figure out how tall the gap is from the register button to the bottom of the screen
        let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
        print(bottomSpace)
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    lazy var verticalStackView: UIStackView = {
        let sv =  UIStackView(arrangedSubviews: [
            fullNameTextField,
            emailTextField,
            passwordTextField,
            registerButton
            ])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 8
        return sv
    }()
    
    lazy var overallStackView = UIStackView(arrangedSubviews: [
        selectPhotoButton,
        verticalStackView
        ])
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.verticalSizeClass == .compact {
            overallStackView.axis = .horizontal
        } else {
            overallStackView.axis = .vertical
        }
    }
    
    
    fileprivate func setupLayout() {
        view.addSubview(overallStackView)
        overallStackView.axis = .horizontal
        selectPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
        overallStackView.spacing = 8
        overallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let gradientLayer = CAGradientLayer()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = self.view.bounds
    }
    
    fileprivate func setupGradientLayer() {
        
        let topColor = #colorLiteral(red: 0.9960784314, green: 0.7647058824, blue: 0.7137254902, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8745098039, green: 0.1019607843, blue: 0.1294117647, alpha: 1)
        // make sure to use cgcolor otherwise the gradient does not show correctly
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
}
