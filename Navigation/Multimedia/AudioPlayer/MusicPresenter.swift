//
//  MusicPresenter.swift
//  Navigation
//
//  Created by Iuliia Volkova on 24.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class MusicPresenter {
    
    private weak var view: MusicViewController?
    private let coordinator: ProfileCoordinator
    
    init(view: MusicViewController,
         coordinator: ProfileCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
    }
}
