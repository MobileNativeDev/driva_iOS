//
//  GarageTypesViewController.swift
//  Driva
//
//  Created by iDeveloper on 30.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

enum GarageType: Int {
  case bodywork
  case electrician
  case mot
  case recovery
  case repairs
  case servicing
  case tyres
  
  var title: String {
    switch self {
      case .bodywork: return "Bodywork"
      case .electrician: return "Electrician"
      case .mot: return "MOT"
      case .recovery: return "Recovery"
      case .repairs: return "Repairs"
      case .servicing: return "Servicing"
      case .tyres: return "Tyres"
    }
  }
  
  static var numberOfTypes: Int {
    return 7
  }
}

final class GarageTypesViewController: UIViewController {

  var selectedTypes = Set<GarageType>()
  var selectTypeAction: ( (Set<GarageType>) -> () )?
  
  //MARK: -
  
  @IBOutlet private weak var tblTypes: UITableView!
  
  //MARK: -
  
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  //MARK: - Actions
  
  @IBAction private func btnBackPressed(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction private func btnSavePressed(_ sender: UIButton) {
    selectTypeAction?(selectedTypes)
    navigationController?.popViewController(animated: true)
  }
  
  //MARK: -
}

//MARK: - BaseViewController
extension GarageTypesViewController: BaseViewController {
  static func instantiate() -> GarageTypesViewController? {
    return UIStoryboard(name: "Garages", bundle: nil).instantiateViewController(withIdentifier: "GarageTypesViewController") as? GarageTypesViewController
  }
}

//MARK: - UITableViewDataSource
extension GarageTypesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return GarageType.numberOfTypes
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GarageTypeCell.identifier, for: indexPath) as! GarageTypeCell
    
    let type = GarageType(rawValue: indexPath.row) ?? .bodywork
    cell.title = type.title
    cell.checked = selectedTypes.contains(type)
    
    return cell
  }
}

//MARK: - UITableViewDelegate
extension GarageTypesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer { tableView.deselectRow(at: indexPath, animated: true) }
    
    let type = GarageType(rawValue: indexPath.row) ?? .bodywork
    if selectedTypes.contains(type) {
      selectedTypes.remove(type)
    } else {
      selectedTypes.insert(type)
    }
  }
}











