//
//  LoginViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 04.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfilePresenter {
    
    private weak var view: LogInController?
    var coordinator: ProfileCoordinator
//    private let checker: LogInChecker
    
    init(view: LogInController, coordinator: ProfileCoordinator) {
        self.view = view
        self.coordinator = coordinator
//        self.checker = checker
    }
    
    func loggedInSuccessfully() {
        coordinator.loggedInSuccessfully()
    }
    
//    func performCheck(login: String, password: String) -> Bool {
//        let result = checker.checkLoginData(filledInLogin: login,
//                               filledInPassword: password)
//        return result
////        {result in
////            view?.showInputResult(result)
////        }
////        { result in
////            view?.showInputResult(result)
////        }
//    }
}

class LogInController: UIViewController, UITextFieldDelegate {
    
    var presenter: ProfilePresenter?
    
    weak var checkerDelegate: LogInControllerDelegate?
    weak var loginFactory: MyLoginFactory?
//    weak var coordinator: ProfileCoordinator?
    
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
        let textField = CustomTextField(
            font: UIFont.systemFont(ofSize: 16),
            textColor: .black,
            backgroundColor: UIColor.systemGray6,
            placeholder: "Email or phone")
    
        textField.tintColor = UIColor(named: "periwinkleBlue")
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
    
        return textField
    }()
    
    private let passwordField: UITextField = {
        let textField = CustomTextField(
            font: UIFont.systemFont(ofSize: 16),
            textColor: .black,
            backgroundColor: UIColor.systemGray6,
            placeholder: "Password")
        
        textField.isSecureTextEntry = true
        textField.returnKeyType = UIReturnKeyType.done
        textField.tintColor = UIColor(named: "periwinkleBlue")
        
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let bluePixel = UIImage(named: "bluePixel")
        let button = CustomButton(
            title: "Log In",
            titleColor: .white,
            backgroungColor: nil,
            backgroungImage: bluePixel,
            cornerRadius: 10) {
                self.showInputResult()
            }
        
//        { [self] in
//
//            #if DEBUG
//            let userService = TestUserService()
//            #else
//            let userService = CurrentUserService()
//            #endif
//
//            if let username = userNameField.text,
//               let password = passwordField.text,
//               let inspector = checkerDelegate,
//               inspector.checkLoginTextfields(filledInLogin: username, filledInPassword: password) {
//
////                let profileVC = ProfileController(userService: userService, userName: username)
////                    navigationController?.pushViewController(profileVC, animated: true)
//            } else {
//                showLoginAlert()
//            }
//        }

        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont(name: "default", size: 16)
        
        return button
    }()
    
    func showInputResult(){
            
        #if DEBUG
        let userService = TestUserService()
        #else
        let userService = CurrentUserService()
        #endif
            
        if let username = userNameField.text,
            let password = passwordField.text,
            let inspector = checkerDelegate,
            inspector.checkLoginTextfields(filledInLogin: username, filledInPassword: password) {
            self.presenter?.coordinator.loggedInSuccessfully()
                
//            self.coordinator?.loggedInSuccessfully()
//                let profileVC = ProfileController(userService: userService, userName: username)
//                    navigationController?.pushViewController(profileVC, animated: true)
        } else {
            showLoginAlert()
        }
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
        passwordField.delegate = self
        setupViews()
    }
    
    private var inset: CGFloat { return 16 }
    

    private func setupViews() {
        
        view.addSubview(scroll)
        scroll.toAutoLayout()
        
        scroll.addSubview(mainView)
        
        mainView.addSubviews(logo, logInView, logInButton)
        
        logInView.addSubviews(userNameField, passwordField)
        
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
        
        passwordField.snp.makeConstraints { make in
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
extension LogInController {
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
