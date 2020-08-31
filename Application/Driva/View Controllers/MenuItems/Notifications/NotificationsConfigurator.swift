//
//  NotificationsConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 30.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class NotificationsConfigurator {
  static func configure(_ view: NotificationsViewController) {
    let router = NotificationsRouterImplementation(view: view)
    let presenter = NotificationsPresenterImplementation(view: view, router: router)
    
    view.presenter = presenter
  }
}
