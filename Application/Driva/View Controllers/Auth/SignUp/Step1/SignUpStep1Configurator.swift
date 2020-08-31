//
//  SignUpStep1Configurator.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class SignUpStep1Configurator {
  static func configure(_ view: SignUpStep1ViewController) {
    let router = SignUpStep1RouterImplementation(view: view)
    let presenter = SignUpStep1PresenterImplementation(view: view, router: router)
    
    view.presenter = presenter
  }
}
