//
//  SuccessfullViewController.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class SuccessfullViewController: UIViewController {

  var vehicle: Vehicle?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var lblTitle: UILabel!
  
  //MARK: - Static
  
  static func instantiate() -> SuccessfullViewController? {
    return UIStoryboard(name: "AddVehicle", bundle: nil).instantiateViewController(withIdentifier: "SuccessfullViewController") as? SuccessfullViewController
  }
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  //MARK: -
  
  private func setup() {
    guard let vehicle = vehicle else { return }
    lblTitle.text = "\(vehicle.title) successfully added!"
  }
  
  //MARK: - Actions
  
  @IBAction private func btnGotItPressed(_ sender: UIButton) {
    navigationController?.dismiss(animated: true, completion: nil)
  }
}
