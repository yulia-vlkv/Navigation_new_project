//
//  LoginViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 04.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    private let scroll = UIScrollView()
    private let mainView = UIView()
    private let logo = UIImageView()
    private let logInView = UIView()
    private let logIn = UITextField()
    private let password = UITextField()
    private let logInButton = UIButton()
    private let bluePixel = UIImage(named: "bluePixel")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(scroll)
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        NSLayoutConstraint.activate(
            [scroll.topAnchor.constraint(equalTo: view.topAnchor),
             scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             scroll.heightAnchor.constraint(equalTo: view.heightAnchor),
             scroll.widthAnchor.constraint(equalTo: view.widthAnchor)])
        
        scroll.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = .white
        NSLayoutConstraint.activate(
            [mainView.topAnchor.constraint(equalTo: scroll.topAnchor),
             mainView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
             mainView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
             mainView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
             mainView.heightAnchor.constraint(equalTo: scroll.heightAnchor),
             mainView.widthAnchor.constraint(equalTo: scroll.widthAnchor)])
        
        mainView.addSubview(logo)
        
        logo.image = UIImage(named: "logoVK")
        logo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [logo.widthAnchor.constraint(equalToConstant: 100),
             logo.heightAnchor.constraint(equalToConstant: 100),
             logo.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
             logo.topAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.topAnchor, constant: 120)])
        
        mainView.addSubview(logInView)
        
        logInView.layer.cornerRadius = 10
        logInView.layer.borderWidth = 0.5
        logInView.layer.borderColor = UIColor.lightGray.cgColor
        self.logInView.clipsToBounds = true
        
        logInView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [logInView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
             logInView.leadingAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
             logInView.trailingAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
             logInView.heightAnchor.constraint(equalToConstant: 100)])
        
        logInView.addSubview(logIn)
        
        logInFieldSetUI(field: logIn)
        logIn.layer.borderWidth = 0.5
        logIn.placeholder = "Email or phone"
        logIn.delegate = self
        
        logIn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [logIn.heightAnchor.constraint(equalToConstant: 50),
             logIn.topAnchor.constraint(equalTo: self.logInView.topAnchor),
             logIn.widthAnchor.constraint(equalTo: self.logInView.widthAnchor)])

        logInView.addSubview(password)
        logInFieldSetUI(field: password)
        password.isSecureTextEntry = true
        password.placeholder = "Password"
        password.delegate = self
        
        password.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [password.heightAnchor.constraint(equalToConstant: 50),
             password.bottomAnchor.constraint(equalTo: self.logInView.bottomAnchor),
             password.widthAnchor.constraint(equalTo: self.logInView.widthAnchor)])
        
        mainView.addSubview(logInButton)
        
        logInButton.setBackgroundImage(bluePixel, for: .normal)
        let selectedPixel: UIImage = (bluePixel?.alpha(0.8))!
        logInButton.setBackgroundImage(selectedPixel, for: .selected)
        logInButton.setBackgroundImage(selectedPixel, for: .highlighted)
        logInButton.setBackgroundImage(selectedPixel, for: .disabled)
        logInButton.layer.cornerRadius = 10
        logInButton.layer.masksToBounds = true
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.titleLabel?.font = UIFont(name: "default", size: 16)
        logInButton.addTarget(self, action: #selector(tapLogInButton), for: .touchUpInside)
    
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [logInButton.topAnchor.constraint(equalTo: logInView.bottomAnchor, constant: 16),
             logInButton.leadingAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
             logInButton.trailingAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
             logInButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    @objc private func tapLogInButton() {
        let controller = storyboard?.instantiateViewController(identifier: "ProfileViewController")
        navigationController?.pushViewController(controller!, animated: false)
    }
    
    func logInFieldSetUI(field: UITextField){
        field.layer.backgroundColor = UIColor.systemGray6.cgColor
        field.tintColor = UIColor(named: "periwinkleBlue")
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.textColor = .black
        field.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        field.autocapitalizationType = .none
        field.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        field.returnKeyType = UIReturnKeyType.done
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scroll.contentInset.bottom = keyboardSize.height
            scroll.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scroll.contentInset.bottom = .zero
        scroll.verticalScrollIndicatorInsets = .zero
    }

}

extension UIImage {
    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
