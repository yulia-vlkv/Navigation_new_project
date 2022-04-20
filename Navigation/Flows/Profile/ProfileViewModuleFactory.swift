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
        let profilePresenter = ProfilePresenter (
            view: profileViewController,
            coordinator: coordinator
        )
        profileViewController.presenter = profilePresenter
        return profileViewController
    }

}

