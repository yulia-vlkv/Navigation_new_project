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
        let photosVC = PhotosViewController()
        let photosPresenter = PhotosPresenter(
            view: photosVC,
            coordinator: coordinator
        )
        photosVC.presenter = photosPresenter
        photosVC.coordinator = coordinator
        return photosVC
    }
}
