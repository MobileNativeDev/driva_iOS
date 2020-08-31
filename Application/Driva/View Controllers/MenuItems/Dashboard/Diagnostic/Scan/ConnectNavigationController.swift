//
//  ConnectNavigationController.swift
//  Driva
//
//  Created by iDeveloper on 21.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

enum ConnectMode {
  case connect
  case scan(Adapter)
}

class ConnectNavigationController: UINavigationController {

  var successfullyCompletion: ((_ temperatures: [TemperaturePoint]) -> ())?
  
  var scanMode: ConnectMode = .connect
  
  //MARK: -
  
  static func instantiate(with mode: ConnectMode) -> ConnectNavigationController? {
    let navController = UIStoryboard(name: "Scan", bundle: nil).instantiateViewController(withIdentifier: "ConnectNavigationController") as? ConnectNavigationController
    navController?.scanMode = mode
    
    switch mode {
    case .connect:
      if let connectController = ConnectViewController.instantiate() {
        navController?.setViewControllers([connectController], animated: false)
      }
    case .scan(let adapter):
      if let connectController = SuccessConnectViewController.instantiate() {
        SuccessConnectConfigurator.configure(connectController, with: adapter, and: .scan)
        navController?.setViewControllers([connectController], animated: false)
      }
    }
    
    return navController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
}
