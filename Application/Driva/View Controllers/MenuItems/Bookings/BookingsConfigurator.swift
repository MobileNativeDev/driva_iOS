//
//  BookingsConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class BookingsConfigurator {
  static func configure(_ view: BookingsViewController) {
    let router = BookingsRouterImplementation(view: view)
    let presenter = BookingsPresenterImplementation(view: view, router: router)
    
    view.presenter = presenter
  }
}
