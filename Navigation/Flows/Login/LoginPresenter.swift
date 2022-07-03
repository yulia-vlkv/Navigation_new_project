//
//  LoginPresenter.swift
//  Navigation
//
//  Created by Iuliia Volkova on 19.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift


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
    
    func didLoginPressed(username: String?, password: String?) {
        guard let username = username,
              let password = password
        else {
            self.view?.handle(error: AuthorizationError.emptyField)
            return
        }
        
        login(username: username, password: password)
    }
    
    func didPickPasswordPressed(username: String?) {
        guard let username = username
        else {
            self.view?.handle(error: AuthorizationError.emptyField)
            return
        }
        
        bruteForce() { password in
            self.login(username: username, password: password)
        }
    }
    
    private func login(username: String, password: String) {
        self.view?.indicatorToggle()
        loginChecker.login(username: username, password: password) { [weak self] result in
            guard let self = self else { return }
            self.view?.indicatorToggle()
            
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.view?.handle(error: error)
                case .success:
                    self.coordinator.loggedInSuccessfully()
                    do {
                        try RealmAuthentication.shared.signIn(with: username, password: password)
                    } catch {
                        print(error.localizedDescription)
                    }
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
