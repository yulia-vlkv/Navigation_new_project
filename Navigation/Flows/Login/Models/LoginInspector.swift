//
//  LoginInspector.swift
//  Navigation
//
//  Created by Iuliia Volkova on 18.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class LoginInspector: LogInControllerDelegate {
    func checkLoginTextfields(filledInLogin: String, filledInPassword: String) -> Bool {
        return FakeLogInChecker.sharedInstance.checkLoginData(filledInLogin: filledInLogin, filledInPassword: filledInPassword)
    }
}
