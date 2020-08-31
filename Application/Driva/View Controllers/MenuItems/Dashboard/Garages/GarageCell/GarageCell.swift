//
//  GarageCell.swift
//  Driva
//
//  Created by iDeveloper on 13.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

enum GarageCellState {
  case normal
  case favorite
}

class GarageCell: UICollectionViewCell {
  static let identifier = "GarageCell"
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgContent: UIImageView!
  @IBOutlet private weak var btnFavorite: UIButton!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblAddress: UILabel!
  
  //MARK: -
  
  var imageContent: UIImage? {
    set { imgContent.image = newValue }
    get { return imgContent.image }
  }
  
  var title: String? {
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  var address: String? {
    set { lblAddress.text = newValue }
    get { return lblAddress.text }
  }
  
  var state: GarageCellState = .normal {
    didSet {
      btnFavorite.isHidden = state == .normal
    }
  }
  
  //MARK: -
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    contentView.layer.cornerRadius = 4
    contentView.layer.borderColor = UIColor(white: 0.85, alpha: 1.0).cgColor
    contentView.layer.borderWidth = 1
  }
}
