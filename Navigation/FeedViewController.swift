//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService

final class FeedViewController: UIViewController {
    
    let post: Post = Post(title: "Пост")
    static let correctWord = "correct"
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    static private let guessWordTextField: UITextField = {
        let textField = CustomTextField(
            font: UIFont.systemFont(ofSize: 18, weight: .light),
            textColor: UIColor.systemBlue,
            backgroundColor: .lightGray,
            placeholder: "Guess the word")
        textField.layer.cornerRadius = 15
        return textField
    } ()
    
    private let checkButton: UIButton = {
        let button = CustomButton(
            title: "CHECK",
            titleColor: .lightGray,
            backgroungColor: UIColor.systemBlue,
            backgroungImage: nil,
            cornerRadius: 15) {
                if  guessWordTextField.text == correctWord {
                    print("YEY!")
                }
            }
        return button
    } ()
    
    @objc func checkTheWord(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupFeedViews()
    }
    
    private func setupFeedViews() {
        
    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print(type(of: self), #function)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print(type(of: self), #function)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print(type(of: self), #function)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        print(type(of: self), #function)
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        print(type(of: self), #function)
//    }
//
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        print(type(of: self), #function)
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        print(type(of: self), #function)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "post" else {
//            return
//        }
//        guard let postViewController = segue.destination as? PostViewController else {
//            return
//        }
//        postViewController.post = post
//    }
}
