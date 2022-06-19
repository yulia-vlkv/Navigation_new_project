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
    
    
    private let persistentContainer: NSPersistentContainer
    private lazy var backgroundContext = persistentContainer.newBackgroundContext()

    init() {

    let container = NSPersistentContainer(name: "FavouriteModel")
    container.loadPersistentStores { description, error in
       if let error = error {
           fatalError("Unable to load persistent stores: \(error)")
       }
    }
    self.persistentContainer = container
    }
    
    func fetchFavourites(completion: @escaping ([PostVK]) -> Void) {
        
        backgroundContext.perform { [weak self] in
            guard let self = self else {
                return
            }
            
            let fetchRequest = Favourites.fetchRequest()
            var favouritePosts: [PostVK] = []
            do {
                let favourites = try self.backgroundContext.fetch(fetchRequest)
                for post in favourites {
                    let postVK = PostVK(liked: true,
                                        author: post.author ?? "Anon",
                                        description: post.text ?? "Heeeeeey",
                                        image: post.image ?? "angryCat",
                                        likes: Int(post.likes),
                                        views: Int(post.views))
                    favouritePosts.append(postVK)
                    //                    completion ( favouritePosts )
                }
            } catch let error {
                print(error)
            }
            return completion (favouritePosts)
        }
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
    
    func filerRerultsByAuthor(authorName: String,
                              completion: @escaping ([PostVK]) -> Void) {
        
        backgroundContext.perform { [weak self] in
            guard let self = self else {
                return
            }
            
            var filteredPosts: [PostVK] = []
            let fetchRequest = Favourites.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "author == %@", authorName)
            
            do {
                let filtered = try self.backgroundContext.fetch(fetchRequest)
                for post in filtered {
                    let postVK = PostVK(liked: true,
                                        author: post.author ?? "Anon",
                                        description: post.text ?? "Heeeeeey",
                                        image: post.image ?? "angryCat",
                                        likes: Int(post.likes),
                                        views: Int(post.views))
                    filteredPosts.append(postVK)
                }
            } catch let error {
                print(error)
            }
            return completion (filteredPosts)
        }
    }
}

