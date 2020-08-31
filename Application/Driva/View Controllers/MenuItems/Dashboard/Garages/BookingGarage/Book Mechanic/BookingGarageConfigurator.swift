//
//  BookingGarageConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 27.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class BookingGarageConfigurator {
  static func configure(_ view: BookingGarageViewController, garage: GarageShortInfo, and vehicle: Vehicle) {
    let router = BookingGarageRouterImplementation(view: view)
    let presenter = BookingGaragePresenterImplementation(view: view, router: router, garage: garage, vehicle: vehicle)
    
    view.presenter = presenter
  }
}
