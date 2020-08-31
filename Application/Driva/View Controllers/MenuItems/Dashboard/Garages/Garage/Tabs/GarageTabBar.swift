//
//  GarageTabBar.swift
//  Driva
//
//  Created by iDeveloper on 14.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

enum GarageTab: String {
  case profile = "Profile"
  case gallery = "Gallery"
}


class GarageTabBar: UIView {
  
  var activeTab: GarageTab = .profile {
    didSet {
      
      [btnProfile, btnGallery].forEach({
        $0?.setTitleColor(.lightGray, for: .normal)
        $0?.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
      })
      
      
      switch activeTab {
      case .profile:
        btnProfile.setTitleColor(UI.Color.darkRed, for: .normal)
        btnProfile.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
      case .gallery:
        btnGallery.setTitleColor(UI.Color.darkRed, for: .normal)
        btnGallery.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
      }
      
      //170 46 39
      
      setIndicator(to: activeTab)
      tabSelectedAction?(activeTab)
    }
  }
  
  var tabSelectedAction: ((_ tab: GarageTab) -> ())?
  
  weak var selectedTabIndicator: UIView?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var btnProfile: UIButton!
  @IBOutlet private weak var btnGallery: UIButton!
  
  //MARK: -
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  //MARK: -
  
  private func commonInit() {
    let indicator = UIView(frame: .zero)
    indicator.isUserInteractionEnabled = false
    indicator.backgroundColor = UI.Color.darkRed
    
    addSubview(indicator)
    selectedTabIndicator = indicator
  }
  
  private func setIndicator(to tab: GarageTab) {
    guard let indicator = selectedTabIndicator else { return }
    
    var frame: CGRect = .zero
    switch tab {
    case .profile: frame = btnProfile.frame
    case .gallery: frame = btnGallery.frame
    }
    
    let heigth: CGFloat = 2.0
    frame.origin.y = frame.height - heigth
    frame.size.height = heigth
    
    indicator.frame = frame
  }
  
  //MARK: - Actions
  
  @IBAction private func btnProfilePressed(_ sender: UIButton) {
    activeTab = .profile
  }
  
  @IBAction private func btnGalleryPressed(_ sender: UIButton) {
    activeTab = .gallery
  }
}






