//
//  ServiceDetailsWorkCell.swift
//  Driva
//
//  Created by iDeveloper on 24.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class ServiceDetailsWorkCell: UITableViewCell {
  static let identifier = "ServiceDetailsWorkCell"
  
  var icon: UIImage? {
    set { imgIcon.image = newValue }
    get { return imgIcon.image }
  }
  
  var title: String? {
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgIcon: UIImageView!
  @IBOutlet private weak var lblTitle: UILabel!
  
  //MARK: -
  
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
  }
}
