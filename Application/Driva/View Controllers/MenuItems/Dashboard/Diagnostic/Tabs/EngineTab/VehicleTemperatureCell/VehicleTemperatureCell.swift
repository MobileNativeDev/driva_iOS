//
//  VehicleTemperatureCell.swift
//  Driva
//
//  Created by iDeveloper on 10.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class VehicleTemperatureCell: UICollectionViewCell {
  static let identifier = "VehicleTemperatureCell"
  
  var title: String? {
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  var temperature: String? {
    set { lblTemperature.text = newValue }
    get { return lblTemperature.text }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblTemperature: UILabel!
  
}
