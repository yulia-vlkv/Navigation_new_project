//
//  CustomButton.swift
//  Navigation
//
//  Created by Iuliia Volkova on 17.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    
    private var buttonAction: () -> Void
    
    init(title: String, titleColor: UIColor, backgroungColor: UIColor?, backgroungImage: UIImage?, cornerRadius: CGFloat, buttonAction: @escaping() -> Void) {
        self.buttonAction = buttonAction
        
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroungColor
        self.setBackgroundImage(backgroungImage, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
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
