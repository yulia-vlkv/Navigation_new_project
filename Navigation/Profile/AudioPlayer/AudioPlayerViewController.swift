//
//  AudioPlayerViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 17.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import AVFoundation
import UIKit

class AudioPlayerViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    
    init(coordinator: ProfileCoordinator){
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var player = AVAudioPlayer()
    
    private lazy var playButton: CustomPlayerButton = {
        let button = CustomPlayerButton(image: "play.fill") {
            if self.player.isPlaying {
                print("Already playing!")
            } else {
                self.player.play()
            }
        }
        return button
    }()
    
    private lazy var pauseButton: CustomPlayerButton = {
        let button = CustomPlayerButton(image: "pause.fill") {
            if self.player.isPlaying {
                self.player.pause()
            } else {
                print("Already paused!")
            }
        }
        return button
    }()
    
    private lazy var stopButton: CustomPlayerButton = {
        let button = CustomPlayerButton(image: "stop.fill") {
            self.player.stop()
            self.player.currentTime = 0.0
        }
        return button
    }()
    
    private lazy var nextButton: CustomPlayerButton = {
        let button = CustomPlayerButton(image: "forward.fill") {
            print("next track")
        }
        return button
    }()
    
    private lazy var previousButton: CustomPlayerButton = {
        let button = CustomPlayerButton(image: "backward.fill") {
            print("next track")
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
        label.text = "Puppet Loosely Strung"
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 27, weight: .semibold)
        label.toAutoLayout()
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "The Correspondents"
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.toAutoLayout()
        return label
    }()
    
    private let albumCover: UIImageView = {
        let image = UIImageView(image: UIImage(named: "theCorrespondents"))
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
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Music"
        navigationController?.navigationBar.topItem?.title = "Back"
        
        prepareToPlay()
        setupUI()
    }
    
    
    private func prepareToPlay() {
        do {
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "PuppetLooselyStrung_theCorrespondents", ofType: "mp3")!))
            player.prepareToPlay()
        }
        catch {
            print(error)
        }
    }
    
    private func setupUI(){
        view.backgroundColor = UIColor(named: "mint")
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
}
