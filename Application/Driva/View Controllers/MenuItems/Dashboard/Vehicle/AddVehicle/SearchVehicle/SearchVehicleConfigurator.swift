//
//  SearchVehicleConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class SearchVehicleConfigurator {
  static func configure(_ view: SearchVehicleViewController) {
    let router = SearchVehicleRouterImplementation(view: view)
    let presenter = SearchVehiclePresenterImplementation(view: view, router: router)
    
    view.presenter = presenter
  }
}



