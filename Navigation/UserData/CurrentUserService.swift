//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Iuliia Volkova on 28.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class CurrentUserService: UserService {
    
    let someUser: User = User(userName: "Anonymous", userImage: #imageLiteral(resourceName: "logoVK"), userStatus: "No Status")
    
    func returnUser(userName: String) -> User? {
        
        if userName == someUser.userName {
             return someUser
         }
             return nil
    }
}
