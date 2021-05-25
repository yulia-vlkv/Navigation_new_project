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
    private var statusText: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Добавляем UI-элементы
        addSubview(profileImage)
        addSubview(userName)
        addSubview(userStatus)
        addSubview(statusButton)
        addSubview(statusField)
        
        setUI()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        // Наводим красоту в UI-элементах
        // Красота для progileImage
        profileImage.image = UIImage(named: "angryCat")
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.clipsToBounds = true
        
        // Красота для userName
        userName.text = "Gavryusha the Cat"
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        userName.textColor = .black

        // Красота для userStatus
        userStatus.text = "pew pew madafakas"
        userStatus.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        userStatus.textColor = .gray

        // Красота для statusButton
        statusButton.setTitle("Set status", for: .normal)
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        statusButton.layer.cornerRadius = 14
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowOpacity = 0.7
        // Обработка нажатия на кнопку
        statusButton.addTarget(self, action: #selector(isPressed), for: .touchUpInside)
        
        // Красота для statusField
        statusField.layer.backgroundColor = UIColor.white.cgColor
        statusField.layer.borderWidth = 1
        statusField.layer.borderColor = UIColor.black.cgColor
        statusField.layer.cornerRadius = 12
        statusField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusField.textColor = .black
        statusField.textAlignment = .natural
        statusField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: statusField.frame.height))
        statusField.leftViewMode = .always
        // На макете не видно, есть ли placeholder, но я добавила
        statusField.placeholder = "Today I feel like..."
        statusField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
    
    }
    
    override func layoutSubviews() {
        // Считаем фреймы
        profileImage.frame = CGRect(x: self.safeAreaInsets.left + 16, y: self.safeAreaInsets.top + 16, width: 110, height: 110)
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        userName.frame = CGRect(x: profileImage.frame.maxX + 16, y: self.safeAreaInsets.top + 27, width: self.frame.width - self.safeAreaInsets.left - self.safeAreaInsets.right - 48 - profileImage.frame.maxX, height: 20)
        userStatus.frame = CGRect(x: profileImage.frame.maxX + 16, y: self.safeAreaInsets.top + 27 + userName.frame.height + 16, width: self.frame.width - self.safeAreaInsets.left - self.safeAreaInsets.right - profileImage.frame.maxX - 48, height: 14)
        statusButton.frame = CGRect(x: self.safeAreaInsets.left + 16, y: profileImage.frame.maxY + 16, width: self.bounds.width - self.safeAreaInsets.left - self.safeAreaInsets.right - 32, height: 50)
        statusField.frame = CGRect(x: profileImage.frame.maxX + 16, y: statusButton.frame.minY - 16 - statusField.frame.height, width: self.frame.width - self.safeAreaInsets.left - self.safeAreaInsets.right - 48 - profileImage.frame.width, height: 40)
    }
    
    // Функция для обработки нажатия на кнопку
    @objc func isPressed() {
        // Меняем текст
        userStatus.text = statusText
        // Выводим новый статус
        print(userStatus.text == "" ? "No status set" : userStatus.text!)
    }
    
    // Функция для нового статуса
    @objc func statusTextChanged(_ textField: UITextField) {
        // Передаем текст из statusField переменной
        statusText = String(textField.text!)
    }
    
}
