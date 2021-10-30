//
//  FeedViewCoordinator.swift
//  Navigation
//
//  Created by Iuliia Volkova on 30.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//


import Foundation
import UIKit

class FeedViewCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    let checker = CheckTextField()

    init() {
        self.navigationController = .init()
    }

    func start() {}

    func startPush() -> UINavigationController {
        let feedViewController = FeedViewController(checker: checker)
        feedViewController.coordinator = self
        navigationController.setViewControllers([feedViewController], animated: false)

        return navigationController
    }
}
