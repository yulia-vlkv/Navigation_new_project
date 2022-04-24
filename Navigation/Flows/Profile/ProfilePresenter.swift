//
//  ProfilePresenter.swift
//  Navigation
//
//  Created by Iuliia Volkova on 19.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class ProfilePresenter {
    
    private weak var view: ProfileViewController?
    var coordinator: ProfileCoordinator
    private let userService: UserService
    let userName: String = "" // TODO: ???
//    var passwordPicker: BruteForce
    
    init(view: ProfileViewController,
         coordinator: ProfileCoordinator,
         userService: UserService
    ){
        self.view = view
        self.coordinator = coordinator
        self.userService = userService
//        self.passwordPicker = passwordPicker
    }
    
    func viewDidLoad() {
        if let user = try? userService.returnUser(userName: userName) {
            self.view?.configure(with: user)
        }
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
