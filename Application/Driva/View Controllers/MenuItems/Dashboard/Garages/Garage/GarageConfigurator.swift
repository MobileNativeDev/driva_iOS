//
//  GarageConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 14.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class GarageConfigurator {
  static func configure(_ view: GarageViewController, garage: GarageShortInfo) {
    let router = GarageRouterImplementation(view: view)
    let presenter = GaragePresenterImplementation(view: view, router: router, garage: garage)
    
    view.presenter = presenter
  }
}
