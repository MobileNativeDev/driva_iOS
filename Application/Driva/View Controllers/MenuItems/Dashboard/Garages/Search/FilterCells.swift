//
//  FilterCells.swift
//  Driva
//
//  Created by iDeveloper on 29.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

enum FilterCell: Int {
  case radius
  case garageType
  case onCall
  case available
}

class FilterRadiusCell: UITableViewCell {
  static let identifier = "FilterRadiusCell"
  
  var radius: String? {
    get { return lblRadius.text }
    set { lblRadius.text = newValue }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var lblRadius: UILabel!
}

class FilterGarageTypeCell: UITableViewCell {
  static let identifier = "FilterGarageTypeCell"
  
  var type: String? {
    get { return lblType.text }
    set { lblType.text = newValue }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var lblType: UILabel!
}

class FilterCheckCell: UITableViewCell {
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
  
  @IBOutlet private weak var imgCheck: UIImageView!
}

class FilterOnCallCell: FilterCheckCell {
  static let identifier = "FilterOnCallCell"
}

class FilterAvailableCell: FilterCheckCell {
  static let identifier = "FilterAvailableCell"
}







