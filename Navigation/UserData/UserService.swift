//
//  UserService.swift
//  Navigation
//
//  Created by Iuliia Volkova on 28.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

protocol UserService {
    
    func returnUser (userName: String) -> User?
    
}
