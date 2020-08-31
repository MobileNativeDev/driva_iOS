//
//  DiagnosticConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 09.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class DiagnosticConfigurator {
  static func configure(_ view: DiagnosticViewController) {
    let router = DiagnosticRouterImplementation(view: view)
    let presenter = DiagnosticPresenterImplementation(view: view, router: router)
    
    view.presenter = presenter
  }
}
