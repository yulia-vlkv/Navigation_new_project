//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Iuliia Volkova on 30.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    let window: UIWindow?

    private var feedViewController: UIViewController!
    private var profileViewController: UIViewController!

    init(_ window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
    }

    func start() {
        let tabBarController = self.setTabBarController()
        self.window?.rootViewController = tabBarController
    }

    func setTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()

        let firstItem = UITabBarItem(title: "Feed",
                                     image: UIImage(systemName: "newspaper.fill"),
                                     tag: 0)
        let secondItem = UITabBarItem(title: "Profile",
                                      image: UIImage(systemName: "person.fill"),
                                      tag: 1)
        let thirdItem = UITabBarItem(title: "Favourite",
                                     image: UIImage(systemName: "heart.fill"),
                                     tag: 2)

        let feedViewCoordinator = FeedCoordinator()
        feedViewCoordinator.parentCoordinator = self
        childCoordinator.append(feedViewCoordinator)
        let feedViewController = feedViewCoordinator.startPush()
        feedViewController.tabBarItem = firstItem

        let profileViewCoordinator = ProfileCoordinator()
        profileViewCoordinator.parentCoordinator = self
        childCoordinator.append(profileViewCoordinator)
        let profileViewController = profileViewCoordinator.startPush()
        profileViewController.tabBarItem = secondItem
        
        let favouriteViewCoordinator = FavouriteCoordinator()
        favouriteViewCoordinator.parentCoordinator = self
        childCoordinator.append(favouriteViewCoordinator)
        let favouriteViewController = favouriteViewCoordinator.startPush()
        favouriteViewController.tabBarItem = thirdItem


        tabBarController.viewControllers = [feedViewController, profileViewController, favouriteViewController]

        return tabBarController
    }
}
