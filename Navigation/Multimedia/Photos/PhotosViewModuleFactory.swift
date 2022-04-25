//
//  PhotosViewModuleFactory.swift
//  Navigation
//
//  Created by Iuliia Volkova on 25.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class PhotosViewModuleFactory: ModuleFactory{
    func createModule(coordinator: ProfileCoordinator) -> PhotosViewController {
        let photosViewController = PhotosViewController()
        let photosPresenter = PhotosPresenter(
            view: photosViewController,
            coordinator: coordinator
        )
        photosViewController.presenter = photosPresenter
        photosViewController.coordinator = coordinator
        return photosViewController
    }
}
