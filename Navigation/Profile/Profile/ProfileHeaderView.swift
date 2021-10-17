//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Iuliia Volkova on 22.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    let profileImage: UIImageView = {
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
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = "Gavryusha the Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    let userStatus: UILabel = {
        let label = UILabel()
        label.text = "pew pew madafakas"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.toAutoLayout()
        return label
    }()
    
    private lazy var statusButton: UIButton = {
        let button = CustomButton(title: "Set status", titleColor: .white, backgroungColor: UIColor.systemBlue, backgroungImage: nil, cornerRadius: 14) { [self] in self.userStatus.text = statusText }
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
    
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
    
    private var inset: CGFloat { return 16 }
    private var topInset: CGFloat { return 27 }
    private var userNameHeight: CGFloat { return 20 }
    private var userStatusHeight: CGFloat { return 14 }
    private var statusHeight: CGFloat { return 40 }
    private  var heightAndWidth: CGFloat { return 110 }
    
    private var statusText: String = String()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(profileImage, userName, userStatus, statusButton, statusField)
        
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(inset)
            make.leading.equalToSuperview().inset(inset)
            make.height.width.equalTo(heightAndWidth)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topInset)
            make.leading.equalTo(profileImage.snp.trailing).offset(inset)
            make.trailing.equalToSuperview().inset(inset)
            make.height.equalTo(userNameHeight)
        }
        
        userStatus.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(inset)
            make.leading.equalTo(profileImage.snp.trailing).offset(inset)
            make.trailing.equalToSuperview().inset(inset)
            make.height.equalTo(userStatusHeight)
        }
        
        statusButton.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(inset)
            make.leading.trailing.equalToSuperview().inset(inset)
            make.height.equalTo(statusHeight)
            make.bottom.equalToSuperview().inset(inset)
        }
        
        statusField.snp.makeConstraints { make in
            make.top.equalTo(userStatus.snp.bottom).offset(inset)
            make.leading.equalTo(profileImage.snp.trailing).offset(inset)
            make.trailing.equalToSuperview().inset(inset)
            make.height.equalTo(statusHeight)
        }
    }
    
    // Функция для нового статуса
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = statusField.text ?? "No status"
    }
    
    func showUserData(user: User) {
        userName.text = user.userName
        profileImage.image = user.userImage
        userStatus.text = user.userStatus
    }
}
