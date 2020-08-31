//
//  SortViewController.swift
//  Driva
//
//  Created by iDeveloper on 29.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class SortViewController: UIViewController, BaseViewController {
  static func instantiate() -> SortViewController? {
    return UIStoryboard(name: "Garages", bundle: nil).instantiateViewController(withIdentifier: "SortViewController") as? SortViewController
  }
  
  //MARK: -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  //MARK: - Actions
  
  @IBAction private func btnCancelPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction private func btnNearestLocationPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction private func btnRatingPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
