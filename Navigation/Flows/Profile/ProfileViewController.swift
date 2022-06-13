//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 22.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import Foundation


class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenter?
    weak var coordinator: ProfileCoordinator?
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let arrayOfPosts = allPosts.postArray
    let profileHeader = ProfileHeaderView()
    private var time = 30
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        setUpTableView()
        self.presenter?.setupTimer()
        self.logout()

        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    public func configure(with user: User) {
        profileHeader.showUserData(user: user)
    }
    
    public func logout(){
        profileHeader.logoutHandler = {
            self.presenter?.logOut()
        }
    }
    
    func showReminderAlert() {
        let alertController = UIAlertController(title: "Slow down", message: "You work too hard", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Take a break", style: .cancel) {_ in
            self.presenter?.time = 30
            self.presenter?.setupTimer()
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
     }
    

    private func setUpTableView(){
        view.addSubview(tableView)
        tableView.toAutoLayout()
        
        #if DEBUG
        tableView.backgroundColor = UIColor(named: "mint")
        #else
        tableView.backgroundColor = .systemGray6
        #endif
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID_01")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID_02")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID_03")
        
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
extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        default:
            return arrayOfPosts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellID_01", for: indexPath)
            cell.textLabel?.text = "Music"
            cell.backgroundColor = .white
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            cell.textLabel?.textColor = .black
            cell.accessoryView = UIImageView(image: UIImage(systemName: "arrow.forward"))
            cell.accessoryView?.tintColor = .black
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellID_02", for: indexPath)
            cell.textLabel?.text = "Video"
            cell.backgroundColor = .white
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            cell.textLabel?.textColor = .black
            cell.accessoryView = UIImageView(image: UIImage(systemName: "arrow.forward"))
            cell.accessoryView?.tintColor = .black
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellID_03", for: indexPath)
            cell.textLabel?.text = "Audio Recorder"
            cell.backgroundColor = .white
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            cell.textLabel?.textColor = .black
            cell.accessoryView = UIImageView(image: UIImage(systemName: "arrow.forward"))
            cell.accessoryView?.tintColor = .black
            return cell
        default:
            let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            cell.post = arrayOfPosts[indexPath.row]
            
            cell.doubleTapHandler  = { [unowned self] in
                if var post = arrayOfPosts[indexPath.row] as? PostVK {
                    FavouriteDataManager.shared.updateFavourites(post: post)
                    print("updated a post")
                } else {
                    print ("can't add a post")
                }
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        return profileHeader
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return UITableView.automaticDimension
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            presenter?.coordinator.pushPhotoVC()
        case 1:
            presenter?.coordinator.pushMusicVC()
        case 2:
            presenter?.coordinator.pushVideoVC()
        case 3:
            presenter?.coordinator.pushAudioRecorderVC()
        default:
            return tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
