//
//  ProblemsRouter.swift
//  Driva
//
//  Created by iDeveloper on 23.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class ProblemsRouterImplementation {
  private weak var view: ProblemsViewController?
  
  init(view: ProblemsViewController) {
    self.view = view
  }
}

//MARK: - ProblemsRouter
extension ProblemsRouterImplementation: ProblemsRouter {
  func toProblem(_ problem: VehicleProblem) {
    guard let details = ProblemDetailsViewController.instantiate() else { return }
    ProblemDetailsConfigurator.configure(details, with: problem)
    view?.navigationController?.show(details, sender: self)
  }
  
  func confirmReset() {
    guard let confirmationController = ResetConfirmationViewController.instantiate() else { return }
    view?.present(confirmationController, animated: true, completion: nil)
  }
  
  func close() {
    view?.navigationController?.dismiss(animated: true, completion: nil)
  }
}
