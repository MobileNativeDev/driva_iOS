//
//  MenuCell.swift
//  Driva
//
//  Created by iDeveloper on 15.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
  static let identifier = "MenuCell"
  
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

}
