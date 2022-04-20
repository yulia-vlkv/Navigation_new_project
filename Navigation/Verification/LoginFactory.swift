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
}

class MyLoginFactory: LoginFactory {
    func createLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
