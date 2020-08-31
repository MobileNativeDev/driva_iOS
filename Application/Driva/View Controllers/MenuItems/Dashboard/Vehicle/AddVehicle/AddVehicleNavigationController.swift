//
//  AddVehicleNavigationController.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class AddVehicleNavigationController: UINavigationController {
  
  var successfullyCompletion: ((_ vehicle: Vehicle) -> ())?
  
  //MARK: -
  
  static func instantiate() -> AddVehicleNavigationController? {
    return UIStoryboard(name: "AddVehicle", bundle: nil).instantiateViewController(withIdentifier: "AddVehicleNavigationController") as? AddVehicleNavigationController
  }

  
  
  
}
