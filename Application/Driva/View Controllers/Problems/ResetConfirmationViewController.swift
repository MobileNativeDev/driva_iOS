//
//  ResetConfirmationViewController.swift
//  Driva
//
//  Created by iDeveloper on 24.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class ResetConfirmationViewController: UIViewController {
  static func instantiate() -> ResetConfirmationViewController? {
    return UIStoryboard(name: "Problems", bundle: nil).instantiateViewController(withIdentifier: "ResetConfirmationViewController") as? ResetConfirmationViewController
  }
  
  @IBAction private func btnResetPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }

  @IBAction private func btnCancelPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
