//
//  ServiceDetailsRouter.swift
//  Driva
//
//  Created by iDeveloper on 24.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class ServiceDetailsRouterImplementation {
  private weak var view: ServiceDetailsViewController?
  
  init(view: ServiceDetailsViewController) {
    self.view = view
  }
}

//MARK: - ServiceDetailsRouter
extension ServiceDetailsRouterImplementation: ServiceDetailsRouter {
  func back() {
    if view?.navigationController?.presentingViewController != nil {
      view?.navigationController?.dismiss(animated: true, completion: nil)
    } else {
      view?.dismiss(animated: true, completion: nil)
    }
  }
  
  func toReview(with garage: Garage) {
    guard let reviewController = LeaveReviewViewController.instantiate() else { return }
    LeaveReviewConfigurator.configure(reviewController, with: garage)
    view?.show(reviewController, sender: self)
  }
}
