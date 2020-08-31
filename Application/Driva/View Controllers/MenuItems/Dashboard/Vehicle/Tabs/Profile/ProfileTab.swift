//
//  ProfileTab.swift
//  Driva
//
//  Created by iDeveloper on 07.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class ProfileTab: UIView {
 
  var vcView: UIView?
  var profile: VehicleProfile? {
    didSet {
      profileFields.forEach {
        if let field = ProfileField(rawValue: $0.tag) {
          $0.text = profile?.text(from: field)
        }
      }
    }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var tabScrollView: UIScrollView!
  
  @IBOutlet private weak var fieldsSuperview: UIView!
  @IBOutlet private weak var fieldsContainer: UIView! {
    didSet {
      fieldsContainer.layer.cornerRadius = 4
      fieldsContainer.layer.borderWidth = 1
      fieldsContainer.layer.borderColor = UI.Color.lightGray.cgColor
    }
  }
  @IBOutlet private var profileFields: [UITextField]!
  
  //MARK: -
  
  static func instantiate() -> ProfileTab? {
    return UINib(nibName: "ProfileTab", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ProfileTab
  }

  //MARK: - Actions
  
  @IBAction private func btnDeletePressed(_ sender: UIButton) {
    //TODO: delete vehicle action
  }
  
  @IBAction private func fieldChanged(_ sender: UITextField) {
    if let field = ProfileField(rawValue: sender.tag) {
      profile?.changeField(field, with: sender.text)
    }
  }
}









