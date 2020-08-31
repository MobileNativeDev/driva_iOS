//
//  FirstViewController.swift
//  Driva
//
//  Created by Charlyn Keating on 8/6/18.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class VehicleViewController: UIViewController, SideMenuItemContent {
  var presenter: VehiclePresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var vehiclesRootContainer: UIView!
  @IBOutlet private weak var vehiclesEmptyView: UIView!
  @IBOutlet private weak var statisticEmptyView: UIView!
  
  @IBOutlet private weak var clvVehicles: UICollectionView!
  @IBOutlet private weak var tabsContainer: UIView!
  @IBOutlet private weak var vehicleTabBar: VehicleTabBar!
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    VehicleConfigurator.configure(self)
    presenter?.viewDidLoad()
    setupUI()
    setupKeyboardObservers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter?.viewWillAppear()
  }
  
  deinit {
    removeObservers()
  }
  
  //MARK: -
  
  private func setupUI() {
    if let item = vehicleTabBar.items?.first {
      vehicleTabBar.selectedItem = item
      tabBar(vehicleTabBar, didSelect: item)
    }
  }
  
  private func setupKeyboardObservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
  }
  
  private func removeObservers() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func keyboardWillShow(_ notification: Notification) {
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      if view.frame.origin.y == 0 {
        view.frame.origin.y -= keyboardSize.height
      }
    }
  }
  
  @objc func keyboardWillHide(_ notification: Notification) {
    if view.frame.origin.y != 0 {
      view.frame.origin.y = 0
    }
  }
  
  //MARK: - Actions
  
  @IBAction private func btnMenuPressed(_ sender: UIBarButtonItem) {
    presenter?.menuAction()
  }
  
  @IBAction private func btnAddPressed(_ sender: UIBarButtonItem) {
    presenter?.addVehicleAction()
  }
  
  @IBAction private func btnNextPressed(_ sender: UIButton) {
//    presenter?.nextVehicleAction()
  }
  
  @IBAction private func btnPrevPressed(_ sender: UIButton) {
//    presenter?.previousVehicleAction()
  }
  
  @IBAction private func btnAddVehiclePressed(_ sender: UIButton) {
    presenter?.addVehicleAction()
  }
  
  //MARK: -
  
  private func openTab(_ tab: VehicleTab) {
    var _tabView: UIView?
    
    switch tab {
    case .statistic:
      let statisticTab = StatisticTab.instantiate()
      if let stats = presenter?.vehicle?.vehicleStats {
        statisticTab?.stats = stats
      }
      _tabView = statisticTab
    case .aid:
      let problemTab = ProblemTab.instantiate()
      if let problems = presenter?.vehicle?.problems {
        problemTab?.problems = problems
        problemTab?.problemSelection = { [weak self] problem in
          self?.presenter?.problemSelected(problem)
        }
      }
      _tabView = problemTab
    case .history:
      let historyTab = VehicleHistoryTab.instantiate()
      if let history = presenter?.vehicle?.history {
        historyTab?.history = history
        historyTab?.serviceSelection = { [weak self] service in
          self?.presenter?.serviceSelected(service)
        }
      }
      _tabView = historyTab
    case .profile:
      let profileTab = ProfileTab.instantiate()
      profileTab?.vcView = self.view
      if let profile = presenter?.vehicle?.profile {
        profileTab?.profile = profile
      }
      _tabView = profileTab
    }
    
    guard let tabView = _tabView else { return }
    
    tabsContainer.subviews.forEach({ $0.removeFromSuperview() })
    tabsContainer.addSubview(tabView)
    tabView.fillParentWithContraints()
    tabsContainer.layoutIfNeeded()
  }
}

//MARK: - VehicleView
extension VehicleViewController: VehicleView {
  static func instantiate() -> VehicleViewController? {
    let storyboard = UIStoryboard(name: "Vehicle", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "VehicleViewController") as? VehicleViewController
  }
  
  func showVehicle(with index: Int) {
    clvVehicles.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
  }
  
  func showEmptyVehiclesView(_ show: Bool) {
    vehiclesRootContainer.isHidden = show
    vehiclesEmptyView.isHidden = !show
  }
  
  func showEmptyStatisticsView(_ show: Bool) {
    statisticEmptyView.isHidden = !show
    
  }
  
  func reloadVehicles() {
    clvVehicles.reloadData()
  }

  func reloadTab(_ tab: VehicleTab) {
    switch tab {
    case .statistic:
      if let statisticsTab = tabsContainer.subviews.first(where: { $0 is StatisticTab }) as? StatisticTab,
        let stats = presenter?.vehicle?.vehicleStats {
        statisticsTab.stats = stats
      }
    case .aid:
      if let problemTab = tabsContainer.subviews.first(where: { $0 is ProblemTab }) as? ProblemTab,
        let problems = presenter?.vehicle?.problems {
        problemTab.problems = problems
      }
    case .history:
      if let historyTab = tabsContainer.subviews.first(where: { $0 is VehicleHistoryTab }) as? VehicleHistoryTab,
        let history = presenter?.vehicle?.history {
        historyTab.history = history
      }
    case .profile:
      if let profileTab = tabsContainer.subviews.first(where: { $0 is ProfileTab }) as? ProfileTab,
        let profile = presenter?.vehicle?.profile {
        profileTab.profile = profile
      }
    }
  }
  
  func showTab(_ tab: VehicleTab) {
    openTab(tab)
  }
}


//MARK: - UICollectionViewDataSource
extension VehicleViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter?.numberOfVehicles ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VehicleCell.identifier, for: indexPath) as! VehicleCell
    presenter?.configure(cell, for: indexPath.item)
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension VehicleViewController: UICollectionViewDelegate {
  
}

//MARK: - UICollectionViewDelegateFlowLayout
extension VehicleViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    let contentInsets = collectionView.contentInset
    let sectionInsets = layout.sectionInset
    
    let cellWidth = collectionView.bounds.width - contentInsets.left - sectionInsets.left - sectionInsets.right - contentInsets.right
    let cellHeight = collectionView.bounds.height - contentInsets.top - sectionInsets.top - sectionInsets.bottom - contentInsets.bottom
    
    return CGSize(width: cellWidth, height: cellHeight)
  }
}

//MARK: - UITabBarDelegate
extension VehicleViewController: UITabBarDelegate {
  func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    guard let vehicleTabBar = tabBar as? VehicleTabBar else { return }
    
    let tab = VehicleTab(rawValue: item.tag) ?? .statistic
    guard tab != vehicleTabBar.selectedTab else { return }
    vehicleTabBar.selectedTab = tab
    
    presenter?.tabSelected(tab)
  }
  
}












