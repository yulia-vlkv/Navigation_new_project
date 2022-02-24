//
//  ProfileViewCoordinator.swift
//  Navigation
//
//  Created by Iuliia Volkova on 30.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator, UserService {
    
    #if DEBUG
    let userService = TestUserService()
    let userName = TestUserService().testUser.userName
    #else
    let userService = CurrentUserService()
    let userName = CurrentUserService().someUser.userName
    #endif
    
    func returnUser(userName: String) -> User? {
        return userService.returnUser(userName: userName)
    }
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    
    let fabric = ProfileViewModuleFactory()
    
    init(){
        self.navigationController = .init()
    }

    func start() {}

    func startPush() -> UINavigationController {
        
        let profileViewController = fabric.createModule(coordinator: self)
        
        navigationController.setViewControllers([profileViewController], animated: false)
//        let logInVC = LogInController()
//        logInVC.coordinator = self
//        navigationController.setViewControllers([logInVC], animated: false)

        return navigationController
    }

}

extension ProfileCoordinator {
    
    func loggedInSuccessfully() {
        self.navigationController.pushViewController(ProfileController(coordinator: self, userService: userService, userName: userName ), animated: true)
    }
}
