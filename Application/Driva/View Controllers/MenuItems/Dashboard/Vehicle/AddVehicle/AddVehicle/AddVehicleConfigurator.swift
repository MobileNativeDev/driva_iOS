//
//  AddVehicleConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class AddVehicleConfigurator {
  static func configure(_ view: AddVehicleViewController, with vehicle: Vehicle) {
    let router = AddVehicleRouterImplementation(view: view)
    let presenter = AddVehiclePresenterImplementation(view: view, router: router, with: vehicle)
    
    view.presenter = presenter
  }
}



