//
//  ProfileViewCoordinator.swift
//  Navigation
//
//  Created by Iuliia Volkova on 30.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import RealmSwift

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
        
        guard RealmAuthentication.shared.currentUserObject != nil else {
            print("User is not logged in")
            return false
        }
        print("Realm: \(RealmAuthentication.shared.currentUserObject)")
        return true
    }
    
    func start() {}

    func startPush() -> UINavigationController {
        
        if self.isUserLoggedIn() {
            showProfile()
        } else {
            logOut()
            showLogin()
        }

        return navigationController
    }
    
    func logOut() {
        
        do {
            try RealmAuthentication.shared.signOut()
            showLogin()
        } catch {
            print(error.localizedDescription)
        }
        
//        do {
//            try Auth.auth().signOut()
//            showLogin()
//        } catch let signOutError as NSError {
//            print(signOutError.localizedDescription)
//        }
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
    
    func loggedInSuccessfully() {
        self.showProfile()
    }

    func pushPhotoVC() {
        let photosViewController = PhotosViewModuleFactory().createModule(coordinator: self)
        self.navigationController.pushViewController(photosViewController,
                                                     animated: true)
    }

    func pushMusicVC() {
        let musicViewController = MusicViewModuleFactory().createModule(coordinator: self)
        self.navigationController.pushViewController(musicViewController,
                                                     animated: true)
    }
    
    func pushVideoVC() {
        let videoViewController = VideoViewModuleFactory().createModule(coordinator: self)
        self.navigationController.pushViewController(videoViewController,
                                                     animated: true)
    }
    
    func pushAudioRecorderVC(){
        let audioRecorderViewController = AudioRecorderModuleFactory().createModule(coordinator: self)
        self.navigationController.pushViewController(audioRecorderViewController,
                                                     animated: true)
    }
}
