//
//  SearchVehicleRouter.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class SearchVehicleRouterImplementation {
  private weak var view: SearchVehicleViewController?
  
  init(view: SearchVehicleViewController) {
    self.view = view
  }
}

//MARK: - SearchVehicleRouter
extension SearchVehicleRouterImplementation: SearchVehicleRouter {
  func go(with vehicle: Vehicle) {
    guard let addVehicleController = AddVehicleViewController.instantiate() else { return }
    AddVehicleConfigurator.configure(addVehicleController, with: vehicle)
    view?.navigationController?.show(addVehicleController, sender: self)
  }
  
  func close() {
    view?.navigationController?.dismiss(animated: true, completion: nil)
  }
}

