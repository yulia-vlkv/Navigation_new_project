//
//  MusicViewModuleFactory.swift
//  Navigation
//
//  Created by Iuliia Volkova on 25.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class MusicViewModuleFactory: ModuleFactory{
    func createModule(coordinator: ProfileCoordinator) -> MusicViewController {
        let musicVC = MusicViewController()
        let musicPresenter = MusicPresenter(
            view: musicVC,
            coordinator: coordinator
        )
        musicVC.presenter = musicPresenter
        musicVC.coordinator = coordinator
        return musicVC
    }
}
