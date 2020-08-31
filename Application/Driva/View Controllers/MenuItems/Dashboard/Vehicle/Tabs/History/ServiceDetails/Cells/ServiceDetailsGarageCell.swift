//
//  ServiceDetailsGarageCell.swift
//  Driva
//
//  Created by iDeveloper on 24.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class ServiceDetailsGarageCell: UITableViewCell {
  static let identifier = "ServiceDetailsGarageCell"
  
  var logo: UIImage? {
    set { imgLogo.image = newValue }
    get { return imgLogo.image }
  }
  
  var title: String? {
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  var address: String? {
    set { lblAddress.text = newValue }
    get { return lblAddress.text }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgLogo: UIImageView!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblAddress: UILabel!
}
