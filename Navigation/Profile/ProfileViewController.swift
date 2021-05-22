//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 22.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let header: ProfileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Изменить цвет фона
        view.backgroundColor = .lightGray
        // Добавить экземпляр класса ProfileHeaderView как subview
        view.addSubview(header)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Задать frame, равный frame корневого view
        header.frame = view.frame
    }

}
