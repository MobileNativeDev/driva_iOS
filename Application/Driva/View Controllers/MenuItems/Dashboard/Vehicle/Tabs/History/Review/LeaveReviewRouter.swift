//
//  LeaveReviewRouter.swift
//  Driva
//
//  Created by iDeveloper on 27.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class LeaveReviewRouterImplementation {
  private weak var view: LeaveReviewViewController?
  
  //MARK: - 
  
  init(view: LeaveReviewViewController) {
    self.view = view
  }
}

//MARK: - LeaveReviewRouter
extension LeaveReviewRouterImplementation: LeaveReviewRouter {
  
  func back() {
    view?.navigationController?.popViewController(animated: true)
  }
  
  func reviewSubmition() {
    guard let submition = ReviewSubmitionViewController.instantiate() else { return }
    view?.navigationController?.setViewControllers([submition], animated: true)
  }
}
