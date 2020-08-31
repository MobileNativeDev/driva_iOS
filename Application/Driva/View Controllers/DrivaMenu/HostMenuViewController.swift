//
//  HostMenuViewController.swift
//  Driva
//
//  Created by iDeveloper on 15.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class HostMenuViewController: MenuContainerViewController {

  override var prefersStatusBarHidden: Bool {
    return false
  }

  //MARK: -
  
  static func instantiate() -> HostMenuViewController {
    return UIStoryboard(name: "DrivaMenu", bundle: nil).instantiateViewController(withIdentifier: "HostMenuViewController") as! HostMenuViewController
  }
  
  //MARK: -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let screenSize: CGRect = UIScreen.main.bounds
    transitionOptions = TransitionOptions(duration: 0.4, visibleContentWidth: screenSize.width / 6)
    
    // Instantiate menu view controller by identifier
    menuViewController = DrivaMenuController.instantiate()
    
    // Gather content items controllers
    contentViewControllers = contentControllers()
    
    // Select initial content controller. It's needed even if the first view controller should be selected.
    selectContentViewController(contentViewControllers.first!)
    
    currentItemOptions.cornerRadius = 10.0
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    
    // Options to customize menu transition animation.
    var options = TransitionOptions()
    
    // Animation duration
    options.duration = size.width < size.height ? 0.4 : 0.6
    
    // Part of item content remaining visible on right when menu is shown
    options.visibleContentWidth = size.width / 6
    self.transitionOptions = options
  }
  
  private func contentControllers() -> [UIViewController] {
    
    var controllers = [UIViewController]()
    //FIXME: inject instantiate to tabbarcontroller & navigation classes
    if let dashboardController = UIStoryboard(name: "Dashboard", bundle: nil).instantiateInitialViewController() as? UITabBarController {
      controllers.append(dashboardController)
    }
    if let bookingController = UIStoryboard(name: "Bookings", bundle: nil).instantiateInitialViewController() as? UINavigationController {
      controllers.append(bookingController)
    }
    if let membershipController = UpgradeNavigationController.instantiate() {
//      membershipController = UIStoryboard(name: "Upgrade", bundle: nil).instantiateInitialViewController() as? UINavigationController {
      controllers.append(membershipController)
    }
    if let settingsController = UIStoryboard(name: "Settings", bundle: nil).instantiateInitialViewController() as? UINavigationController {
      controllers.append(settingsController)
    }
    if let notificationsController = UIStoryboard(name: "Notifications", bundle: nil).instantiateInitialViewController() as? UINavigationController {
      controllers.append(notificationsController)
    }
    
    return controllers
  }
}
