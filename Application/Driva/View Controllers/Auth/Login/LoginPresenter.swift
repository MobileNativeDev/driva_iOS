//
//  LoginPresenter.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

protocol LoginView: BaseViewController {
  
}

protocol LoginPresenter {
  func loginAction()
  func signUpAction()
}

protocol LoginRouter {
  func toSignUp()
  func toDashboard()
}

class LoginPresenterImplementation {
  private weak var view: LoginView?
  private let router: LoginRouter
  
  //MARK: -
  
  init(view: LoginView, router: LoginRouter) {
    self.view = view
    self.router = router
  }
}

//MARK: - LoginPresenter
extension LoginPresenterImplementation: LoginPresenter {
  func loginAction() {
    router.toDashboard()
  }
  
  func signUpAction() {
    router.toSignUp()
  }
}











