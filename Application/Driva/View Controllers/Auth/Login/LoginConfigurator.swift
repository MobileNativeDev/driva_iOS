//
//  LoginConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class LoginConfigurator {
  static func configure(_ view: LoginViewController) {
    let router = LoginRouterImplementation(view: view)
    let presenter = LoginPresenterImplementation(view: view, router: router)
    
    view.presenter = presenter
  }
}
