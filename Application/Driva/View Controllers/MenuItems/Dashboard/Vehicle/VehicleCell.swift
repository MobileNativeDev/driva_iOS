//
//  VehicleCell.swift
//  Driva
//
//  Created by iDeveloper on 07.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class VehicleCell: UICollectionViewCell {
  static let identifier: String = "VehicleCell"
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgVehicle: UIImageView!
  @IBOutlet private weak var imgLogo: UIImageView!
  @IBOutlet private weak var lblVehicleTitle: UILabel!
  @IBOutlet private weak var lblVehicleInfo: UILabel!
  
  //MARK: -
  
  var vehicleImage: UIImage? {
    set { imgVehicle.image = newValue }
    get { return imgVehicle.image }
  }
  
  var logo: UIImage? {
    set { imgLogo.image = newValue }
    get { return imgLogo.image }
  }
  
  var title: String? {
    set { lblVehicleTitle.text = newValue }
    get { return lblVehicleTitle.text }
  }
  
  var info: String? {
    set { lblVehicleInfo.text = newValue }
    get { return lblVehicleInfo.text }
  }
}

