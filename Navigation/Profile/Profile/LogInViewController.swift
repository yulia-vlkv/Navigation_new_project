//
//  LoginViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 04.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    let someUserService = CurrentUserService()
    let testUserService = TestUserService()
    
    private let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.toAutoLayout()
        return scroll
    }()

    private let mainView: UIView = {
            let mainView = UIView()
            mainView.backgroundColor = .white
            mainView.toAutoLayout()
            return mainView
    }()
    
    private let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logoVK")
        logo.toAutoLayout()
        return logo
    }()
    
    private let logInView: UIView = {
        let logInView = UIView()
        logInView.layer.cornerRadius = 10
        logInView.layer.borderWidth = 0.5
        logInView.layer.borderColor = UIColor.lightGray.cgColor
        logInView.clipsToBounds = true
        logInView.toAutoLayout()
        return logInView
    }()
    
    private let userNameField: UITextField = {
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
        textField.toAutoLayout()
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
        textField.toAutoLayout()
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
        logInButton.toAutoLayout()
        return logInButton
    }()
    
    @objc private func tapLogInButton() {
        #if DEBUG
        if let userName = userNameField.text, let _ = testUserService.returnUser(userName: userName) {
            let profileVC = ProfileViewController(userService: testUserService, userName: userName)
            navigationController?.pushViewController(profileVC, animated: true)
        } else {
            showLoginAlert()
            }
        #else
        if let userName = userNameField.text, let _ = someUserService.returnUser(userName: userName) {
            let profileVC = ProfileViewController(userService: someUserService, userName: userName)
            navigationController?.pushViewController(profileVC, animated: true)
        } else {
             showLoginAlert()
        }
        #endif
    }
    
    private func showLoginAlert(){
        let alertController = UIAlertController(title: "Error", message: "Invalid Username", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        userNameField.delegate = self
        password.delegate = self
        setupViews()
    }
    
    private var inset: CGFloat { return 16 }
    

    private func setupViews() {
        
        view.addSubview(scroll)
        scroll.toAutoLayout()
        
        scroll.addSubview(mainView)
        
        mainView.addSubviews(logo, logInView, logInButton)
        
        logInView.addSubviews(userNameField, password)
        
        scroll.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.width.height.equalToSuperview()
        }
        mainView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.width.height.equalToSuperview()
        }
        
        logo.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalTo(self.view)
            make.top.equalTo(mainView).inset(120)
        }
        
        logInView.snp.makeConstraints { make in
            make.top.equalTo(logo).offset(220)
            make.leading.trailing.equalTo(mainView).inset(16)
            make.height.equalTo(100)
        }
        
        userNameField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(logInView)
            make.top.equalTo(logInView)
        }
        
        password.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(logInView)
            make.bottom.equalTo(logInView)
        }
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(logInView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(mainView).inset(16)
            make.height.equalTo(50)
        }
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

// MARK: extension toAutoLayout
extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
