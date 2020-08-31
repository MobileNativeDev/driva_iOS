//
//  AccountTabBar.swift
//  Driva
//
//  Created by iDeveloper on 13.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

enum AccountTab: String {
  case favorites = "Favourites"
  case history = "History"
  case reviews = "Reviews"
}

class AccountTabBar: UIView {
  
  var activeTab: AccountTab = .favorites {
    didSet {
      [btnFavorites, btnHistory, btnReviews].forEach({
        $0?.setTitleColor(.lightGray, for: .normal)
        $0?.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
      })
      
      switch activeTab {
      case .favorites:
        btnFavorites.setTitleColor(UI.Color.darkRed, for: .normal)
        btnFavorites.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
      case .history:
        btnHistory.setTitleColor(UI.Color.darkRed, for: .normal)
        btnHistory.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
      case .reviews:
        btnReviews.setTitleColor(UI.Color.darkRed, for: .normal)
        btnReviews.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
      }
      
      setIndicator(to: activeTab)
      tabSelectedAction?(activeTab)
    }
  }
  
  var tabSelectedAction: ((_ tab: AccountTab) -> ())?
  
  weak var selectedTabIndicator: UIView?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var btnFavorites: UIButton!
  @IBOutlet private weak var btnHistory: UIButton!
  @IBOutlet private weak var btnReviews: UIButton!
  
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
  
  private func setIndicator(to tab: AccountTab) {
    guard let indicator = selectedTabIndicator else { return }
    
    var frame: CGRect = .zero
    switch tab {
    case .favorites: frame = btnFavorites.frame
    case .history: frame = btnHistory.frame
    case .reviews: frame = btnReviews.frame
    }
    
    let heigth: CGFloat = 2.0
    frame.origin.y = frame.height - heigth
    frame.size.height = heigth
    
    indicator.frame = frame
  }
  
  //MARK: - Actions
  
  @IBAction private func btnFavoritesPressed(_ sender: UIButton) {
    activeTab = .favorites
  }
  
  @IBAction private func btnHistoryPressed(_ sender: UIButton) {
    activeTab = .history
  }
  
  @IBAction private func btnReviewsPressed(_ sender: UIButton) {
    activeTab = .reviews
  }
}






