//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 22.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let arrayOfPosts = allPosts.postArray
    let profileHeaderView = ProfileHeaderView()
    let userService: UserService
    let userName: String
    
    init(coordinator: ProfileCoordinator,
         userService: UserService,
         userName: String) {
        self.coordinator = coordinator
        self.userService = userService
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        setUpTableView()
        setupTimer()

        if let user = userService.returnUser(userName: userName){
            profileHeaderView.showUserData(user: user)
        }
    }
    
    private func setupTimer(){
        let timer = Timer.scheduledTimer(timeInterval: 6.0,
                          target: self,
                          selector: #selector(showReminderAlert),
                          userInfo: nil,
                          repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        timer.fire()
    }
    
    @objc func showReminderAlert() {
        let alertController = UIAlertController(title: "Slow down", message: "You work too hard", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Take a break", style: .cancel)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
     }
    
    private func setUpTableView(){
        view.addSubview(tableView)
        tableView.toAutoLayout()
        
        #if DEBUG
        tableView.backgroundColor = .cyan
        #else
        tableView.backgroundColor = .systemGray6
        #endif
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        
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
extension ProfileController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return arrayOfPosts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            return cell
        } else {
            let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            cell.post = arrayOfPosts[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: UITableViewDelegate
extension ProfileController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        return ProfileHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return UITableView.automaticDimension
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photosVC = PhotosViewController()
            navigationController?.pushViewController(photosVC, animated: true)
        } else {
            return tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
