//
//  AccountConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 13.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class AccountConfigurator {
  static func configure(_ view: AccountViewController) {
    let router = AccountRouterImplementation(view: view)
    let presenter = AccountPresenterImplementation(view: view, router: router)
    
    view.presenter = presenter
  }
}
