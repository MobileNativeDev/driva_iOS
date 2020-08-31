//
//  PlateNumberField.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

@IBDesignable
class PlateNumberField: UITextField {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    updateView()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    updateView()
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    updateView()
  }
  
  func updateView() {
    placeholder = Literal.placeholder.plateNumber
    textAlignment = .center
    
    layer.cornerRadius = 4
    layer.borderWidth = 1
    layer.borderColor = UI.Color.lightGray.cgColor
    clipsToBounds = true
    
    leftViewMode = .always
    
    let view = UIView(frame: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height))
    view.backgroundColor = UI.Color.darkBlue
    leftView = view
  }
}
