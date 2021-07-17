//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Iuliia Volkova on 17.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    let profileView = ProfileHeaderView()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(profileView)
        profileView.toAutoLayout()
        
        let constraints = [
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
