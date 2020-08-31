//
//  DiagnosticTabCell.swift
//  Driva
//
//  Created by iDeveloper on 10.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class DiagnosticTabCell: UICollectionViewCell {
  static let identifier: String = "DiagnosticTabCell"
  
  var icon: UIImage? {
    set { imgIcon.image = newValue }
    get { return imgIcon.image }
  }
  
  var title: String? {
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  var badgeNeeded: Bool {
    set { badgeView.isHidden = !newValue }
    get { return !badgeView.isHidden }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgIcon: UIImageView!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var badgeView: UIView!
  
  //MARK: -
  
  override var isSelected: Bool {
    didSet {
      imgIcon.tintColor = isSelected ? UI.Color.darkRed : .lightGray
      lblTitle.textColor = isSelected ? UI.Color.darkRed : .black
    }
  }
}

