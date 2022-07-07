//
//  ColorExtension.swift
//  Navigation
//
//  Created by Iuliia Volkova on 07.07.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

extension UIColor {
  static var appTintColor: UIColor = {
      if #available(iOS 13, *) {
          return UIColor { (traitCollection: UITraitCollection) -> UIColor in
              if traitCollection.userInterfaceStyle == .dark {
                  return UIColor(red: 1.0, green: 0, blue: 0.0, alpha: 1.0) // Темный цвет из палитры
              } else {
                  return UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0) // Светлый цвет из палитры
              }
          }
      } else {
          return UIColor.systemBlue // Цвет по умолчанию
      }
  }()

  static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
      guard #available(iOS 13.0, *) else {
          return lightMode
      }
      return UIColor { (traitCollection) -> UIColor in
          return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
      }
  }
}
