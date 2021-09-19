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
        let correctInfo = "\(login)\(password)".hash
        let currentInfo = "\(filledInLogin)\(filledInPassword)".hash
        if currentInfo == correctInfo {
            print("Login and password are correct")
            return true
        } else {
            print("There's a mistake")
            return false
        }
    }
}

