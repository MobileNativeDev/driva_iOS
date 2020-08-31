//
//  SelectDateConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class SelectDateConfigurator {
  static func configure(_ view: SelectDateViewController, date: Date, completion: @escaping ( (Date) -> () )) {
    let router = SelectDateRouterImplementation(view: view)
    let presenter = SelectDatePresenterImplementation(view: view, router: router, with: date, completion: completion)
    
    view.presenter = presenter
  }
}
