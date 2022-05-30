//
//  RealmAuthentication.swift
//  Navigation
//
//  Created by Iuliia Volkova on 30.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class RealmUser: Object {
    
    dynamic var login: String?
    dynamic var password: String?
    dynamic var loggedIn: Bool?

    override class func primaryKey() -> String? {
        return "login"
    }
}

class RealmAuthentication {

    static let shared = RealmAuthentication()
    
    private var realm: Realm?
    
    init() {
        realm = try? Realm()
    }
    
    var currentUser: String? {
        print(realm.self)
        guard let user = realm?.objects(RealmUser.self).first(where: { $0.loggedIn != true }) else { return nil }
        print(user.login)
        return user.login
    }

    func signIn(withLogin login: String, password: String) throws {

        guard let user = realm?.object(ofType: RealmUser.self, forPrimaryKey: login) else {
            throw AuthorizationError.userNotFound
        }

        guard user.password == password else {
            throw AuthorizationError.incorrectData
        }

        try realm?.write({
            user.loggedIn = true
            print(user.loggedIn)
        })
    }

    func createUser(withLogin login: String, password: String) throws {

        if let _ = realm?.object(ofType: RealmUser.self, forPrimaryKey: login) {
            throw AuthorizationError.userAlreadyExist
        }

        let user = RealmUser()
        user.login = login
        user.password = password

        try realm?.write({
            realm?.add(user)
        })

        try signIn(withLogin: login, password: password)
    }

    func signOut() throws {
        
        guard let userLogin = currentUser else {
            throw AuthorizationError.userNotLoggedIn
        }

        guard let user = realm?.object(ofType: RealmUser.self, forPrimaryKey: userLogin) else {
            throw AuthorizationError.userNotFound
        }

        try realm?.write({
            user.loggedIn = false
            print(user.loggedIn)
        })
    }
}


