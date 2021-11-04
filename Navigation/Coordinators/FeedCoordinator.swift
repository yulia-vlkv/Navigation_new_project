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
    let checker = CheckTextField()

    init() {
        self.navigationController = .init()
    }

    func start() {}

    func startPush() -> UINavigationController {
        let feedViewController = FeedController(checker: checker)
        feedViewController.coordinator = self
        navigationController.setViewControllers([feedViewController], animated: false)
        
        feedViewController.showPost = { [ weak self ] in
            self?.showPost()
        }
        
        feedViewController.presentPost = { [ weak self ] in
            self?.presentPost()
        }

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
