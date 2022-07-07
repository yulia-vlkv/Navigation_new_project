//
//  AudioPlayerViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 17.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class AudioPlayerViewController: UIViewController {
    
    static var player = AVAudioPlayer()
    public var position: Int = 0
    public var tracklist = TrackList.tracks
    
    private lazy var playButton: CustomPlayerButton = {
        let button = CustomPlayerButton(image: "play.fill") {
            self.play()
        }
        return button
    }()
    
    private lazy var pauseButton: CustomPlayerButton = {
        let button = CustomPlayerButton(image: "pause.fill") {
            self.pause()
        }
        return button
    }()
    
    private lazy var stopButton: CustomPlayerButton = {
        let button = CustomPlayerButton(image: "stop.fill") {
            self.stop()
        }
        return button
    }()
    
    private lazy var nextButton: CustomPlayerButton = {
        let button = CustomPlayerButton(image: "forward.fill") {
            self.playNext()
        }
        return button
    }()
    
    private lazy var previousButton: CustomPlayerButton = {
        let button = CustomPlayerButton(image: "backward.fill") {
            self.playPrevious()
        }
        return button
    }()
    
    private lazy var playerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.toAutoLayout()
        return stackView
    }()
    
    private let trackNameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.textColor = CustomColors.setColor(style: .textColor)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 27, weight: .semibold)
        label.toAutoLayout()
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = CustomColors.setColor(style: .textColor)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.toAutoLayout()
        return label
    }()
    
    private let albumCover: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    private lazy var trackInfoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 50
        stackView.alignment = .center
        stackView.toAutoLayout()
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        prepareToPlay()
        setupUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
//        player.stop()
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.playNext()
    }
    
    private func prepareToPlay() {
        
        let track = tracklist[position]
        albumCover.image = track.albumCover
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
        let url = Bundle.main.url(forResource: track.fileID, withExtension: "mp3")!
        
        do {
            AudioPlayerViewController.player = try AVAudioPlayer(contentsOf: url)
            AudioPlayerViewController.player.prepareToPlay()
            AudioPlayerViewController.player.play()
        }
        catch {
            print(error)
        }
    }
    
    private func setupUI(){
        view.backgroundColor = CustomColors.setColor(style: .backgroundColor)
        view.addSubviews(trackInfoStack, playerStack)
        trackInfoStack.addArrangedSubview(albumCover)
        trackInfoStack.addArrangedSubview(trackNameLabel)
        trackInfoStack.addArrangedSubview(artistNameLabel)
        playerStack.addArrangedSubview(previousButton)
        playerStack.addArrangedSubview(playButton)
        playerStack.addArrangedSubview(pauseButton)
        playerStack.addArrangedSubview(stopButton)
        playerStack.addArrangedSubview(nextButton)
        
        let constraints = [
            trackInfoStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackInfoStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            trackInfoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            trackInfoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            albumCover.widthAnchor.constraint(equalToConstant: 300),
            albumCover.heightAnchor.constraint(equalToConstant: 300),
            
            playerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerStack.topAnchor.constraint(equalTo: trackInfoStack.bottomAnchor, constant: 50),
            playerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            playerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            previousButton.widthAnchor.constraint(equalToConstant: 20),
            playButton.widthAnchor.constraint(equalToConstant: 20),
            pauseButton.widthAnchor.constraint(equalToConstant: 20),
            stopButton.widthAnchor.constraint(equalToConstant: 20),
            nextButton.widthAnchor.constraint(equalToConstant: 20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func play() {
        if AudioPlayerViewController.player.isPlaying {
            print("Already playing!")
        } else {
            AudioPlayerViewController.player.play()
        }
    }
    
    private func pause() {
        if AudioPlayerViewController.player.isPlaying {
            AudioPlayerViewController.player.pause()
        } else {
            print("Already paused!")
        }
    }
    
    private func stop() {
        AudioPlayerViewController.player.stop()
        AudioPlayerViewController.player.currentTime = 0.0
    }
    
    private func playNext() {
        if position + 1 < tracklist.count {
            position += 1
            prepareToPlay()
            play()
        } else {
            position = 0
            prepareToPlay()
            play()
        }
    }
    
    private func playPrevious(){
        if position != 0 {
            position -= 1
            prepareToPlay()
            play()
        } else {
            position = tracklist.count - 1
            prepareToPlay()
            play()
        }
    }
}
