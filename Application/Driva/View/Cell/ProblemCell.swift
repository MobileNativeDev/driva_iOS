//
//  ProblemCell.swift
//  Driva
//
//  Created by iDeveloper on 07.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class ProblemCell: UITableViewCell {
  static let identifier = "ProblemCell"
  
  var isSelectionAvailable: Bool = false {
    didSet { contentView.layoutIfNeeded() }
  }
  
  var selectionStatus: Bool = false {
    didSet { imgSelection.image = selectionStatus ? #imageLiteral(resourceName: "icon_checkbox_on") : #imageLiteral(resourceName: "icon_checkbox_off") }
  }
  
  var icon: UIImage? {
    set { imgIcon.image = newValue }
    get { return imgIcon.image }
  }
  
  var category: String? {
    set { lblCategory.text = newValue }
    get { return lblCategory.text }
  }
  
  var info: String? {
    set { lblInfo.text = newValue }
    get { return lblInfo.text }
  }
  
  var selectProblemAction: ((Bool) -> ())?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var cnstrSelectionSpaceLeading: NSLayoutConstraint!
  @IBOutlet private weak var selectionSpace: UIView!
  @IBOutlet private weak var imgSelection: UIImageView!
  @IBOutlet private weak var imgIcon: UIImageView!
  @IBOutlet private weak var lblCategory: UILabel!
  @IBOutlet private weak var lblInfo: UILabel!
  
  //MARK: -
  
  override func layoutSubviews() {
    cnstrSelectionSpaceLeading.constant = isSelectionAvailable ? 0 : selectionSpace.bounds.width
    super.layoutSubviews()
  }
  
  //MARK: - Actions
  
  @IBAction private func btnSelectPressed(_ sender: UIButton) {
    selectionStatus = !selectionStatus
    selectProblemAction?(selectionStatus)
  }
}
