//
//  OnBoardingCell.swift
//  Driva
//
//  Created by iDeveloper on 16.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class OnBoardingCell: UICollectionViewCell {
  static let identifier = "OnBoardingCell"
  
  var image: UIImage? {
    set { imgContent.image = newValue }
    get { return imgContent.image }
  }
  
  var title: String? {
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  var _description: String? {
    set { lblDescription.text = newValue }
    get { return lblDescription.text }
  }
  
  var isStarted: Bool = false {
    didSet {
      btnStarted.isHidden = !isStarted
    }
  }
  
  var startedAction: ( () -> () )?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgContent: UIImageView!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblDescription: UILabel!
  @IBOutlet private weak var btnStarted: UIButton!
  
  //MARK: -
  
  @IBAction private func btnStartedPressed(_ sender: UIButton) {
    startedAction?()
  }
}
