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

final class FeedController: UIViewController {
    
    var presenter: FeedPresenter?

    private lazy var newViewButton: UIButton = {
        let button = CustomButton(
            title: "Show new post",
            titleColor: .white,
            backgroungColor: CustomColors.setColor(style: .accentColor),
            backgroungImage: nil,
            cornerRadius: 15) {
                self.presenter?.showPost()
            }
        return button
    }()

    private lazy var modalViewButton: UIButton = {
        let button = CustomButton(
            title: "Show it modally",
            titleColor: .white,
            backgroungColor: CustomColors.setColor(style: .accentColor),
            backgroungImage: nil,
            cornerRadius: 15) {
                self.presenter?.presentPost()
            }
        return button
    }()
    
    private let guessWordTextField: UITextField = {
        let textField = CustomTextField(
            font: UIFont.systemFont(ofSize: 18, weight: .light),
            placeholder: "Guess the word")
        return textField
    } ()
    
    private lazy var checkButton: UIButton = {
        let button = CustomButton(
            title: "CHECK",
            titleColor: .white,
            backgroungColor: CustomColors.setColor(style: .accentColor),
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
        
        view.backgroundColor = CustomColors.setColor(style: .backgroundColor)
        
        setupFeedViews()
    }
    
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
    
    func showInputResult(_ result: Result<CheckerResult,CheckerError>){
        switch result {
        case .success(.correct):
            checkLabel.backgroundColor = UIColor(named: "green")
            checkLabel.alpha = 1
        case .failure(.incorrect):
            checkLabel.backgroundColor = UIColor(named: "red")
            checkLabel.alpha = 1
        default:
            checkLabel.backgroundColor = .clear
        }
    }

}
