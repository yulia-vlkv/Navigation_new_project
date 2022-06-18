//
//  FavouriteCoordinator.swift
//  Navigation
//
//  Created by Iuliia Volkova on 11.06.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class FavouriteCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController = UINavigationController()
    
    let fabric = FavouriteViewModuleFactory()

    func start() {}

    func startPush() -> UINavigationController {
        
        let favouriteViewController = fabric.createModule(coordinator: self)

        navigationController.setViewControllers([favouriteViewController], animated: false)

        return navigationController
    }
}


