//
//  SettingsConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 16.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class SettingsConfigurator {
  static func configure(_ view: SettingsViewController, navigationMode: NavigationMode = .menuItem) {
    let router = SettingsRouterImplementation(view: view)
    let presenter = SettingsPresenterImplementation(view: view, router: router, navigationMode: navigationMode)
    
    view.presenter = presenter
  }
}
