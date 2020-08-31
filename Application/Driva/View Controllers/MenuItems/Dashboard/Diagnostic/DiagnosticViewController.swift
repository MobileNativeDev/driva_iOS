//
//  SecondViewController.swift
//  Driva
//
//  Created by Charlyn Keating on 8/6/18.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class DiagnosticViewController: UIViewController, SideMenuItemContent {
  var presenter: DiagnosticPresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var tabsCollectionBar: TabsCollectionBar!
  @IBOutlet private weak var tabsContentView: UIView!
  
  @IBOutlet private weak var adapterEmptyView: UIView!
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    DiagnosticConfigurator.configure(self)
    presenter?.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter?.viewWillAppear()
  }
  
  //MARK: -
  
  private func openTab(_ tab: DiagnosticTab) {
    var _tabView: UIView?
    
    switch tab {
    case .engine:
      _tabView = EngineTab.instantiate()
      if let engineTab = _tabView as? EngineTab {
        configureEngineTab(engineTab)
      }
    case .airCooler: break
    case .fuel: break
    case .suspension: break
    case .battery: break
    case .door: break
    }

    tabsContentView.subviews.forEach({ $0.removeFromSuperview() })
    
    guard let tabView = _tabView else { return }
    tabsContentView.addSubview(tabView)
    tabView.fillParentWithContraints()
    tabsContentView.layoutIfNeeded()
  }
  
  private func configureEngineTab(_ tab: EngineTab) {
    //FIXME: mock
    tab.numberOfProblems = 2
    let temperatures = [
      TemperaturePoint(title: "AIR TEMPERATURE", temperature: 55),
      TemperaturePoint(title: "ENGINE COOLENT", temperature: 113),
      TemperaturePoint(title: "ENGINE COOLENT", temperature: 113)
    ]
    tab.data = temperatures
    tab.detailsAction = { [weak self] in
      self?.presenter?.problemDetailsAction()
    }
  }
  
  //MARK: - Actions
  
  @IBAction private func btnMenuPressed(_ sender: UIBarButtonItem) {
    presenter?.menuAction()
  }
  
  @IBAction private func btnScanPressed(_ sender: UIButton) {
    presenter?.scanAction()
  }
  
  @IBAction private func btnConnectPressed(_ sender: UIButton) {
    presenter?.connectAction()
  }
  
}

//MARK: - DiagnosticView
extension DiagnosticViewController: DiagnosticView {
  static func instantiate() -> DiagnosticViewController? {
    let storyboard = UIStoryboard(name: "Diagnostic", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "DiagnosticViewController") as? DiagnosticViewController
  }
  
  func showEmptyView(_ show: Bool) {
    adapterEmptyView.isHidden = !show
  }
  
  func showTabs(_ tabs: [DiagnosticTab]) {
    tabsCollectionBar.tabs = tabs
    guard let firstTab = tabs.first else { return }
    
    openTab(firstTab)
    tabsCollectionBar.selectTab(firstTab)
    tabsCollectionBar.selectTabAction = { [weak self] tab in
      self?.openTab(tab)
    }
  }
}
