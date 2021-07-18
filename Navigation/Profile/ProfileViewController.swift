//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 22.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let cellID = "cellID"
    private let arrayOfPosts = allPosts.postArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    private func setUpTableView(){
        view.addSubview(tableView)
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellID)
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PostTableViewCell
        cell.post = arrayOfPosts[indexPath.row]
        return cell
    }
}

// MARK: UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return ProfileHeaderView()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
