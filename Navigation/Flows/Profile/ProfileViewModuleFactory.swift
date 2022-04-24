//
//  File.swift
//  Navigation
//
//  Created by Iuliia Volkova on 26.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class ProfileViewModuleFactory: ModuleFactory {
    
    func createModule(coordinator: ProfileCoordinator) -> ProfileViewController {
        let profileViewController = ProfileViewController()
        let profilePresenter = ProfilePresenter(
            view: profileViewController,
            coordinator: coordinator,
            userService: coordinator.userService
        )
        profileViewController.presenter = profilePresenter
        profileViewController.coordinator = coordinator
        return profileViewController
    }

}

