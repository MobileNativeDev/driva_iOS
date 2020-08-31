//
//  NotificationsRouter.swift
//  Driva
//
//  Created by iDeveloper on 30.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class NotificationsRouterImplementation {
  private weak var view: NotificationsViewController?
  
  //MARK: -
  
  init(view: NotificationsViewController) {
    self.view = view
  }
}

extension NotificationsRouterImplementation: NotificationsRouter {
  func toProblem(_ problem: VehicleProblem) {
    guard let details = ProblemDetailsViewController.instantiate() else { return }
    ProblemDetailsConfigurator.configure(details, with: problem)
    view?.navigationController?.show(details, sender: self)
  }

  func showMenu() {
    view?.showSideMenu()
  }
}
