//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Iuliia Volkova on 22.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "angryCat")
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 3
        image.layer.cornerRadius = 55
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.text = "Gavryusha the Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    private let userStatus: UILabel = {
        let label = UILabel()
        label.text = "pew pew madafakas"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.toAutoLayout()
        return label
    }()
    
    private let statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 14
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.toAutoLayout()
        button.addTarget(self, action: #selector(isPressed), for: .touchUpInside)
        return button
    }()
    
    private let statusField: UITextField = {
        let textField = UITextField()
        
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.textAlignment = .natural
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.placeholder = "Today I feel like..."
        textField.toAutoLayout()
        textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private var statusText: String = String()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(profileImage)
        addSubview(userName)
        addSubview(userStatus)
        addSubview(statusButton)
        addSubview(statusField)
        
        let constraints = [
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            profileImage.heightAnchor.constraint(equalToConstant: 110),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),
            
            userName.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            userName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: inset),
            userName.heightAnchor.constraint(equalToConstant: 20),
            userName.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -158),
            
            userStatus.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: inset),
            userStatus.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: inset),
            userStatus.heightAnchor.constraint(equalToConstant: 14),
            userStatus.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -158),
            
            statusButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: inset),
            statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            statusButton.heightAnchor.constraint(equalToConstant: 40),
            statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset),
            
            statusField.topAnchor.constraint(equalTo: userStatus.bottomAnchor, constant: inset),
            statusField.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: inset),
            statusField.heightAnchor.constraint(equalToConstant: 40),
            statusField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -158)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private var inset: CGFloat { return 16 }
    
    // Функция для обработки нажатия на кнопку
    @objc func isPressed() {
        userStatus.text = statusText
    }
    
    // Функция для нового статуса
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = statusField.text ?? "No status"
    }
}
