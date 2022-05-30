//
//  LoginFactory.swift
//  Navigation
//
//  Created by Iuliia Volkova on 19.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

protocol LoginFactory {
    func createLoginInspector() -> LoginInspector
    func createLoginChecker() -> LogInChecker
    func createModule(coordinator: ProfileCoordinator) -> LoginViewController
}

class MyLoginFactory: LoginFactory, ModuleFactory {
    
    func createLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
    
    func createLoginChecker() -> LogInChecker {
        return FakeLogInChecker.sharedInstance
    }
    
    func createModule(coordinator: ProfileCoordinator) -> LoginViewController {
        let loginViewController = LoginViewController()
        let loginPresenter = LoginPresenter (
            view: loginViewController,
            coordinator: coordinator,
            loginInspector: createLoginInspector() ,
            loginChecker: createLoginChecker(),
            passwordPicker: BruteForce(),
            realmAuth: RealmAuthentication()
            )
    
        loginViewController.presenter = loginPresenter
        return loginViewController
    }
}
