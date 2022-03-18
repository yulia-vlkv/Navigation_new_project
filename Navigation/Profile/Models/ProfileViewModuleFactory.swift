//
//  File.swift
//  Navigation
//
//  Created by Iuliia Volkova on 26.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class ProfileViewModuleFactory: ModuleFactory {
    func createModule(coordinator: ProfileCoordinator) -> LogInController {
        let profileViewController = LogInController()
        let profilePresenter = ProfilePresenter (
            view: profileViewController,
            coordinator: coordinator,
            passwordPicker: BruteForce())
        profileViewController.presenter = profilePresenter
        return profileViewController
    }

}

//class ProfileViewModuleFactory: ModuleFactory {
//    func createModule(coordinator: ProfileCoordinator) -> ProfileController {
//        let profileViewController = ProfileController()
//        let profilePresenter = ProfilePresenter (
//            view: profileViewController,
//            coordinator: coordinator,
//            passwordPicker: BruteForce())
//        profileViewController.presenter = profilePresenter
//        return profileViewController
//    }
//
//}

