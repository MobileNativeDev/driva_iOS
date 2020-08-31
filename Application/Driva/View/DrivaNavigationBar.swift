//
//  DrivaNavigationBar.swift
//  Driva
//
//  Created by iDeveloper on 10.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class DrivaNavigationBar: UINavigationBar {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  private func commonInit() {
    setBackgroundImage(UIImage(), for: .default)
    shadowImage = UIImage()
    isTranslucent = true
    backgroundColor = .clear
    
//    barStyle = .blackTranslucent
//    barTintColor = .clear
  }
}
