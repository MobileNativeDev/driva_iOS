//
//  GarageGalleryCell.swift
//  Driva
//
//  Created by iDeveloper on 14.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class GarageGalleryCell: UICollectionViewCell {
  static let identifier = "GarageGalleryCell"
  
  var photo: UIImage? {
    set { imgPhoto.image = newValue }
    get { return imgPhoto.image }
  }
  
  //MARK: -
  
  @IBOutlet private weak var imgPhoto: UIImageView!
  
  //MARK: -
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
