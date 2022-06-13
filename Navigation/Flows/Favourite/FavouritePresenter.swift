//
//  FavouritePresenter.swift
//  Navigation
//
//  Created by Iuliia Volkova on 11.06.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class FavouritePresenter {
    
    private weak var view: FavouriteViewController?
    private let coordinator: FavouriteCoordinator
    
    init(view: FavouriteViewController,
         coordinator: FavouriteCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
