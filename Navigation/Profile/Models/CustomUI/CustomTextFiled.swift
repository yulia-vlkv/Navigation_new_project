//
//  CustomTextFiled.swift
//  Navigation
//
//  Created by Iuliia Volkova on 17.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField {

    init(font: UIFont, textColor: UIColor, backgroundColor: UIColor, placeholder: String) {
        super.init(frame: .zero)

        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.placeholder = placeholder
        self.becomeFirstResponder()
        self.autocapitalizationType = .none
        self.returnKeyType = UIReturnKeyType.done
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        self.clipsToBounds = true
        self.toAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
