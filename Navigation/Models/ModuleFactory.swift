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

protocol ModuleFactory{
    func createModule() -> UINavigationController
}

class FeedViewModule: ModuleFactory {
    func createModule() -> UINavigationController {
        <#code#>
    }
}

class ProfileViewModule: ModuleFactory {
    func createModule() -> UINavigationController {
        <#code#>
    }
}
   
