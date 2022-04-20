//
//  LoginPresenter.swift
//  Navigation
//
//  Created by Iuliia Volkova on 19.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

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
    
    func didLoginPressed(){
        coordinator.loggedInSuccessfully()
    }
    
    func didPickPasswordPressed(){
//        bruteForce(passwordToUnlock: LogInChecker.instance.password)
    }
//    
//    private func bruteForce(passwordToUnlock: String) {
//        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }
//        var password: String = ""
//        let group = DispatchGroup()
//        let queue = DispatchQueue(label: "backgroundQueue", qos: .background)
//        
//        self.passwordField.text?.removeAll()
//        self.indicatorToggle()
//        group.enter()
//        
//        queue.async {
//            while password != passwordToUnlock {
//                password = (self.presenter?.passwordPicker.generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)) as! String
//                print(password)
//            }
//            group.leave()
//        }
//        
//        group.notify(queue: .main) { [self] in
//            self.indicatorToggle()
//            self.passwordField.text = password
//            passwordField.isSecureTextEntry = false
//        }
//    }
}


