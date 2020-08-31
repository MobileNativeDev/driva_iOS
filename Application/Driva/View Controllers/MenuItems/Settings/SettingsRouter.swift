//
//  SettingsRouter.swift
//  Driva
//
//  Created by iDeveloper on 16.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIApplication

class SettingsRouterImplementation {
  private weak var view: SettingsViewController?
  
  init(view: SettingsViewController) {
    self.view = view
  }
}

//MARK: - SettingsRouter
extension SettingsRouterImplementation: SettingsRouter {
  func showMenu() {
     view?.showSideMenu()
  }
  
  func back() {
    view?.navigationController?.popViewController(animated: true)
  }
  
  func upgrade() {
    guard let upgradeNavigation = UpgradeNavigationController.instantiate(),
      let upgradeController = upgradeNavigation.viewControllers.first as? UpgradeViewController else { return }
    upgradeController.navigationMode = .stackItem
    UIApplication.shared.keyWindow?.rootViewController?.present(upgradeNavigation, animated: true, completion: nil)
  }
}
