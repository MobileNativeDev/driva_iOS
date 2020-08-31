//
//  SignUpStep1Presenter.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

protocol SignUpStep1View: BaseViewController {
  
}

protocol SignUpStep1Presenter {
  func continueAction()
}

protocol SignUpStep1Router {
  func nextStep()
}

class SignUpStep1PresenterImplementation {
  private weak var view: SignUpStep1View?
  private let router: SignUpStep1Router
  
  //MARK: -
  
  init(view: SignUpStep1View, router: SignUpStep1Router) {
    self.view = view
    self.router = router
  }
}

//MARK: - SignUpStep1Presenter
extension SignUpStep1PresenterImplementation: SignUpStep1Presenter {
  func continueAction() {
    router.nextStep()
  }
}
