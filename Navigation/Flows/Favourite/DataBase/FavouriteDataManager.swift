//
//  FavouriteDataManager.swift
//  Navigation
//
//  Created by Iuliia Volkova on 11.06.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import CoreData

class FavouriteDataManager {
    
    static let shared = FavouriteDataManager()
    
    let persistentContainer: NSPersistentContainer
    lazy var backgroundContext = persistentContainer.newBackgroundContext()

    init() {

    let container = NSPersistentContainer(name: "FavouriteModel")
    container.loadPersistentStores { description, error in
       if let error = error {
           fatalError("Unable to load persistent stores: \(error)")
       }
    }
    self.persistentContainer = container
    }
    
    func updateFavourites(post: PostVK, completion: @escaping () -> Void){
        let fetchRequest = Favourites.fetchRequest()
        
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "author == %@" , post.author)
        fetchRequest.predicate = NSPredicate(format: "text == %@", post.description)
        
        do {
            let count = try backgroundContext.count(for: fetchRequest)
            if count > 0 {
                let fetchedResult = try backgroundContext.fetch(fetchRequest) as [NSManagedObject]
                print(fetchedResult)
                if let post = fetchedResult.first as? Favourites {
                    print(post)
                    backgroundContext.delete(post)
                    print("deleted")
                }
            } else {
                let favouritePost = Favourites(context: backgroundContext)
                    favouritePost.author = post.author
                    favouritePost.image = post.image
                    favouritePost.text = post.description
                    favouritePost.likes = Int16(post.likes + 1)
                    favouritePost.views = Int16(post.views)
                    print("added")
            }
            try? backgroundContext.save()
            completion()
        } catch let error {
            print(error)
        }
    }
    
}

