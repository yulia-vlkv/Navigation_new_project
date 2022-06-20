//
//  Favourite.swift
//  Navigation
//
//  Created by Iuliia Volkova on 11.06.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import CoreData

class FavouriteViewController: UIViewController {
    
    var presenter: FavouritePresenter?
    weak var coordinator: FavouriteCoordinator?
    
    private let favourites: FavouriteDataManager
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Favourites> = {
    
        let fetchRequest: NSFetchRequest<Favourites> = Favourites.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]

        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: favourites.backgroundContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        fetchedResultsController.delegate = self

        return fetchedResultsController
    }()
    
    init(favourites: FavouriteDataManager) {
        self.favourites = favourites
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .cyan
        setUpTableView()
        setNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavourites()
    }
    
    private func getFavourites(){
        fetchedResultsController.fetchRequest.predicate = nil
            favourites.backgroundContext.perform {
                do {
                    try self.fetchedResultsController.performFetch()
                    DispatchQueue.main.async {
                                   self.tableView.reloadData()
                    }
                } catch {
                    let fetchError = error as NSError
                    print("Unable to show favourites")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
        }
    }
        
    private func setNavBar() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Favourites"
        navigationController?.navigationBar.tintColor = .white
        let filterButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapFilterButton))
        let removeFilterButton =  UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRemoveFilterButton))
        
        navigationItem.rightBarButtonItems = [filterButton, removeFilterButton]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func didTapFilterButton(){
        let alert = UIAlertController(title: "Filer", message: "Enter Author's name", preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.placeholder = "AwesomeAuthor"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            if let textFields = alert.textFields,
               let tf = textFields.first,
               let textToSearch = tf.text {
                self.fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "author == %@", textToSearch)
                self.favourites.backgroundContext.perform {
                    do {
                        try self.fetchedResultsController.performFetch()
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        let fetchError = error as NSError
                        print("Unable to show favourites")
                        print("\(fetchError), \(fetchError.localizedDescription)")
                    }
                }
            } else {
                print("Can't filter results")
            }
        })
        navigationController?.present(alert, animated: true)
    }
    
    @objc func didTapRemoveFilterButton(){
        getFavourites()
    }
    
    private func setUpTableView(){
        view.addSubview(tableView)
        tableView.toAutoLayout()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: UITableViewDataSource
extension FavouriteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        
        let fetchedPost = fetchedResultsController.object(at: indexPath)
        print(fetchedPost)
        
        let post = PostVK(author: fetchedPost.author ?? "Anon",
                            description: fetchedPost.text ?? "Heeeeeey",
                            image: fetchedPost.image ?? "angryCat",
                            likes: Int(fetchedPost.likes),
                            views: Int(fetchedPost.views))
        
        cell.post = post
        
        cell.doubleTapHandler  = { [unowned self] in
            let postToDelete = fetchedResultsController.object(at: indexPath)
            favourites.backgroundContext.delete(postToDelete)
            try? favourites.backgroundContext.save()
        }
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension FavouriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let item = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            let postToDelete = self.fetchedResultsController.object(at: indexPath)
            self.favourites.backgroundContext.delete(postToDelete)
            try? self.favourites.backgroundContext.save()
        }
        
        item.image = UIImage(named: "deleteIcon")
        
        let swipeActions = UISwipeActionsConfiguration(actions: [item])
        
        return swipeActions
    }
    
}

extension FavouriteViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anyObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else { fallthrough }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            guard let newIndexPath = newIndexPath else { fallthrough }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard
                let indexPath = indexPath,
                let newIndexPath = newIndexPath
            else { fallthrough }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { fallthrough }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
