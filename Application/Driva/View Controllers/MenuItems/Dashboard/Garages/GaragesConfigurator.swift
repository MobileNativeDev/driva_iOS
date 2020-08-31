//
//  GaragesConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 10.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class GaragesConfigurator {
  static func configure(_ view: GaragesViewController) {
    let router = GaragesRouterImplementation(view: view)
    let presenter = GaragesPresenterImplementation(view: view, router: router)
    
    view.presenter = presenter
  }
}
