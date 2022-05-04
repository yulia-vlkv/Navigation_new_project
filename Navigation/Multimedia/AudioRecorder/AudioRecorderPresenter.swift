//
//  AudioRecorderPresenter.swift
//  Navigation
//
//  Created by Iuliia Volkova on 25.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import AVFoundation

class AudioRecorderPresenter {
    
    private weak var view: AudioRecorderViewController?
    private let coordinator: ProfileCoordinator
    
    private var recordingSession = AVAudioSession()
    private var audioRecorder = AVAudioRecorder()
    private var player = AVAudioPlayer()
    
    init(view: AudioRecorderViewController,
         coordinator: ProfileCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func requestRecordPermission(){
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self.view?.loadRecordingUI()
                        self.prepareToRecord()
                    } else {
                        self.view?.loadFailUI()
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func startRecording() {
        if !audioRecorder.isRecording {
            audioRecorder.record()
            print("recording")
        }
    }
    
    private func prepareToRecord(){
        
        let audioFileName = getDocumentsDirectory().appendingPathComponent("recording.m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRecorder.delegate = self.view
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
        } catch {
            print(error)
        }
    }
    
    func finishRecording(success: Bool) {
        if audioRecorder.isRecording {
            audioRecorder.stop()
            print("stop")
        } else if player.isPlaying {
            player.stop()
        }
    }
    
    func playRecording(){
        if !audioRecorder.isRecording {
            do {
                player = try AVAudioPlayer(contentsOf: audioRecorder.url)
                player.prepareToPlay()
                player.play()
                print("playing")
            }
            catch {
                print(error)
            }
        }
    }
}
