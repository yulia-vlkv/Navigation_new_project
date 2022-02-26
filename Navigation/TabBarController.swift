//
//  TabBarController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 24.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//
//
//import Foundation
//import UIKit
//
//class TabBarViewController: UITabBarController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let correctWord = CheckTextField()
//
//        func setTabBarItem(viewController: UIViewController,
//                           tabBatTitle: String,
//                           image: String) -> UINavigationController {
//            let navigationVC = UINavigationController(rootViewController: viewController)
//            navigationVC.tabBarItem.title = tabBatTitle
//            navigationVC.tabBarItem.image = UIImage(systemName: image)
//            return navigationVC
//        }
//
//        self.setViewControllers(
//            [setTabBarItem(viewController: FeedViewController(checker: correctWord), tabBatTitle: "Feed", image: "newspaper.fill"),
//             setTabBarItem(viewController: LogInViewController(), tabBatTitle: "Profile", image: "person.fill") ],
//            animated: true)
//    }
//}
