//
//  ReviewSubmitionViewController.swift
//  Driva
//
//  Created by iDeveloper on 27.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class ReviewSubmitionViewController: UIViewController {
  
  static func instantiate() -> ReviewSubmitionViewController? {
    return UIStoryboard(name: "Review", bundle: nil).instantiateViewController(withIdentifier: "ReviewSubmitionViewController") as? ReviewSubmitionViewController
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  //MARK: -
  
  @IBAction private func btnOkPressed(_ sender: UIButton) {
    navigationController?.dismiss(animated: true, completion: nil)
  }
}



