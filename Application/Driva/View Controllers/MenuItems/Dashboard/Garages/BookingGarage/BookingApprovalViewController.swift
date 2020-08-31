//
//  BookingApprovalViewController.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class BookingApprovalViewController: UIViewController, BaseViewController {
  static func instantiate() -> BookingApprovalViewController? {
    return UIStoryboard(name: "BookingGarage", bundle: nil).instantiateViewController(withIdentifier: "BookingApprovalViewController") as? BookingApprovalViewController
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  //MARK: -
  
  @IBAction private func btnOkPressed(_ sender: UIButton) {
    if let bookNavigation = navigationController as? BookingGarageNavigationController {
      bookNavigation.bookingCompletion?()
    }
    navigationController?.dismiss(animated: true, completion: nil)
  }
}
