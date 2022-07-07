//
//  CustomPlayerButton.swift
//  Navigation
//
//  Created by Iuliia Volkova on 17.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

final class CustomPlayerButton: UIButton {
    
    private var buttonAction: () -> Void
    
    init(image: String, buttonAction: @escaping() -> Void) {
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        
        let image = UIImage(systemName: image)
        self.setImage(image, for: .normal)
        self.tintColor = CustomColors.setColor(style: .accentColor)
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.toAutoLayout()
        
        self.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
    }
    
    @objc private func buttonIsTapped() {
        self.buttonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
