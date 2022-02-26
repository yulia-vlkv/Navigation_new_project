//
//  ModelFactory.swift
//  Navigation
//
//  Created by Iuliia Volkova on 03.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

enum Tabs {
    case feed
    case profile
}

protocol ModuleFactory {
    
    associatedtype ViewType
    associatedtype CoordinatorType
    
    func createModule(coordinator: CoordinatorType) -> ViewType
}
