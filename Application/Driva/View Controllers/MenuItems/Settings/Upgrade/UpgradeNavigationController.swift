//
//  UpgradeNavigationController.swift
//  Driva
//
//  Created by iDeveloper on 30.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class UpgradeNavigationController: UINavigationController {
  
  static func instantiate() -> UpgradeNavigationController? {
    return UIStoryboard(name: "Upgrade", bundle: nil).instantiateViewController(withIdentifier: "UpgradeNavigationController") as? UpgradeNavigationController
  }
}
