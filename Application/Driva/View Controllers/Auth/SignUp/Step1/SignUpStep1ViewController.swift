//
//  SignUpStep1ViewController.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class SignUpStep1ViewController: UIViewController {
  var presenter: SignUpStep1Presenter?
  
  //MARK: - IBOutlets
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    SignUpStep1Configurator.configure(self)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  //MARK: - IBActions
  
  @IBAction private func btnContinuePressed(_ sender: UIButton) {
    presenter?.continueAction()
  }
}

//MAKE: - SignUpStep1View
extension SignUpStep1ViewController: SignUpStep1View {
  static func instantiate() -> SignUpStep1ViewController? {
    return UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SignUpStep1ViewController") as? SignUpStep1ViewController
  }
}
