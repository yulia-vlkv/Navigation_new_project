//
//  allPhotos.swift
//  Navigation
//
//  Created by Iuliia Volkova on 18.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

// Удалила структуру imageVK, теперь это просто массив картинок. Пришлось править PhotosCollectionViewCell, PhotosViewController, PhotosTableViewCell, но вроде ничего не забыла.

struct allPhotos {
    static let photoArray: [UIImage?] = [
        UIImage(named: "BabyStarTantrums"),
        UIImage(named: "BlackEyeGalaxy"),
        UIImage(named: "CaptivatingSpiral"),
        UIImage(named: "ClusterOfRedWhiteBlue"),
        UIImage(named: "CometNearJupitersAsteroids"),
        UIImage(named: "CosmicNecklace"),
        UIImage(named: "DazzlingDynamicDuo"),
        UIImage(named: "DistantPlanet"),
        UIImage(named: "DoubleQuasarsMergingGalaxies"),
        UIImage(named: "FamousBlackHole"),
        UIImage(named: "GalacticDuo"),
        UIImage(named: "GalaxyInDazzlingDetail"),
        UIImage(named: "GalaxyWithFaintThreads"),
        UIImage(named: "HiddenSecret"),
        UIImage(named: "LegacyFellows"),
        UIImage(named: "MissingDarkMatters"),
        UIImage(named: "NASAHubbleSpaceTelescope"),
        UIImage(named: "Nebula"),
        UIImage(named: "StellarFurnace"),
        UIImage(named: "VeilNebula"),
        UIImage(named: "angryCat")
    ]
    
    static let photoArrayReversed = Array(photoArray.reversed())
}

