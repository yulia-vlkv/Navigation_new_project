//
//  FavouriteViewModuleFactory.swift
//  Navigation
//
//  Created by Iuliia Volkova on 11.06.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class FavouriteViewModuleFactory: ModuleFactory {
    
    func createModule(coordinator: FavouriteCoordinator) -> FavouriteViewController {
        let favouriteViewController = FavouriteViewController(favourites: FavouriteDataManager())
        let favouritePresenter = FavouritePresenter(
            view: favouriteViewController,
            coordinator: coordinator
        )
        
        favouriteViewController.presenter = favouritePresenter
        favouriteViewController.coordinator = coordinator
        return favouriteViewController
    }
}
