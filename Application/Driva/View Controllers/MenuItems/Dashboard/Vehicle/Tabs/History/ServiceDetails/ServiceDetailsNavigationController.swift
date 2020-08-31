//
//  ServiceDetailsNavigationController.swift
//  Driva
//
//  Created by iDeveloper on 27.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class ServiceDetailsNavigationController: UINavigationController {
  static func instantiate() -> ServiceDetailsNavigationController? {
    return UIStoryboard(name: "ServiceDetails", bundle: nil).instantiateViewController(withIdentifier: "ServiceDetailsNavigationController") as? ServiceDetailsNavigationController
  }
}
