//
//  ProfileViewCoordinator.swift
//  Navigation
//
//  Created by Iuliia Volkova on 30.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(){
        self.navigationController = .init()
    }

    func start() { }

    func startPush() -> UINavigationController {
        let logInVC = LogInViewController()
        logInVC.coordinator = self
        navigationController.setViewControllers([logInVC], animated: false)

        return navigationController
    }

}
