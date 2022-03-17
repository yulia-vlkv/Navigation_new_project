//
//  Checker.swift
//  Navigation
//
//  Created by Iuliia Volkova on 16.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class LogInChecker {
    
    static let instance = LogInChecker()
    
    #if DEBUG
    private let login = "Test"
    #else
    private let login = "Gavryusha"
    #endif
    
    let password = "000"
    
    init() {}
    
    func checkLoginData(filledInLogin: String, filledInPassword: String) -> Bool {
        if login.hash == filledInLogin.hash && password.hash == filledInPassword.hash {
            return true
        } else {
            return false
        }
    }  
}

