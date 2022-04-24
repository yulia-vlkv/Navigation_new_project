//
//  ProfileViewCoordinator.swift
//  Navigation
//
//  Created by Iuliia Volkova on 30.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    
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
    
    var loginFactory = MyLoginFactory()
    let profileFactory = ProfileViewModuleFactory()

    private func isUserLoggedIn() -> Bool {
        false
    }
    
    func start() {}

    func startPush() -> UINavigationController {
        
        if self.isUserLoggedIn() {
            showProfile()
        } else {
            showLogin()
        }

        return navigationController
    }
    
    func showProfile() {
        let profileViewController = profileFactory.createModule(coordinator: self)
        
        navigationController.setViewControllers([profileViewController], animated: false)
    }
    
    func showLogin() {
        let loginViewController = loginFactory.createModule(coordinator: self)
        
        navigationController.setViewControllers([loginViewController], animated: false)
    }

}

extension ProfileCoordinator {
//    func pushProfileVC(userService: UserService, userName: String) {
//        let profileVC = fabric.createModule(coordinator: self)
//        navigationController.pushViewController(profileVC, animated: true)
//    }

//    func loggedInSuccessfully() {
//        self.navigationController.pushViewController(ProfileViewController(coordinator: self,
//                                                                       userService: userService,
//                                                                       userName: userName),
//                                                     animated: true)
//    }
    func loggedInSuccessfully() {
        self.showProfile()
        
//
//
//        let profileVC = fabric.createModule(coordinator: self)
//        self.navigationController.pushViewController(profileVC, animated: true)
//        self.navigationController.pushViewController(ProfileViewController(), animated: true)
    }
//
//    func pushPhotoVC() {
//        self.navigationController.pushViewController(PhotosViewController(coordinator: self),
//                                                     animated: true)
//    }
//
//    func pushMusicVC() {
//        self.navigationController.pushViewController(MusicViewController(),
//                                                     animated: true)
//    }

}
