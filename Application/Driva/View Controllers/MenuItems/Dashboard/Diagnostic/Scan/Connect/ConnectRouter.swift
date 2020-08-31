//
//  ConnectRouter.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class ConnectRouterImplementation {
  private weak var view: ConnectViewController?
  
  init(view: ConnectViewController) {
    self.view = view
  }
}

//MARK: - ConnectRouter
extension ConnectRouterImplementation: ConnectRouter {
  func close() {
    view?.navigationController?.dismiss(animated: true, completion: nil)
  }
  
  func toSuccess(with adapter: Adapter) {
    guard let successController = SuccessConnectViewController.instantiate() else { return }
    SuccessConnectConfigurator.configure(successController, with: adapter, and: .successfull)
    view?.navigationController?.show(successController, sender: self)
  }
}
