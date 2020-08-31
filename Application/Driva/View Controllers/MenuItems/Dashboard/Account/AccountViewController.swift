//
//  SecondViewController.swift
//  Driva
//
//  Created by Charlyn Keating on 8/6/18.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class AccountViewController: UIViewController, SideMenuItemContent {
  var presenter: AccountPresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgPhoto: UIImageView!
  @IBOutlet private weak var lblName: UILabel!
  @IBOutlet private weak var lblNickname: UILabel!
  
  @IBOutlet private weak var accountTabBar: AccountTabBar! {
    didSet {
      accountTabBar.tabSelectedAction = { [weak self] tab in
        self?.openTab(tab)
      }
    }
  }
  @IBOutlet private weak var tabsContainer: UIView!
  
  //MARK: -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    AccountConfigurator.configure(self)
    presenter?.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.backBarButtonItem?.tintColor = .black
  }

  //MARK: -
  
  private func openTab(_ tab: AccountTab) {
    var _tabView: UIView?
    
    switch tab {
    case .favorites:
      _tabView = FavoritesTab.instantiate()
      if let favoritesTab = _tabView as? FavoritesTab, let garages = presenter?.garages {
        configureFavoritesTab(favoritesTab, with: garages)
      }
    case .history:
      _tabView = AccountHistoryTab.instantiate()
      if let historyTab = _tabView as? AccountHistoryTab, let history = presenter?.history {
        configureHistoryTab(historyTab, with: history)
      }
    case .reviews:
      _tabView = ReviewsTab.instantiate()
      if let reviewTab = _tabView as? ReviewsTab, let reviews = presenter?.reviews {
        configureReviewsTab(reviewTab, with: reviews)
      }
    }
    
    tabsContainer.subviews.forEach({ $0.removeFromSuperview() })
    
    guard let tabView = _tabView else { return }
    tabsContainer.addSubview(tabView)
    tabView.fillParentWithContraints()
    tabsContainer.layoutIfNeeded()
  }
  
  private func configureFavoritesTab(_ tab: FavoritesTab, with garages: [GarageShortInfo]) {
    tab.favGarages = garages
    tab.garageSelectedAction = { [weak self] index in
      self?.presenter?.garageSelected(with: index)
    }
  }
  
  private func configureHistoryTab(_ tab: AccountHistoryTab, with history: [GarageHistoryInfo]) {
    tab.history = history
    tab.leaveReviewAction = { [weak self] index in
      self?.presenter?.review(for: index)
    }
  }
  
  private func configureReviewsTab(_ tab: ReviewsTab, with reviews: [Review]) {
    tab.reviews = reviews
  }
  
  //MARK: - Actions
  
  @IBAction private func btnMenuPressed(_ sender: UIBarButtonItem) {
    presenter?.menuAction()
  }
  
  @IBAction private func btnSettingsPressed(_ sender: UIBarButtonItem) {
    presenter?.settingsAction()
  }
}

//MARK: - AccountView
extension AccountViewController: AccountView {
  static func instantiate() -> AccountViewController? {
    let storyboard = UIStoryboard(name: "Account", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController
  }
  
  func showPhoto(_ photo: UIImage) {
    imgPhoto.image = photo
  }
  
  func showName(_ name: String) {
    lblName.text = name
  }
  
  func showNick(_ nick: String) {
    lblNickname.text = nick
  }
  
  func showTab(_ tab: AccountTab) {
    accountTabBar.activeTab = tab
    openTab(tab)
  }
}









