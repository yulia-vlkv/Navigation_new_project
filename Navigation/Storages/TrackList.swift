//
//  TrackList.swift
//  Navigation
//
//  Created by Iuliia Volkova on 18.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

struct TrackList {
    static let tracks = [
        Track(fileID: "PuppetLooselyStrung_theCorrespondents",
              trackName: "Puppet Loosely Strung",
              artistName: "The Correspondents",
              albumCover: UIImage(named: "theCorrespondents")!),
        
        Track(fileID: "Razzmatazz_iDKHOW",
              trackName: "Razzmatazz",
              artistName: "iDKHOW",
              albumCover: UIImage(named: "Razzmatazz")!),
        
        Track(fileID: "HandMeMyShovelImGoingIn!_WillWood",
              trackName: "Hand Me My Shovel, I'm Going In!",
              artistName: "Will Wood and the Tapeworms",
              albumCover: UIImage(named: "WillWood")!),
        
        Track(fileID: "AGoodSongNeverDies_SaintMotel",
              trackName: "A Good Song Never Dies",
              artistName: "Saint Motel",
              albumCover: UIImage(named: "SaintMotel")!),
        
        Track(fileID: "IveNoMoreFucksToGive_ThomasBenjaminWild",
              trackName: "I've No More Fucks to Give",
              artistName: "Thomas Benjamin Wild Esq",
              albumCover: UIImage(named: "ThomasBenjamin")!)
    ]
}
