//
//  Checker.swift
//  Navigation
//
//  Created by Iuliia Volkova on 16.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class Checker {
    
    static var instance = Checker()
    
    #if DEBUG
    private let login = "Test"
    #else
    private let login = "Gavryusha"
    #endif
    
    private let password = "StrongPassword"
    
    private init() {}
    
    func checkLoginData(filledInLogin: String, filledInPassword: String) -> Bool {
        if login.hash == filledInLogin.hash && password.hash == filledInPassword.hash {
            print("Login and password are correct")
            return true
        } else {
            print("There's a mistake")
            return false
        }
    }
}

