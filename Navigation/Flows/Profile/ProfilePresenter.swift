//
//  ProfilePresenter.swift
//  Navigation
//
//  Created by Iuliia Volkova on 19.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class ProfilePresenter {
    
    private weak var view: ProfileViewController?
    var coordinator: ProfileCoordinator
    private let userService: UserService
    let userName: String = "" // TODO: ???
    var time = 30
    var timer: Timer?
    
    init(view: ProfileViewController,
         coordinator: ProfileCoordinator,
         userService: UserService
    ){
        self.view = view
        self.coordinator = coordinator
        self.userService = userService
    }
    
    func viewDidLoad() {
        if let user = try? userService.returnUser(userName: userName) {
            self.view?.configure(with: user)
        }
    }
    
    func setupTimer(){
        if timer == nil {
            let timer = Timer.scheduledTimer(timeInterval: 1.0,
                              target: self,
                              selector: #selector(updateTimerLabel),
                              userInfo: time,
                              repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            
            self.timer = timer
        }
    }
    
    @objc func updateTimerLabel(){
        self.view?.profileHeader.timerLabel.text = "Time till break: \(time)"
        time -= 1
        if time < 0 {
            self.view?.profileHeader.timerLabel.text = "Time till break: 0"
            timer?.invalidate()
            timer = nil
            self.view?.showReminderAlert()
        }
    }
    
    @objc func logOut(){
            self.coordinator.logOut()
    }
}
