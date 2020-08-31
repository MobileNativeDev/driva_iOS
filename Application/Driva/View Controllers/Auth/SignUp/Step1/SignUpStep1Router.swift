//
//  SignUpStep1Router.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class SignUpStep1RouterImplementation {
  private weak var view: SignUpStep1ViewController?
  
  init(view: SignUpStep1ViewController) {
    self.view = view
  }
}

//MARK: - SignUpStep1Router
extension SignUpStep1RouterImplementation: SignUpStep1Router {
  func nextStep() {
    guard let step2Controller = SignUpStep2ViewController.instantiate() else { return }
    view?.navigationController?.show(step2Controller, sender: self)
  }
}
