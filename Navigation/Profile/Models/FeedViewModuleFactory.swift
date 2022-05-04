//
//  FeedViewModuleFactory.swift
//  Navigation
//
//  Created by Iuliia Volkova on 26.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
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
