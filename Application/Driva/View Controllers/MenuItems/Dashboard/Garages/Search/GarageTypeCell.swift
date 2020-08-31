//
//  GarageTypeCell.swift
//  Driva
//
//  Created by iDeveloper on 30.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class GarageTypeCell: UITableViewCell {
  static let identifier = "GarageTypeCell"

  var title: String? {
    get { return lblTitle.text }
    set { lblTitle.text = newValue }
  }
  
  var checked: Bool = false {
    didSet {
      imgCheck.image = checked ? #imageLiteral(resourceName: "icon_checkbox_on") : #imageLiteral(resourceName: "icon_checkbox_off")
    }
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    if selected {
      checked = !checked
    }
  }

  //MARK: - IBOutlets
  
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var imgCheck: UIImageView!
}






