//
//  Date.swift
//  Driva
//
//  Created by iDeveloper on 29.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

extension Date {
  var weekday: Int {
    return Calendar.current.component(.weekday, from: self)
  }
  
  var firstDayOfTheMonth: Date {
    return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
  }
}
