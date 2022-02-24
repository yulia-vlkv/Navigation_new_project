//
//  ModelFactory.swift
//  Navigation
//
//  Created by Iuliia Volkova on 03.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

enum Tabs {
    case feed
    case profile
}

protocol ModuleFactory {
    
    associatedtype ViewType
    associatedtype CoordinatorType
    
    func createModule(coordinator: CoordinatorType) -> ViewType
}

class FeedViewModuleFactory: ModuleFactory {
    func createModule(coordinator: FeedCoordinator) -> FeedController {
        let feedViewController = FeedController()
        let feedPresenter = FeedPresenter(
            view: feedViewController,
            coordinator: coordinator,
            checker: TextFieldChecker()
        )
        feedViewController.presenter = feedPresenter
        return feedViewController
    }
}

class ProfileViewModuleFactory: ModuleFactory {
    func createModule(coordinator: ProfileCoordinator) -> LogInController {
        let profileViewController = LogInController()
        let profilePresenter = ProfilePresenter (
            view: profileViewController,
            coordinator: coordinator)
        profileViewController.presenter = profilePresenter
        return profileViewController
    }
    
}
   
