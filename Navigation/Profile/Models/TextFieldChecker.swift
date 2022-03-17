//
//  CheckTextField.swift
//  Navigation
//
//  Created by Iuliia Volkova on 24.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class TextFieldChecker {

    private let correctWord = "агглютинация"
    
//    func check(word: String, completion: (Result) -> Void ) {
//        if word == "" {
//            completion(.empty)
//        } else if word == correctWord {
//            completion(.correct)
//        } else {
//            completion(.incorrect)
//        }
//    }
    func check(word: String, completion: @escaping (Result<CheckerResult,CheckerError>) -> Void ) {
        if word == correctWord {
            completion(.success(.correct))
        } else if word == "" {
            completion(.failure(.empty))
        } else {
            completion(.failure(.incorrect))
        }
        
//        if word == "" {
//            completion(.empty)
//        } else if word == correctWord {
//            completion(.correct)
//        } else {
//            completion(.incorrect)
//        }
    }
}

enum CheckerResult {
    case correct
//    case incorrect
//    case empty
}

enum CheckerError: Error {
    case empty
    case incorrect
}
