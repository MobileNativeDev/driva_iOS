//
//  OnBoardingRouter.swift
//  Driva
//
//  Created by iDeveloper on 16.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class OnBoardingRouterImplementation {
  private weak var view: OnBoardingViewController?
  
  init(view: OnBoardingViewController) {
    self.view = view
  }
}

//MARK: - OnBoardingRouter
extension OnBoardingRouterImplementation: OnBoardingRouter {
  func toLogin() {
    guard let loginController = LoginViewController.instantiate() else { return }
    view?.navigationController?.show(loginController, sender: self)
  }
}
