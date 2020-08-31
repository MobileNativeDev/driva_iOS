//
//  VehicleConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 07.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class VehicleConfigurator {
  static func configure(_ view: VehicleViewController) {
    let router = VehicleRouterImplementation(view: view)
    let presenter = VehiclePresenterImplementation(view: view, router: router)
    
    view.presenter = presenter
  }
}
