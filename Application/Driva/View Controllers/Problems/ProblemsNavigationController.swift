//
//  ProblemsNavigationController.swift
//  Driva
//
//  Created by iDeveloper on 23.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class ProblemsNavigationController: UINavigationController {
  static func instantiate(with problems: [VehicleProblem]) -> ProblemsNavigationController? {
    let problemsNavigation =  UIStoryboard(name: "Problems", bundle: nil).instantiateViewController(withIdentifier: "ProblemsNavigationController") as? ProblemsNavigationController
    
    if let problemsController = ProblemsViewController.instantiate() {
      ProblemsConfigurator.configure(problemsController, with: problems)
      problemsNavigation?.setViewControllers([problemsController], animated: false)
    }
    
    return problemsNavigation
  }
}
