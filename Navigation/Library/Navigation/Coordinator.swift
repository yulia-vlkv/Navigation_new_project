//
//  Coordinator.swift
//  Navigation
//
//  Created by Iuliia Volkova on 03.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
    
    func start()
}
