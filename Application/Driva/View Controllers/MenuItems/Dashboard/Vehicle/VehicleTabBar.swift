//
//  VehicleTabBar.swift
//  Driva
//
//  Created by iDeveloper on 07.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

enum VehicleTab: Int {
  case statistic
  case aid
  case history
  case profile
}

class VehicleTabBar: UITabBar {

  var selectedTab: VehicleTab?
  
  //MARK: -
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  //MARK: -
  
  private func commonInit() {
    shadowImage = UIImage()
    backgroundImage = UIImage()
  }
}
