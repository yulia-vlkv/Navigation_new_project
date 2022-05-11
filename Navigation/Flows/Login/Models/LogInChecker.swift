//
//  Checker.swift
//  Navigation
//
//  Created by Iuliia Volkova on 16.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth


protocol LogInChecker {
    func checkLoginData(filledInLogin: String, filledInPassword: String) -> Bool
//    func check(password: String, completion: (Result<Bool, Error>) -> ())
    func check(password: String) -> Bool
    
    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
    // func findPass(username: String, completion: (Result<String, Error>) -> Void)
}

// TODO: Rename to LoginService or AuthService or etc
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
    
    func check(password: String) -> Bool {
        password == constantPassword
    }
    
    
    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + 1) {
            if self.login.hash == username.hash &&
                self.constantPassword.hash == password.hash {
                completion(.success(username))
            } else {
                completion(.failure(AuthorizationError.incorrectData))
            }
        }
    }
}


