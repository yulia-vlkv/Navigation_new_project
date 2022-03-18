//
//  VideoViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 18.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import YoutubeKit

class VideoViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    public let playList = VideoPlaylist.playlist
    
    private var player: YTSwiftyPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Video"
        navigationController?.navigationBar.topItem?.title = "Back"
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func setupUI(){
        view.addSubview(tableView)
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}

extension VideoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CellID")
        let video = playList[indexPath.row]
        
        cell.textLabel?.text = video.title
        cell.textLabel?.numberOfLines = 3
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let video = playList[indexPath.row]
        
        let videoID = video.id
        let playerVC = YouTubePlayerViewController(videoID: videoID)
        
        navigationController?.present(playerVC, animated: true, completion: nil)
        
//        let streamURL = URL(string: video.url)!
//        let player = AVPlayer(url: streamURL)
//
//        let controller = AVPlayerViewController()
//        controller.player = player
//
//        present(controller, animated: true) {
//            player.play()
//        }
    }
}

