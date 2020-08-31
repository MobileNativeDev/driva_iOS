//
//  OnBoardingConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 16.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class OnBoardingConfigurator {
  static func configure(_ view: OnBoardingViewController) {
    let router = OnBoardingRouterImplementation(view: view)
    let presenter = OnBoardingPresenterImplementation(view: view, router: router)
    
    view.presenter = presenter
  }
}
