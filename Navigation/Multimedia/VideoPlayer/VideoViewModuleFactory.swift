//
//  VideoViewModuleFactory.swift
//  Navigation
//
//  Created by Iuliia Volkova on 25.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class VideoViewModuleFactory: ModuleFactory{
    func createModule(coordinator: ProfileCoordinator) -> VideoViewController {
        let videoViewController = VideoViewController()
        let videoPresenter = VideoPresenter(
            view: videoViewController,
            coordinator: coordinator
        )
        videoViewController.presenter = videoPresenter
        videoViewController.coordinator = coordinator
        return videoViewController
    }
}
