//
//  ReviewCell.swift
//  Driva
//
//  Created by iDeveloper on 15.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
  static let identifier = "ReviewCell"
  
  var logo: UIImage? {
    set { imgLogo.image = newValue }
    get { return imgLogo.image }
  }
  
  var title: String? {
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  var address: String? {
    set { lblAddress.text = newValue }
    get { return lblAddress.text }
  }
  
  var rating: Int = 0 {
    didSet {
      setStarsActive(rating)
    }
  }
  
  var review: String? {
    set { lblReview.text = newValue }
    get { return lblReview.text }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgLogo: UIImageView!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblAddress: UILabel!
  @IBOutlet private weak var stckRating: UIStackView!
  @IBOutlet private weak var lblReview: UILabel!
  
  //MARK: -
  
  private func setStarsActive(_ rating: Int) {
    var count = 0
    stckRating.arrangedSubviews.enumerated().forEach({
      $0.element.tintColor = $0.offset >= rating ? .lightGray : UI.Color.darkYellow
      count += 1
    })
  }
}
