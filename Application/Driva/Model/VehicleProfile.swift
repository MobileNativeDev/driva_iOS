//
//  VehicleProfile.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

enum ProfileField: Int {
  case plateNumber
  case make
  case model
  case engineSize
  case bodyType
  case transmission
  case colour
  case year
  case vin
}

struct VehicleProfile {
  var plateNumber: String?
  var make: String?
  var model: String?
  var engineSize: String?
  var bodyType: String?
  var transmission: String?
  var colour: String?
  var year: String?
  var vin: String?
  
  mutating func changeField(_ field: ProfileField, with text: String?) {
    switch field {
    case .plateNumber: plateNumber = text
    case .make: make = text
    case .model: model = text
    case .engineSize: engineSize = text
    case .bodyType: bodyType = text
    case .transmission: transmission = text
    case .colour: colour = text
    case .year: year = text
    case .vin: vin = text
    }
  }
  
  func text(from field: ProfileField) -> String? {
    switch field {
    case .plateNumber: return plateNumber
    case .make: return make
    case .model:return model
    case .engineSize: return engineSize
    case .bodyType: return bodyType
    case .transmission: return transmission
    case .colour: return colour
    case .year: return year
    case .vin: return vin
    }
  }
}
