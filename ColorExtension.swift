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
                  return UIColor(red: 0.379, green: 0.584, blue: 0.845, alpha: 1.0)
              } else {
                  return UIColor(red: 0.195, green: 0.296, blue: 0.455, alpha: 1.0)
              }
          }
      } else {
          return UIColor.systemBlue
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
