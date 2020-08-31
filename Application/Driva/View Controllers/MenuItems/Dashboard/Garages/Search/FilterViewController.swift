//
//  FilterViewController.swift
//  Driva
//
//  Created by iDeveloper on 29.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

enum RadiusFilter: Int {
  case thisArea
  case miles1_4
  case miles1_2
  case miles1
  
  var title: String {
    switch self {
    case .thisArea: return "This Area Only"
    case .miles1_4: return "Within 1/4 Miles"
    case .miles1_2: return "Within 1/2 Miles"
    case .miles1: return "Within 1 Miles"
    }
  }
  
  static var numberOfRadiuses: Int {
    return 4
  }
}

final class FilterViewController: UIViewController, BaseViewController {
  
  var radius: RadiusFilter = .thisArea
  var garageTypes = Set<GarageType>()
  var onCall: Bool = false
  var available: Bool = false
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var tblFilters: UITableView!
  //Need for native "keyboard" with picker view as input view
  @IBOutlet private weak var txtFakeRadiusInput: UITextField!
  
  //MARK: -
  
  static func instantiate() -> FilterViewController? {
    return UIStoryboard(name: "Garages", bundle: nil).instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let picker = UIPickerView(frame: .zero)
    picker.dataSource = self
    picker.delegate = self
    txtFakeRadiusInput.inputView = picker
  }
  
  //MARK: -
 
  @IBAction private func btnBackPressed(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction private func btnSearchPressed(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
  
  //MARK: -
  
  private func configure(_ cell: UITableViewCell, for index: Int) {
    let cellType = FilterCell(rawValue: index) ?? .radius
    
    switch cellType {
    case .radius: (cell as? FilterRadiusCell)?.radius = radius.title
    case .garageType:
      var resultStr = ""
      
      if garageTypes.count >= GarageType.numberOfTypes {
        resultStr = "All Garages"
      } else {
        garageTypes.forEach({
          if !resultStr.isEmpty {
            resultStr += ","
          }
          resultStr += $0.title
        })
        resultStr = resultStr.isEmpty ? "None" : resultStr
      }

      (cell as? FilterGarageTypeCell)?.type = resultStr
      
    case .onCall: (cell as? FilterOnCallCell)?.checked = onCall
    case .available: (cell as? FilterAvailableCell)?.checked = available
    }
  }
  
  private func toGarageTypes() {
    guard let garageTypesController = GarageTypesViewController.instantiate() else { return }
    garageTypesController.selectedTypes = garageTypes
    garageTypesController.selectTypeAction = { [weak self] types in
      self?.garageTypes = types
      self?.tblFilters.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
    }
    navigationController?.show(garageTypesController, sender: self)
  }
}

//MARK: - UITableViewDataSource
extension FilterViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellType = FilterCell(rawValue: indexPath.row) ?? .radius
    var identifier = FilterRadiusCell.identifier

    switch cellType {
    case .radius: identifier = FilterRadiusCell.identifier
    case .garageType: identifier = FilterGarageTypeCell.identifier
    case .onCall: identifier = FilterOnCallCell.identifier
    case .available: identifier = FilterAvailableCell.identifier
    }
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    configure(cell, for: indexPath.row)
    return cell
  }
}

//MARK: - UITableViewDelegate
extension FilterViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer { tableView.deselectRow(at: indexPath, animated: true) }
    let cellType = FilterCell(rawValue: indexPath.row) ?? .radius
    
    switch cellType {
    case .radius: txtFakeRadiusInput.becomeFirstResponder()
    case .garageType: toGarageTypes()
    case .onCall: onCall = !onCall
    case .available: available = !available
    }
  }
}

//MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension FilterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return RadiusFilter.numberOfRadiuses
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return (RadiusFilter(rawValue: row) ?? .thisArea).title
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    radius = RadiusFilter(rawValue: row) ?? .thisArea
    tblFilters.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
  }
}



