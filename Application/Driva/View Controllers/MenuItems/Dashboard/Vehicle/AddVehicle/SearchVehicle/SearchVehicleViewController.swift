//
//  SearchVehicleViewController.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class SearchVehicleViewController: UIViewController {
  var presenter: SearchVehiclePresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private var txtPlateNumber: PlateNumberField!
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    SearchVehicleConfigurator.configure(self)
  }
  
  //MARK: - Actions
  
  @IBAction private func btnBackPressed(_ sender: UIBarButtonItem) {
    presenter?.backAction()
  }
  
  @IBAction private func btnGoPressed(_ sender: UIButton) {
    presenter?.goAction(with: txtPlateNumber.text)
  }
}

//MARK: - SearchVehicleView
extension SearchVehicleViewController: SearchVehicleView {
  static func instantiate() -> SearchVehicleViewController? {
    return UIStoryboard(name: "AddVehicle", bundle: nil).instantiateViewController(withIdentifier: "SearchVehicleViewController") as? SearchVehicleViewController
  }
}








