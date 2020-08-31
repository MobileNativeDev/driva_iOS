//
//  DiagnosticRouter.swift
//  Driva
//
//  Created by iDeveloper on 09.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class DiagnosticRouterImplementation {
  private weak var view: DiagnosticViewController?
  
  init(view: DiagnosticViewController) {
    self.view = view
  }
}

//MARK: - DiagnosticRouter
extension DiagnosticRouterImplementation: DiagnosticRouter {
  func showMenu() {
    view?.showSideMenu()
  }
  
  func toConnect(with mode: ConnectMode, scanCompletion: @escaping (_ temperatures: [TemperaturePoint]) -> ()) {
    guard let controller = ConnectNavigationController.instantiate(with: mode) else { return }
    controller.successfullyCompletion = scanCompletion
    view?.present(controller, animated: true, completion: nil)
  }
  
  func toProblems(_ problems: [VehicleProblem]) {
    guard let problemsNavigation = ProblemsNavigationController.instantiate(with: problems) else { return }
    view?.present(problemsNavigation, animated: true, completion: nil)
  }
}
