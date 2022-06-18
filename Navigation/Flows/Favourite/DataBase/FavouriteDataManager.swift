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
    
    public lazy var favouritePosts = FavouriteDataManager.shared.fetchFavourites()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
          guard let modelURL = Bundle.main.url(forResource: "FavouriteModel", withExtension: "momd") else {
              fatalError("Unable to Find Data Model")
          }

          guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
              fatalError("Unable to Load Data Model")
          }

          return managedObjectModel
      }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

            let storeName = "FavouritesModel.sqlite"

            let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

            let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
            do {
                try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                                  configurationName: nil,
                                                                  at: persistentStoreURL,
                                                                  options: nil)
            } catch {
                fatalError("Unable to Load Persistent Store")
            }

            return persistentStoreCoordinator
        }()
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator

        return managedObjectContext
    }()
    
    func fetchFavourites() -> [PostVK] {
        let fetchRequest = Favourites.fetchRequest()
        var favouritePosts: [PostVK] = []
        do {
            let favourites = try managedObjectContext.fetch(fetchRequest)
            for post in favourites{
                let postVK = PostVK(liked: true,
                                    author: post.author ?? "Anon",
                                    description: post.text ?? "Heeeeeey",
                                    image: post.image ?? "angryCat",
                                    likes: Int(post.likes),
                                    views: Int(post.views))
                favouritePosts.append(postVK)
            }
        } catch let error {
            print(error)
        }
        return favouritePosts
    }
    
    func updateFavourites(post: PostVK){
        let fetchRequest = Favourites.fetchRequest()
        
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "author == %d" , post.author)
        fetchRequest.predicate = NSPredicate(format: "text == %@", post.description)
        
        do {
            let count = try managedObjectContext.count(for: fetchRequest)
            if count > 0 {
                let fetchedResult = try managedObjectContext.fetch(fetchRequest) as [NSManagedObject]
                if let post = fetchedResult.first as? Favourites {
                    print(post)
                    managedObjectContext.delete(post)
                    favouritePosts = fetchFavourites()
                    print("deleted")
                }
            } else {
                if let favouritePost = NSEntityDescription.insertNewObject(forEntityName: "Favourites", into: managedObjectContext) as? Favourites {
                    favouritePost.author = post.author
                    favouritePost.image = post.image
                    favouritePost.text = post.description
                    favouritePost.likes = Int16(post.likes + 1)
                    favouritePost.views = Int16(post.views)
                    favouritePosts = fetchFavourites()
                    print("added")
                } else {
                    fatalError("Unable to insert Favourites entity")
                }
            }
            try? managedObjectContext.save()
        } catch let error {
            print(error)
        }
    }
}
