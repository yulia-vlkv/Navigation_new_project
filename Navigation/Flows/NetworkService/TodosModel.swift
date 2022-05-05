//
//  TodosModel.swift
//  Navigation
//
//  Created by Iuliia Volkova on 04.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

struct TodosModel: Codable {
    
    var id: Int
    var userId: Int
    var title: String
    var completed: Bool
    
    init(from dictionary: [String: Any]) {
        id = dictionary["id"] as? Int ?? 0
        userId = dictionary["userId"] as? Int ?? 0
        title = dictionary["title"] as? String ?? ""
        completed = dictionary["completed"] as? Bool ?? false
    }
}
