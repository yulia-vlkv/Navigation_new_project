//
//  AudioRecorderModuleFactory.swift
//  Navigation
//
//  Created by Iuliia Volkova on 25.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class AudioRecorderModuleFactory: ModuleFactory{
    func createModule(coordinator: ProfileCoordinator) -> AudioRecorderViewController {
        let audioRecorderVC = AudioRecorderViewController()
        let audioRecorderPresenter = AudioRecorderPresenter(
            view: audioRecorderVC,
            coordinator: coordinator
        )
        audioRecorderVC.presenter = audioRecorderPresenter
        audioRecorderVC.coordinator = coordinator
        return audioRecorderVC
    }
}
