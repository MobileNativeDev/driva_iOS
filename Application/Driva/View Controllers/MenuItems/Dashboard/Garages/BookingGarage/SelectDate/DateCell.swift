//
//  DateCell.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell {
  static let identifier = "DateCell"
  
  var date: String? {
    set { lblDate.text = newValue }
    get { return lblDate.text }
  }
  
  var today: Bool = false {
    didSet { lblDate.font = today ? UIFont.systemFont(ofSize: 13, weight: .bold) :  UIFont.systemFont(ofSize: 13, weight: .regular) }
  }
  
  var selection: Bool = false {
    didSet {
      selectionView.isHidden = !selection
      lblDate.textColor = selection ? .white : .black
    }
  }
  override var isSelected: Bool {
    didSet { selection = isSelected }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var selectionView: UIView!
  @IBOutlet private weak var lblDate: UILabel!
}
