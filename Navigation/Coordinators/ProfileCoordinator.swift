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
    
    func returnUser(userName: String) throws -> User {
        if let user = try? userService.returnUser(userName: userName) {
            return user
        } else {
            throw AuthorizationError.incorrectData
        }
    }
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController =  UINavigationController()
//    var inspectorFactory = MyLoginFactory()
    let fabric = ProfileViewModuleFactory()

    func start() {}

    func startPush() -> UINavigationController {
        
//        let loginVC = LogInController()
//        loginVC.loginFactory = inspectorFactory
//        loginVC.pushProfile = { [weak self] userService, userName in
//            self?.pushProfileVC(userService: userService, userName: userName)
//        }
        
        let profileViewController = fabric.createModule(coordinator: self)
        
//        navigationController.setViewControllers([loginVC], animated: false)
        navigationController.setViewControllers([profileViewController], animated: false)

        return navigationController
    }

}

extension ProfileCoordinator {
//    func pushProfileVC(userService: UserService, userName: String) {
//        let profileVC = fabric.createModule(coordinator: self)
//        navigationController.pushViewController(profileVC, animated: true)
//    }
    
    func loggedInSuccessfully() {
        self.navigationController.pushViewController(ProfileController(coordinator: self,
                                                                       userService: userService,
                                                                       userName: userName),
                                                     animated: true)
    }
//    func loggedInSuccessfully() {
//        self.navigationController.pushViewController(ProfileController(coder: nil),
//                                                     animated: true)
//    }
    
    func pushPhotoVC() {
        self.navigationController.pushViewController(PhotosViewController(coordinator: self),
                                                     animated: true)
    }
    
    func pushMusicVC() {
        self.navigationController.pushViewController(MusicViewController(),
                                                     animated: true)
    }

}
