//
//  UpgradeViewController.swift
//  Driva
//
//  Created by iDeveloper on 30.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class UpgradeViewController: UIViewController, SideMenuItemContent {
  
  var navigationMode: NavigationMode = .menuItem
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    showNavigationItem()
  }
  
  @objc private func backAction(_ sender: UIBarButtonItem) {
    close()
  }
  
  @IBAction func btnUpgradePressed(_ sender: UIButton) {
    //TODO: upgrade action
    close()
  }
  
  @IBAction func btnNotPressed(_ sender: UIButton) {
    close()
  }
  
  private func close() {
    
    switch navigationMode {
    case .menuItem:
      showSideMenu()
    case .stackItem:
      if presentingViewController != nil {
        dismiss(animated: true, completion: nil)
      } else {
        navigationController?.popViewController(animated: true)
      }
    }
  }
  
  func showNavigationItem() {
    let barItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(backAction(_:)))
    barItem.image = navigationMode == .menuItem ? #imageLiteral(resourceName: "navigation_bar_icon_menu") : #imageLiteral(resourceName: "Back_icon")
    barItem.tintColor = .black
    navigationItem.leftBarButtonItem = barItem
  }
}

//MARK: - BaseViewController
extension UpgradeViewController: BaseViewController {
  static func instantiate() -> UpgradeViewController? {
    return UIStoryboard(name: "Upgrade", bundle: nil).instantiateViewController(withIdentifier: "UpgradeViewController") as? UpgradeViewController
  }
}
