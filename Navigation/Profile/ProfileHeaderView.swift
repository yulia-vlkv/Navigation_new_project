//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Iuliia Volkova on 22.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private let profileImage = UIImageView()
    private let userName = UILabel()
    private let userStatus = UILabel()
    private let statusButton = UIButton()
    private let statusField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Добавляем UI-элементы
        addSubview(profileImage)
        addSubview(userName)
        addSubview(userStatus)
        addSubview(statusButton)
        addSubview(statusField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        // Наводим красоту в UI-элементах
        // Красота для progileImage
        profileImage.image = UIImage(named: "angryCat")
        profileImage.frame = CGRect(x: self.safeAreaInsets.left + 16, y: self.safeAreaInsets.top + 16, width: 110, height: 110)
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        profileImage.clipsToBounds = true
        
        // Красота для userName
        //// self.frame.width - self.safeAreaInsets.left - self.safeAreaInsets.right - 48 - profileImage.frame.maxX
        userName.frame = CGRect(x: profileImage.frame.maxX + 32, y: self.safeAreaInsets.top + 27, width: self.frame.width - self.safeAreaInsets.left - self.safeAreaInsets.right - 48 - profileImage.frame.maxX, height: 20)
        userName.text = "Gavryusha the Cat"
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        userName.textColor = .black

        // Красота для userStatus
        userStatus.frame = CGRect(x: Int(profileImage.frame.maxX) + 32, y: Int(self.safeAreaInsets.top) + 27 + Int(userName.frame.height) + 16, width: Int(self.frame.width - self.safeAreaInsets.left - self.safeAreaInsets.right - profileImage.frame.maxX - 48), height: 14)
        userStatus.text = "pew pew madafakas"
        userStatus.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        userStatus.textColor = .gray

        // Красота для statusButton
        statusButton.frame = CGRect(x: Int(self.safeAreaInsets.left) + 16, y: Int(profileImage.frame.maxY) + 16, width: Int(self.bounds.width - self.safeAreaInsets.left - self.safeAreaInsets.right)  - 32, height: 50)
        statusButton.setTitle("Show status", for: .normal)
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.layer.backgroundColor = UIColor.blue.cgColor
        statusButton.layer.cornerRadius = 14
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowOpacity = 0.7
        // Обработка нажатия на кнопку
        statusButton.addTarget(self, action: #selector(isPressed), for: .touchUpInside)
        
        // Красота для statusField
        statusField.frame = CGRect(x: profileImage.frame.maxX + 32, y: statusButton.frame.minY - 16 - statusField.frame.height, width: self.frame.width - self.safeAreaInsets.left - self.safeAreaInsets.right - 48 - profileImage.frame.maxX, height: 40)
        statusField.layer.backgroundColor = UIColor.white.cgColor
        statusField.layer.borderWidth = 1
        statusField.layer.borderColor = UIColor.black.cgColor
        statusField.layer.cornerRadius = 12
        statusField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusField.textColor = .black
        statusField.textAlignment = .natural
        
    }
    // Функция для обработки нажатия на кнопку
    @objc func isPressed() {
        // Заглушка на случай, если статус не указан
        print(userStatus.text ?? "No status set")
        
    }
    
}
