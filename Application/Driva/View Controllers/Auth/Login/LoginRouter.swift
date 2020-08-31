//
//  LoginRouter.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class LoginRouterImplementation {
  private weak var view: LoginViewController?
  
  init(view: LoginViewController) {
    self.view = view
  }
}

//MARK: - LoginRouter
extension LoginRouterImplementation: LoginRouter {
  func toSignUp() {
    guard let signUpController = SignUpStep1ViewController.instantiate() else { return }
    view?.navigationController?.show(signUpController, sender: self)
  }
  
  func toDashboard() {
    guard var viewControllers = view?.navigationController?.viewControllers else { return }
    let hostMenuController = HostMenuViewController.instantiate()
    
    viewControllers.removeLast()
    viewControllers.append(hostMenuController)
    view?.navigationController?.setViewControllers(viewControllers, animated: true)
  }

}
