//
//  ProblemDetailsConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 23.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class ProblemDetailsConfigurator {
  static func configure(_ view: ProblemDetailsViewController, with problem: VehicleProblem) {
    let router = ProblemDetailsRouterImplementation(view: view)
    let presenter = ProblemDetailsPresenterImplementation(view: view, router: router, with: problem)
    
    view.presenter = presenter
  }
}
