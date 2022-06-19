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

class FavouriteViewController: UIViewController {
    
    var presenter: FavouritePresenter?
    var count = 0
    var favouritesArray: [PostVK] = []
    var filteredArray: [PostVK] = []
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        view.backgroundColor = .cyan
        setUpTableView()
        setNavBar()
        getFavourites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavourites()
    }
    
    private func getFavourites(){
        FavouriteDataManager.shared.fetchFavourites() { favouritesArray in
            DispatchQueue.main.async {
                self.favouritesArray = favouritesArray
                self.count = favouritesArray.count
                self.tableView.reloadData()
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
               let result = tf.text {
                FavouriteDataManager.shared.filerRerultsByAuthor(authorName: result) { filteredArray in
                    DispatchQueue.main.async {
                        self.filteredArray = filteredArray
                        self.count = filteredArray.count
                        self.tableView.reloadData()
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
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        cell.post = favouritesArray[indexPath.row]
        
        cell.doubleTapHandler  = { [unowned self] in
            if let post = favouritesArray[indexPath.row] as? PostVK {
                FavouriteDataManager.shared.updateFavourites(post: post) {
                    self.getFavourites()
                }
            } else {
                print ("can't delete a post")
            }
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
                if let post = self.favouritesArray[indexPath.row] as? PostVK {
                    FavouriteDataManager.shared.updateFavourites(post: post) {
                        self.getFavourites()
                    }
                } else {
                    print ("can't delete a post")
                }
            }
            item.image = UIImage(named: "deleteIcon")

            let swipeActions = UISwipeActionsConfiguration(actions: [item])
        
            return swipeActions
        }
}
