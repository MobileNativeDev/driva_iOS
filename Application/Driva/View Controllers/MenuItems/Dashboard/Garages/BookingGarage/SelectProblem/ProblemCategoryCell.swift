//
//  ProblemCategoryCell.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class ProblemCategoryCell: UICollectionViewCell {
  static let identifier = "ProblemCategoryCell"
  
  var categoryImage: UIImage? {
    set { imgCategory.image = newValue }
    get { return imgCategory.image }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgCategory: UIImageView!
  
  override var isSelected: Bool {
    didSet {
      imgCategory.tintColor = isSelected ? UI.Color.darkRed : .darkGray
    }
  }
}
