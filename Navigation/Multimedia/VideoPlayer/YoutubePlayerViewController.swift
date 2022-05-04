//
//  YoutubePlayerViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 18.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit
import YoutubeKit

class YouTubePlayerViewController: UIViewController {

    private var player: YTSwiftyPlayer!
    private let videoID: String

    init(videoID: String) {
        self.videoID = videoID
        super .init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        playVideo()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        player.stopVideo()
    }

    func playVideo() {
        player = YTSwiftyPlayer(frame: CGRect(x: 0, y: 0, width: 640, height: 480),
                                playerVars: [.videoID(videoID)])

        player.autoplay = true
        view = player
        player.delegate = self as? YTSwiftyPlayerDelegate
        player.loadPlayer()
    }
}
