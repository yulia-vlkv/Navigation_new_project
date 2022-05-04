//
//  FeedPresenter.swift
//  Navigation
//
//  Created by Iuliia Volkova on 19.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

class FeedPresenter {
    private weak var view: FeedController?
    private let coordinator: FeedCoordinator
    private let checker: TextFieldChecker
    
    init(view: FeedController,
         coordinator: FeedCoordinator,
         checker: TextFieldChecker) {
        self.view = view
        self.coordinator = coordinator
        self.checker = checker
    }
    
    func showPost() {
        coordinator.showPost()
    }
    
    func presentPost() {
        coordinator.presentPost()
    }
    
    func performCheck(word: String) {
        checker.check(word: word) { result in
            self.view?.showInputResult(result)
        }
    }
}
