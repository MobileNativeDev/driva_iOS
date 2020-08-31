//
//  ProblemsConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 23.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class ProblemsConfigurator {
  static func configure(_ view: ProblemsViewController, with problems: [VehicleProblem]) {
    let router = ProblemsRouterImplementation(view: view)
    let presenter = ProblemsPresenterImplementation(view: view, router: router, with: problems)
    
    view.presenter = presenter
  }
}
