//
//  SuccessConnectConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class SuccessConnectConfigurator {
  static func configure(_ view: SuccessConnectViewController, with adapter: Adapter, and mode: ScanMode) {
    let router = SuccessConnectRouterImplementation(view: view)
    let presenter = SuccessConnectPresenterImplementation(view: view, router: router, adapter: adapter, mode: mode)
    
    view.presenter = presenter
  }
}
