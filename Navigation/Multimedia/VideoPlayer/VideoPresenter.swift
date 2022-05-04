//
//  VideoPresenter.swift
//  Navigation
//
//  Created by Iuliia Volkova on 24.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class VideoPresenter {
    
    private weak var view: VideoViewController?
    private let coordinator: ProfileCoordinator
    
    init(view: VideoViewController,
         coordinator: ProfileCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
    }

}
