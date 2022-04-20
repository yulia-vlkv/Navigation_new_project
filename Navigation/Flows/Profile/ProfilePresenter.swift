//
//  ProfilePresenter.swift
//  Navigation
//
//  Created by Iuliia Volkova on 19.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class ProfilePresenter {
    
    private weak var view: LoginViewController?
    var coordinator: ProfileCoordinator
//    var passwordPicker: BruteForce
    
    init(view: LoginViewController,
         coordinator: ProfileCoordinator){
        self.view = view
        self.coordinator = coordinator
//        self.passwordPicker = passwordPicker
    }
    
//    func pushProfileVC(userService: UserService, userName: String) {
//        coordinator.pushProfileVC(userService: userService, userName: userName)
//    }
    
//    func loggedInSuccessfully() {
//        coordinator.loggedInSuccessfully()
//    }
//
//    func pushPhotoVC() {
//        coordinator.pushPhotoVC()
//    }
//
//    func pushMusicVC() {
//        coordinator.pushMusicVC()
//    }
}
