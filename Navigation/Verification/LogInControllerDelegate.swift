//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Iuliia Volkova on 18.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

protocol LogInControllerDelegate: AnyObject {
    func checkLoginTextfields(filledInLogin: String, filledInPassword: String) -> Bool 
}
