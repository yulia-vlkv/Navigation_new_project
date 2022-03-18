//
//  MusicViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 18.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class MusicViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    public let trackList = TrackList.tracks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Music"
        navigationController?.navigationBar.topItem?.title = "Back"
        
        setupUI()
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

extension MusicViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellID")
        let track = trackList[indexPath.row]
        
        cell.textLabel?.text = track.trackName
        cell.detailTextLabel?.text = track.artistName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let track = indexPath.row
        let playerVC = AudioPlayerViewController()
        playerVC.tracklist = trackList
        playerVC.position = track
        navigationController?.present(playerVC, animated: true, completion: nil)
    }
}
