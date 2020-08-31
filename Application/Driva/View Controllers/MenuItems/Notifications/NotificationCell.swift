//
//  NotificationCell.swift
//  Driva
//
//  Created by iDeveloper on 30.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
  static let identifier = "NotificationCell"
  
  var icon: UIImage? {
    get { return imgIcon.image }
    set { imgIcon.image = newValue }
  }
  
  var title: String? {
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  var _description: String? {
    set { lblDescription.text = newValue }
    get { return lblDescription.text }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgIcon: UIImageView!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblDescription: UILabel!
}
