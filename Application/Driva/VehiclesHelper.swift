//
//  VehiclesHelper.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class VehiclesHelper {
  static let shared: VehiclesHelper = VehiclesHelper()
  private init() {}
  
  //MARK: -
  
  private(set) var vehicles = [Vehicle]()
  
  //MARK: -
  
  func saveVehicle(_ vehicle: Vehicle) {
    //FIXME: stub
    vehicles = [vehicle]
  }
  
  func removeVehicle(_ vehicle: Vehicle) {
    //TODO: remove vehicle
  }
  
}
