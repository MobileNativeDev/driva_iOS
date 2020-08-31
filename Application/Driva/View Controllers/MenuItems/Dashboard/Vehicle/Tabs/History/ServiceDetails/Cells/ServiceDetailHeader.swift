//
//  ServiceDetailHeader.swift
//  Driva
//
//  Created by iDeveloper on 27.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class ServiceDetailHeader: UIView {

  var title: String? {
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var lblTitle: UILabel!

  //MARK: -
  
  static func instantiate() -> ServiceDetailHeader? {
    return UINib(nibName: "ServiceDetailHeader", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ServiceDetailHeader
  }
}
