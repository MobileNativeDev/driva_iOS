//
//  ServiceDetailsConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 24.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class ServiceDetailsConfigurator {
  static func configure(_ view: ServiceDetailsViewController, with service: HistoryService) {
    let router = ServiceDetailsRouterImplementation(view: view)
    let presenter = ServiceDetailsPresenterImplementation(view: view, router: router, with: service)
    
    view.presenter = presenter
  }
}
