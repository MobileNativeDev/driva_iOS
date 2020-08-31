//
//  LoginViewController.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
  var presenter: LoginPresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var txtUsername: UITextField!
  @IBOutlet private weak var txtPassword: UITextField!
  
  //MARK: -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    LoginConfigurator.configure(self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  //MARK: -
  
  @IBAction private func btnLoginPressed(_ sender: UIButton) {
    presenter?.loginAction()
  }
  
  @IBAction private func btnSignUpPressed(_ sender: UIButton) {
    presenter?.signUpAction()
  }
}

//MARK: - LoginView
extension LoginViewController: LoginView {
  static func instantiate() -> LoginViewController? {
    return UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
  }
}








