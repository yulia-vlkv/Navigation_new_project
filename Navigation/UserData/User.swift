//
//  File.swift
//  Navigation
//
//  Created by Iuliia Volkova on 28.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    let userName: String
    let userImage: UIImage
    let userStatus: String
    
    init(userName: String, userImage: UIImage, userStatus: String) {
        self.userName = userName
        self.userImage = userImage
        self.userStatus = userStatus
    }
}
