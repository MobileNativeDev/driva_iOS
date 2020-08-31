//
//  Constants.swift
//  Driva
//
//  Created by iDeveloper on 14.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit.UIColor

enum Time {
  static let dayInSeconds: TimeInterval = 60 * 60 * 24
}

enum UI {
  enum Color {
    static let darkRed = UIColor(red: 170.0/255.0, green: 46.0/255.0, blue: 38.0/255.0, alpha: 1.0)
    static let darkYellow = UIColor(red: 240.0/255.0, green: 156.0/255.0, blue: 58.0/255.0, alpha: 1.0)
    static let darkBlue = UIColor(red: 59.0/255.0, green: 96.0/255.0, blue: 168.0/255.0, alpha: 1.0)
    static let lightGray = UIColor(white: 0.85, alpha: 1.0)
  }
}

enum Literal {
  enum placeholder {
    static let plateNumber = "Your plate number"
  }
}
