//
//  SideMenuItemContent.swift
//  Driva
//
//  Created by iDeveloper on 15.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

/**
 The protocol to indicate item of side menu. Every menu item should adopt this protocol.
 */
public protocol SideMenuItemContent {
  
  /**
   Shows left side menu.
   */
  func showSideMenu()
}

/**
 The extension of SideMenuItemContent protocol implementing `showSideMenu()` method for UIViewController class.
 */
extension SideMenuItemContent where Self: UIViewController {
  
  private func container() -> MenuContainerViewController? {
    if let menuContainerViewController = parent as? MenuContainerViewController {
      return menuContainerViewController
    } else if let navController = parent as? UINavigationController,
      let menuContainerViewController = navController.parent as? MenuContainerViewController {
      return menuContainerViewController
    } else  if let navController = parent as? UINavigationController,
      let tabController = navController.parent as? UITabBarController,
      let menuContainerViewController = tabController.parent as? MenuContainerViewController {
      return menuContainerViewController
    }
    
    return nil
  }
  
  public func openBookings() {
    guard let container = container() else { return }
    
    container.selectContentViewController(container.contentViewControllers[1])
//    container.hideSideMenu()
  }
  
  public func showSideMenu() {
    container()?.showSideMenu()
  }
}
