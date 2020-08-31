//
//  LeaveReviewConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 27.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class LeaveReviewConfigurator {
  static func configure(_ view: LeaveReviewViewController, with garage: Garage) {
    let router = LeaveReviewRouterImplementation(view: view)
    let presenter = LeaveReviewPresenterImplementation(view: view, router: router, garage: garage)
    
    view.presenter = presenter
  }
}
