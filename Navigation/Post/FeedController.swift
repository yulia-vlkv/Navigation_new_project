//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService
import SnapKit

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
            view?.showInputResult(result)
        }
    }
}

final class FeedController: UIViewController {
    
    var presenter: FeedPresenter?
//    weak var coordinator: FeedCoordinator?
    
//    var showPost: (()-> Void)?
//    var presentPost: (()-> Void)?
//
//    private let checker: CheckTextField
//
//    init(checker: CheckTextField) {
//        self.checker = checker
//        super .init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    private lazy var newViewButton: UIButton = {
        let button = CustomButton(
            title: "Show new post",
            titleColor: .white,
            backgroungColor: UIColor.systemBlue,
            backgroungImage: nil,
            cornerRadius: 15) {
                self.presenter?.showPost()
//                self.showPost?()
//                let vc = PostViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
            }
        return button
    }()

    private lazy var modalViewButton: UIButton = {
        let button = CustomButton(
            title: "Show it modally",
            titleColor: .white,
            backgroungColor: UIColor.systemBlue,
            backgroungImage: nil,
            cornerRadius: 15) {
                self.presenter?.presentPost()
//                let vc = InfoViewController()
//                self.navigationController?.present(vc, animated: true, completion: nil)
//                self.presentPost?()
            }
        return button
    }()
    
    private let guessWordTextField: UITextField = {
        let textField = CustomTextField(
            font: UIFont.systemFont(ofSize: 18, weight: .light),
            textColor: UIColor.systemBlue,
            backgroundColor: .white,
            placeholder: "Guess the word")
        textField.layer.cornerRadius = 15
        return textField
    } ()
    
    private lazy var checkButton: UIButton = {
        let button = CustomButton(
            title: "CHECK",
            titleColor: .white,
            backgroungColor: UIColor.systemBlue,
            backgroungImage: nil,
            cornerRadius: 15) { [weak self] in
                if let enteredText = self?.guessWordTextField.text {
                    self?.presenter?.performCheck(word: enteredText)
                }
            }
        return button
    } ()
    
    private let checkLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.toAutoLayout()
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        return label
    } ()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 35
        stackView.alignment = .fill
        stackView.toAutoLayout()
        return stackView
    } ()
    
    private var sideInset: CGFloat { return 40 }
    private var topInset: CGFloat { return 200 }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "mint")
        
        setupFeedViews()
    }
    
//    private func onCompletion() {
//
//        let enteredWord = guessWordTextField.text
//        checker.check(word: enteredWord ?? "") { [weak self] result in
//            switch  result {
//            case .correct:
//                self?.checkLabel.backgroundColor = UIColor(named: "green")
//                self?.checkLabel.alpha = 1
//            case .incorrect:
//                self?.checkLabel.backgroundColor = UIColor(named: "red")
//                self?.checkLabel.alpha = 1
//            default: self?.checkLabel.backgroundColor = .clear
//            }
//        }
//    }
    
    private func setupFeedViews() {
        view.addSubview(buttonsStackView)
        
        buttonsStackView.addArrangedSubview(guessWordTextField)
        buttonsStackView.addArrangedSubview(checkButton)
        buttonsStackView.addArrangedSubview(checkLabel)
        buttonsStackView.addArrangedSubview(newViewButton)
        buttonsStackView.addArrangedSubview(modalViewButton)
        
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(sideInset)
            make.top.equalToSuperview().inset(topInset)
        }
    }
    
    func showInputResult(_ result: Result){
        switch result {
        case .correct:
            checkLabel.backgroundColor = UIColor(named: "green")
            checkLabel.alpha = 1
        case .incorrect:
            checkLabel.backgroundColor = UIColor(named: "red")
            checkLabel.alpha = 1
        default:
            checkLabel.backgroundColor = .clear
        }
    }

}
