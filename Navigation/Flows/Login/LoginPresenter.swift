//
//  LoginPresenter.swift
//  Navigation
//
//  Created by Iuliia Volkova on 19.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseAuth

class LoginPresenter {
    
    private weak var view: LoginViewController?
    var coordinator: ProfileCoordinator
    var loginInspector: LoginInspector
    var passwordPicker: BruteForce
    let loginChecker: LogInChecker
    
    init(view: LoginViewController,
         coordinator: ProfileCoordinator,
         loginInspector: LoginInspector,
         loginChecker: LogInChecker,
         passwordPicker: BruteForce){
        self.view = view
        self.coordinator = coordinator
        self.loginInspector = loginInspector
        self.loginChecker = loginChecker
        self.passwordPicker = passwordPicker
    }
    
    func didLoginPressed(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
            self.view?.handle(error: AuthorizationError.emptyField)
            return
        } else {
            login(email: username, password: password)
        }
    }
    
    func didPickPasswordPressed(username: String) {
        if username.isEmpty {
            self.view?.handle(error: AuthorizationError.emptyField)
            return
        } else {
            bruteForce() { password in
                self.loginChecker.login(username: username, password: password) { [weak self] result in
                    guard let self = self else { return }
                    self.view?.indicatorToggle()
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .failure(let error): self.view?.handle(error: error)
                        case .success: self.coordinator.loggedInSuccessfully()
                        }
                    }
                    self.view?.indicatorToggle()
                }
            }
        }
    }

    
    private func login(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                self?.view?.handle(error: AuthorizationError.incorrectData)
            } else {
                self?.coordinator.loggedInSuccessfully()
                if let user = Auth.auth().currentUser {
                    let uid = user.uid
                    let email = user.email
                    print(uid)
                    print("Current user's email is: \(String(describing: email))")
                }
            }
        }
    }
    
    func singUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                self.view?.handle(error: error)
//                self.showAlert(message: "Failed to create new user \(error.localizedDescription)")
            } else {
                self.coordinator.loggedInSuccessfully()
                if let user = Auth.auth().currentUser {
                    let uid = user.uid
                    let email = user.email
                    print(uid)
                    print("Current user's email is: \(String(describing: email))")
                }
            }
        }
    }
    
    private func bruteForce(completion: @escaping (_ password: String) -> Void) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }
        var password: String = ""
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "backgroundQueue", qos: .background)
        
        self.view?.indicatorToggle()
        group.enter()
        
        queue.async {
            repeat {
                password = self.passwordPicker.generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
                print(password)
            } while !self.loginChecker.check(password: password)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.view?.indicatorToggle()
            completion(password)
        }
    }
}


