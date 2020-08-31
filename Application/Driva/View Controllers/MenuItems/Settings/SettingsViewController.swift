//
//  SettingsViewController.swift
//  Driva
//
//  Created by iDeveloper on 16.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController, SideMenuItemContent {
  var presenter: SettingsPresenter?
 
  //MARK: -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if presenter == nil {
      SettingsConfigurator.configure(self)
    }
    presenter?.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.leftBarButtonItem?.tintColor = .black
  }
  
  //MARK: - Actions
  
  @IBAction private func btnLeftNavigationPressed(_ sender: UIBarButtonItem) {
    presenter?.leftNavigationAction()
  }
  
  @IBAction private func btnUpgradePressed(_ sender: UIButton) {
    presenter?.upgradeAction()
  }
  
  @IBAction private func btnSavePressed(_ sender: UIButton) {
    //TODO: save action
  }
}

//MARK: - SettingsView
extension SettingsViewController: SettingsView {
  static func instantiate() -> SettingsViewController? {
    return UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
  }
  
  func showMenuButton() {
    let barItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(btnLeftNavigationPressed(_:)))
    barItem.image = #imageLiteral(resourceName: "navigation_bar_icon_menu")
    barItem.tintColor = .black
    navigationItem.leftBarButtonItem = barItem
  }
}
