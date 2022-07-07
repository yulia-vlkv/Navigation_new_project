//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Iuliia Volkova on 22.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth


class ProfileHeaderView: UIView {

    var logoutHandler: (() -> Void)?
    
    private lazy var logoutButton: CustomButton = {
        let button = CustomButton(
            title: "Log out",
            titleColor: CustomColors.setColor(style: .reverseAccentColor),
            backgroungColor: CustomColors.setColor(style: .accentColor),
            backgroungImage: nil,
            cornerRadius: 15) { [self] in
                self.logoutHandler?()
            }
        return button
    }()

    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Time till break: 0"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = CustomColors.setColor(style: .textColor)
        label.toAutoLayout()
        return label
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "angryCat")
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 3
        image.layer.cornerRadius = 55
        image.layer.borderColor = CustomColors.setColor(style: .accentColor).cgColor
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = "Gavryusha the Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = CustomColors.setColor(style: .textColor)
        label.toAutoLayout()
        return label
    }()
    
    let userStatus: UILabel = {
        let label = UILabel()
        label.text = "pew pew madafakas"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = CustomColors.setColor(style: .textColor)
        label.toAutoLayout()
        return label
    }()
    
    private lazy var statusButton: UIButton = {
        let button = CustomButton(
            title: "Set status",
            titleColor: CustomColors.setColor(style: .reverseAccentColor),
            backgroungColor: CustomColors.setColor(style: .accentColor),
            backgroungImage: nil,
            cornerRadius: 14) 
        { [self] in self.userStatus.text = statusText }
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
    
        return button
    }()
    
    private let statusField: UITextField = {
        let textField = CustomTextField(font: UIFont.systemFont(ofSize: 15, weight: .regular),
                                        placeholder: "Today I feel like...")
        textField.addTarget(ProfileHeaderView.self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private var inset: CGFloat { return 16 }
    private var topInset: CGFloat { return 27 }
    private var userNameHeight: CGFloat { return 20 }
    private var userStatusHeight: CGFloat { return 14 }
    private var statusHeight: CGFloat { return 40 }
    private var heightAndWidth: CGFloat { return 110 }
    private var logOutHeight: CGFloat { return 35 }
    private var logOutWidth: CGFloat { return 80 }
    
    private var statusText: String = String()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(timerLabel, profileImage, userName, userStatus, statusButton, statusField, logoutButton)
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(inset)
            make.leading.equalToSuperview().inset(inset * 2)
            make.height.equalTo(userStatusHeight)
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(inset)
            make.leading.equalToSuperview().inset(inset)
            make.height.width.equalTo(heightAndWidth)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(inset)
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
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(inset)
            make.trailing.equalToSuperview().inset(inset)
            make.height.equalTo(logOutHeight)
            make.width.equalTo(logOutWidth)
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
