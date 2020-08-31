//
//  SignUpStep2Configurator.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class SignUpStep2Configurator {
  static func configure(_ view: SignUpStep2ViewController) {
    let router = SignUpStep2RouterImplementation(view: view)
    let presenter = SignUpStep2PresenterImplementation(view: view, router: router)
    
    view.presenter = presenter
  }
}
