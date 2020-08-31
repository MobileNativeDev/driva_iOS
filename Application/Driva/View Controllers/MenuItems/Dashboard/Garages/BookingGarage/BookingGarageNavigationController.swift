//
//  BookingGarageNavigationController.swift
//  Driva
//
//  Created by iDeveloper on 27.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class BookingGarageNavigationController: UINavigationController {
  
  static func instantiate() -> BookingGarageNavigationController? {
    return UIStoryboard(name: "BookingGarage", bundle: nil).instantiateViewController(withIdentifier: "BookingGarageNavigationController") as? BookingGarageNavigationController
  }
  
  var bookingCompletion: ( () -> () )?
  
}
