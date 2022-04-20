//
//  Checker.swift
//  Navigation
//
//  Created by Iuliia Volkova on 16.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit


protocol LogInChecker {
    func checkLoginData(filledInLogin: String, filledInPassword: String) -> Bool
    func check(password: String, completion: (Result<Bool, Error>) -> ())
}


class FakeLogInChecker: LogInChecker {
    
    static let sharedInstance = FakeLogInChecker()
    
    #if DEBUG
    private let login = "Test"
    #else
    private let login = "Gavryusha"
    #endif
    
    private let constantPassword = "000"
    
    init() {}
    
    func checkLoginData(filledInLogin: String, filledInPassword: String) -> Bool {
        if login.hash == filledInLogin.hash && constantPassword.hash == filledInPassword.hash {
            return true
        } else {
            return false
        }
    }
    
    func check(password: String, completion: (Result<Bool, Error>) -> ()) {
        completion(.success(password == constantPassword))
    }
}


