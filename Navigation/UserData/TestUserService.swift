//
//  TestUserService.swift
//  Navigation
//
//  Created by Iuliia Volkova on 28.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class TestUserService: UserService {
    
    let testUser: User = User(userName: "Blah Blah", userImage: #imageLiteral(resourceName: "blah.jpeg"), userStatus: "Blah-blah-blah-blah-blah!!")
    
    func returnUser(userName: String) -> User? {
        
        if userName == testUser.userName {
             return testUser
         }
             return nil
    }
}
