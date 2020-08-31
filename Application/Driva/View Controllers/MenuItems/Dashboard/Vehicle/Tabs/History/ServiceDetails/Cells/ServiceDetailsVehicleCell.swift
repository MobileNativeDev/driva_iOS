//
//  ServiceDetailsVehicleCell.swift
//  Driva
//
//  Created by iDeveloper on 24.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class ServiceDetailsVehicleCell: UITableViewCell {
  static let identifier = "ServiceDetailsVehicleCell"

  var picture: UIImage? {
    set { imgPicture.image = newValue }
    get { return imgPicture.image }
  }
  
  var title: String? {
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  var number: String? {
    set { lblNumber.text = newValue }
    get { return lblNumber.text }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgPicture: UIImageView!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblNumber: UILabel!
  
  //MARK: -
  
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
  }
}
