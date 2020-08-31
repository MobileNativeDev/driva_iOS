//
//  ConnectConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class ConnectConfigurator {
  static func configure(_ view: ConnectViewController) {
    let router = ConnectRouterImplementation(view: view)
    let presenter = ConnectPresenterImplementation(view: view, router: router)
    
    view.presenter = presenter
  }
}
