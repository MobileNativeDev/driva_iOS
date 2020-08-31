//
//  AddVehicleViewController.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class AddVehicleViewController: UIViewController {
  var presenter: AddVehiclePresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgVehicleImage: UIImageView!
  @IBOutlet private weak var imgLogo: UIImageView!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblInfo: UILabel!
  
  @IBOutlet private var profileFields: [UITextField]!
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
  }
  
  //MARK: -
  
  private func showField(_ field: ProfileField, value: String) {
    guard let textField = profileFields.first(where: { field.rawValue == $0.tag }) else { return }
    textField.text = value
  }
  
  //MARK: - Actions
  
  @IBAction private func btnAddVehiclePressed(_ sender: UIButton) {
    presenter?.addAction()
  }
}

//MARK: - SearchVehicleView
extension AddVehicleViewController: AddVehicleView {
  static func instantiate() -> AddVehicleViewController? {
    return UIStoryboard(name: "AddVehicle", bundle: nil).instantiateViewController(withIdentifier: "AddVehicleViewController") as? AddVehicleViewController
  }
  
  func showPlateNumber(_ number: String) {
    showField(.plateNumber, value: number)
  }
  
  func showMake(_ make: String) {
    showField(.make, value: make)
  }
  
  func showModel(_ model: String) {
    showField(.model, value: model)
  }
  
  func showEngineSize(_ size: String) {
    showField(.engineSize, value: size)
  }
  
  func showBodyType(_ type: String) {
    showField(.bodyType, value: type)
  }
  
  func showTransmission(_ transmission: String) {
    showField(.transmission, value: transmission)
  }
  
  func showColour(_ colour: String) {
    showField(.colour, value: colour)
  }
  
  func showYear(_ year: String) {
    showField(.year, value: year)
  }
  
  func showVIN(_ vin: String) {
    showField(.vin, value: vin)
  }
}






