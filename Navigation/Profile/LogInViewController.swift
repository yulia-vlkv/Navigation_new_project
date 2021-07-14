//
//  LoginViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 04.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    private let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private let mainView: UIView = {
            let mainView = UIView()
            mainView.backgroundColor = .white
            mainView.translatesAutoresizingMaskIntoConstraints = false
            return mainView
    }()
    
    private let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logoVK")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private let logInView: UIView = {
        let logInView = UIView()
        logInView.layer.cornerRadius = 10
        logInView.layer.borderWidth = 0.5
        logInView.layer.borderColor = UIColor.lightGray.cgColor
        logInView.clipsToBounds = true
        logInView.translatesAutoresizingMaskIntoConstraints = false
        return logInView
    }()
    
    private let logIn: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField .frame.height))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.clipsToBounds = true
        textField.placeholder = "Email or phone"
        textField.returnKeyType = UIReturnKeyType.done
        textField.layer.backgroundColor = UIColor.systemGray6.cgColor
        textField.tintColor = UIColor(named: "periwinkleBlue")
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let password: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField .frame.height))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.clipsToBounds = true
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.returnKeyType = UIReturnKeyType.done
        textField.layer.backgroundColor = UIColor.systemGray6.cgColor
        textField.tintColor = UIColor(named: "periwinkleBlue")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let logInButton: UIButton = {
        let bluePixel = UIImage(named: "bluePixel")
        let logInButton = UIButton(type: .system)
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
        return logInButton
    }()
    
    @objc private func tapLogInButton() {
        let controller = storyboard?.instantiateViewController(identifier: "ProfileViewController")
        navigationController?.pushViewController(controller!, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        logIn.delegate = self
        password.delegate = self
        setupViews()
    }

    private func setupViews() {
        
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        scroll.addSubview(mainView)
        
        mainView.addSubview(logo)
        mainView.addSubview(logInView)
        mainView.addSubview(logInButton)
        
        logInView.addSubview(logIn)
        logInView.addSubview(password)

        let constraints = [
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scroll.heightAnchor.constraint(equalTo: view.heightAnchor),
            scroll.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            mainView.topAnchor.constraint(equalTo: scroll.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            mainView.heightAnchor.constraint(equalTo: scroll.heightAnchor),
            mainView.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.heightAnchor.constraint(equalToConstant: 100),
            logo.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
            logo.topAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.topAnchor, constant: 120),
            
            logInView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
            logInView.leadingAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            logInView.trailingAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logInView.heightAnchor.constraint(equalToConstant: 100),
            
            logIn.heightAnchor.constraint(equalToConstant: 50),
            logIn.topAnchor.constraint(equalTo: self.logInView.topAnchor),
            logIn.widthAnchor.constraint(equalTo: self.logInView.widthAnchor),
            
            password.heightAnchor.constraint(equalToConstant: 50),
            password.bottomAnchor.constraint(equalTo: self.logInView.bottomAnchor),
            password.widthAnchor.constraint(equalTo: self.logInView.widthAnchor),
            
            logInButton.topAnchor.constraint(equalTo: logInView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: Keyboard
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
// MARK: extension for alpha
extension UIImage {
    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
// MARK: extension for keyboard magic
extension LogInViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
