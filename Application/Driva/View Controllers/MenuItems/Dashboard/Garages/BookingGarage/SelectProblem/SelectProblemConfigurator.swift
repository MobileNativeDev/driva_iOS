//
//  SelectProblemConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class SelectProblemConfigurator {
  static func configure(_ view: SelectProblemViewController) {
    let router = SelectProblemRouterImplementation(view: view)
    let presenter = SelectProblemPresenterImplementation(view: view, router: router)
    
    view.presenter = presenter
  }
}
