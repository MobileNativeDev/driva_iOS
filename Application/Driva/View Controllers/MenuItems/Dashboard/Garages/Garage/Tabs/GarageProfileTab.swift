//
//  GarageProfileTab.swift
//  Driva
//
//  Created by iDeveloper on 14.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class GarageProfileTab: UIView {

  var _description: String = "" {
    didSet { txtDescription.text = _description }
  }
  
  //MARK: - IBOutlets

  @IBOutlet private weak var txtDescription: UITextView!
  
  //MARK: -
  
  static func instantiate() -> GarageProfileTab? {
    return UINib(nibName: "GarageProfileTab", bundle: nil).instantiate(withOwner: nil, options: nil).first as? GarageProfileTab
  }
}
