//
//  AudioRecorderViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 25.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class AudioRecorderViewController: UIViewController, AVAudioRecorderDelegate {
    
    weak var coordinator: ProfileCoordinator?
    var presenter: AudioRecorderPresenter?
    
    private var recordingSession = AVAudioSession()
    private var audioRecorder = AVAudioRecorder()
    private var player = AVAudioPlayer()
    
    private lazy var recordButton: CustomPlayerButton = {
        let button = CustomPlayerButton(image: "record.circle.fill") {
            self.presenter?.startRecording()
        }
        return button
    }()
    
    private lazy var stopButton: CustomPlayerButton = {
        let button = CustomPlayerButton(image: "stop.fill") {
            self.presenter?.finishRecording(success: true)
        }
        return button
    }()
    
    private lazy var playButton: CustomPlayerButton = {
        let button = CustomPlayerButton(image: "play.fill") {
            self.presenter?.playRecording()
        }
        return button
    }()
    
    private let recorderLabel: UILabel = {
       let label = UILabel()
        label.textColor = CustomColors.setColor(style: .textColor)
        label.text = "Ready to record"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.toAutoLayout()
        return label
    }()
    
    private let noRecorderLabel: UILabel = {
       let label = UILabel()
        label.textColor = CustomColors.setColor(style: .textColor)
        label.text = "Sorry, can't record without permission"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.toAutoLayout()
        return label
    }()
    
    private lazy var recorderStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.toAutoLayout()
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Audio Recorder"
        navigationController?.navigationBar.topItem?.title = "Back"
        navigationController?.navigationBar.tintColor = CustomColors.setColor(style: .textColor)
        
        self.presenter?.requestRecordPermission()
    }
    
    func loadRecordingUI(){
        view.addSubviews(recorderLabel, recorderStack)
        view.backgroundColor = CustomColors.setColor(style: .backgroundColor)
        
        recorderStack.addArrangedSubview(recordButton)
        recorderStack.addArrangedSubview(stopButton)
        recorderStack.addArrangedSubview(playButton)
        
        let constraints = [
            recorderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            recorderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            recorderStack.topAnchor.constraint(equalTo: recorderLabel.bottomAnchor, constant: 50),
            recorderStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recorderStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            recorderStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func loadFailUI(){
        view.addSubview(noRecorderLabel)
        view.backgroundColor = CustomColors.setColor(style: .backgroundColor)
        
        let constraints = [
            noRecorderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noRecorderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
