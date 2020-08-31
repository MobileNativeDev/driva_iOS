//
//  AddVehicleRouter.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class AddVehicleRouterImplementation {
  private weak var view: AddVehicleViewController?
  
  init(view: AddVehicleViewController) {
    self.view = view
  }
}

//MARK: - AddVehicleRouter
extension AddVehicleRouterImplementation: AddVehicleRouter {
  func success(with vehicle: Vehicle) {
    if let addVehicleNavigation = view?.navigationController as? AddVehicleNavigationController {
      addVehicleNavigation.successfullyCompletion?(vehicle)
    }
    
    guard let successfullyController = SuccessfullViewController.instantiate() else { return }
    successfullyController.vehicle = vehicle
    view?.navigationController?.show(successfullyController, sender: self)
  }
}

