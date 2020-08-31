//
//  ProblemDetailsRouter.swift
//  Driva
//
//  Created by iDeveloper on 23.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class ProblemDetailsRouterImplementation {
  private weak var view: ProblemDetailsViewController?
  
  init(view: ProblemDetailsViewController) {
    self.view = view
  }
}

//MARK: - ProblemDetailsRouter
extension ProblemDetailsRouterImplementation: ProblemDetailsRouter {
  func back() {
    view?.navigationController?.popViewController(animated: true)
  }
}
