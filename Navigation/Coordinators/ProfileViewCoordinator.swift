//
//  ProfileViewCoordinator.swift
//  Navigation
//
//  Created by Iuliia Volkova on 30.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(){
        self.navigationController = .init()
    }

    func start() { }

    func startPush() -> UINavigationController {
        let profileViewController = LogInViewController()
        profileViewController.coordinator = self
        navigationController.setViewControllers([profileViewController], animated: false)

        return navigationController
    }

}
