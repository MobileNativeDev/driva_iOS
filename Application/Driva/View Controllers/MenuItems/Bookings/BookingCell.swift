//
//  BookingCell.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class BookingCell: UITableViewCell {
  static let identifier = "BookingCell"
  
  var avatar: UIImage? {
    set { imgAvatar.image = newValue == nil ? #imageLiteral(resourceName: "Icon-Mechanic") : newValue }
    get { return imgAvatar.image }
  }
  
  var title: String? {
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  var status: String? {
    set { lblStatus.text = newValue }
    get { return lblStatus.text }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgAvatar: UIImageView!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblStatus: UILabel!
}
