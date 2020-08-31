//
//  SuccessConnectRouter.swift
//  Driva
//
//  Created by iDeveloper on 21.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class SuccessConnectRouterImplementation {
  private weak var view: SuccessConnectViewController?
  
  init(view: SuccessConnectViewController) {
    self.view = view
  }
}

//MARK: - SuccessConnectRouter
extension SuccessConnectRouterImplementation: SuccessConnectRouter {
  func closeConnect(_ temperatures: [TemperaturePoint]) {
    if let connectNavigation = view?.navigationController as? ConnectNavigationController {
      connectNavigation.successfullyCompletion?(temperatures)
    }
    
    view?.navigationController?.dismiss(animated: true, completion: nil)
  }
  
  func close() {
    guard let navController = view?.navigationController as? ConnectNavigationController else { return }
    switch navController.scanMode {
    case .connect:
      view?.navigationController?.popViewController(animated: true)
    case .scan(_):
      view?.navigationController?.dismiss(animated: true, completion: nil)
    }
  }
}


