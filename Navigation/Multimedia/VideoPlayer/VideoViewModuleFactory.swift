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
        let videoVC = VideoViewController()
        let videoPresenter = VideoPresenter(
            view: videoVC,
            coordinator: coordinator
        )
        videoVC.presenter = videoPresenter
        videoVC.coordinator = coordinator
        return videoVC
    }
}
