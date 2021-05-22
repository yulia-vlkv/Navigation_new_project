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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Добавляем UI-элементы
        addSubview(profileImage)
        addSubview(userName)
        addSubview(userStatus)
        addSubview(statusButton)
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
        userName.frame = CGRect(x: profileImage.frame.maxX + 16, y: self.safeAreaInsets.top + 27, width: 300, height: 50)
        userName.text = "Gavryusha the Cat"
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        userName.textColor = .black

//        // Красота для userStatus
//        userStatus.frame = CGRect(x: <#T##Int#>, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>)
//
//        // Красота для statusButton
//        statusButton.frame = CGRect(x: <#T##Int#>, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>)
        
    }


}
