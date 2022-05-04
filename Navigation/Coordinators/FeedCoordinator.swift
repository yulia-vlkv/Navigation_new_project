//
//  FeedViewCoordinator.swift
//  Navigation
//
//  Created by Iuliia Volkova on 30.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//


import Foundation
import UIKit

class FeedCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    let checker = TextFieldChecker()
    
    let fabric = FeedViewModuleFactory()

    init() {
        self.navigationController = .init()
    }

    func start() {}

    func startPush() -> UINavigationController {
        
        let feedViewController = fabric.createModule(coordinator: self)

        navigationController.setViewControllers([feedViewController], animated: false)

        return navigationController
    }
}

extension FeedCoordinator {
    func showPost(){
        self.navigationController.pushViewController(PostViewController(coordinator: self), animated: true)
    }
    
    func presentPost(){
        self.navigationController.present(InfoViewController(coordinator: self), animated: true)
    }
}
