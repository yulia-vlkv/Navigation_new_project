//
//  RealmAuthentication.swift
//  Navigation
//
//  Created by Iuliia Volkova on 30.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift


class UserObject: Object {
    @Persisted(primaryKey: true) var login: String
    @Persisted var password: String
}

class RealmAuthentication {

    static let shared = RealmAuthentication()
    
    private var realm: Realm?
    
    init() {
        realm = try? Realm()
    }
    
    var currentUserObject: UserObject? {
        if let users = realm?.objects(UserObject.self) {
            return users.isEmpty ? nil : users[0]
        } else {
            return nil
        }
    }
    
    func signIn(with login: String, password: String) throws {

        let user = UserObject()
        user.login = login
        user.password = password

        try realm?.write({
            realm?.add(user)
        })
        
        print("Singed in with \(user.login) and \(user.password)")
    }
    
    func signOut() throws {

        try realm?.write({
            realm?.deleteAll()
        })
        
        print("Singed out.")
    }
}
