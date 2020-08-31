//
//  GarageHistoryCell.swift
//  Driva
//
//  Created by iDeveloper on 14.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class GarageHistoryCell: UITableViewCell {
  static let identifier = "GarageHistoryCell"
  
  var logo: UIImage? {
    set { imgPhoto.image = newValue }
    get { return imgPhoto.image }
  }
  
  var title: String?{
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  var address: String? {
    set { lblAddress.text = newValue }
    get { return lblAddress.text }
  }
  
  var finishedDate: String? {
    set { lblFinished.text = newValue }
    get { return lblFinished.text }
  }
  
  var leaveReviewAction: (() -> ())?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgPhoto: UIImageView!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblAddress: UILabel!
  @IBOutlet private weak var lblFinished: UILabel!
  
  //MARK: -
  
  @IBAction private func btnReviewPressed(_ sender: UIButton) {
    leaveReviewAction?()
  }
}
