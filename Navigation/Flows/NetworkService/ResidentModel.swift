//
//  ResidentData.swift
//  Navigation
//
//  Created by Iuliia Volkova on 09.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation


struct ResidentModel: Decodable {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let gender: String
    
    enum CodingKeys: String, CodingKey {
        case name, height, mass, gender
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(String.self, forKey: .height)
        mass = try container.decode(String.self, forKey: .mass)
        hairColor = try container.decode(String.self, forKey: .hairColor)
        skinColor = try container.decode(String.self, forKey: .skinColor)
        eyeColor = try container.decode(String.self, forKey: .eyeColor)
        gender = try container.decode(String.self, forKey: .gender)
    }
}
