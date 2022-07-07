//
//  CustomColors.swift
//  Navigation
//
//  Created by Iuliia Volkova on 07.07.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

enum CustomColors {
    case backgroundColor
    case accentColor
    case red
    case green
    case textColor
    case reverseTextColor
    case reverseAccentColor
    
    static func setColor (style: CustomColors) -> UIColor {
        switch style {
        case .backgroundColor:
            return UIColor(named: "backgroundColor")!
        case .accentColor:
            return UIColor(named: "accentColor")!
        case .red:
            return UIColor(named: "red")!
        case .green:
            return UIColor(named: "green")!
        case .textColor:
            return UIColor(named: "textColor")!
        case .reverseTextColor:
            return UIColor(named: "reverseTextColor")!
        case .reverseAccentColor:
            return UIColor(named: "reverseAccentColor")!
        }
    }
}
