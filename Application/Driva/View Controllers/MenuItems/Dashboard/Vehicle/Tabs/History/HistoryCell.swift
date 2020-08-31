//
//  HistoryCell.swift
//  Driva
//
//  Created by iDeveloper on 08.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
  static let identifier = "HistoryCell"
  
  var date: String? {
    set { lblDate.text = newValue }
    get { return lblDate.text }
  }
  
  var title: String? {
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  var fixes = [UIImage]() {
    didSet {
      stckFixes.subviews.forEach({ $0.removeFromSuperview() })
      fixes.forEach({
        let fixView = UIImageView(frame: .zero)
        fixView.contentMode = .scaleAspectFit
        fixView.image = $0
        fixView.tintColor = .lightGray
        
        fixView.translatesAutoresizingMaskIntoConstraints = false
        fixView.addLayoutRatio(1.0)
        
        stckFixes.addArrangedSubview(fixView)
        
        stckFixes.layoutIfNeeded()
        stckFixes.superview?.layoutIfNeeded()
      })
      
    }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var lblDate: UILabel!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var stckFixes: UIStackView!
  
  //MARK: -
  
  
}
