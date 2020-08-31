//
//  ServiceDetailsViewController.swift
//  Driva
//
//  Created by iDeveloper on 24.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class ServiceDetailsViewController: UIViewController {
  var presenter: ServiceDetailsPresenter?
  
  var cells = [UITableViewCell]()
  
  //MARK: - IBOutlets

  @IBOutlet private weak var tblDetails: UITableView! {
    didSet {
      tblDetails.register(UINib(nibName: ServiceDetailsWorkCell.identifier, bundle: nil),
                          forCellReuseIdentifier: ServiceDetailsWorkCell.identifier)
      tblDetails.register(UINib(nibName: ServiceDetailsBookingCell.identifier, bundle: nil),
                          forCellReuseIdentifier: ServiceDetailsBookingCell.identifier)
    }
  }

  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
  }
  
  //MARK: - 
  
  @IBAction private func btnBackPressed(_ sender: UIBarButtonItem) {
    presenter?.backAction()
  }
  
  @IBAction private func btnReviewPressed(_ sender: UIButton) {
    presenter?.reviewAction()
  }
}

//MARK: - ServiceDetailsView
extension ServiceDetailsViewController: ServiceDetailsView {
  static func instantiate() -> ServiceDetailsViewController? {
    return UIStoryboard(name: "ServiceDetails", bundle: nil).instantiateViewController(withIdentifier: "ServiceDetailsViewController") as? ServiceDetailsViewController
  }
}

//MARK: - UITableViewDataSource
extension ServiceDetailsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let detailSection = ServiceDetailsSection(rawValue: section) ?? .garage
    switch detailSection {
    case .garage: return 1
    case .vehicle: return 1
    case .workComlpleted: return presenter?.numberOfFixes ?? 0
    case .booking: return 3
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard section > 0 else { return nil }

    let header = ServiceDetailHeader.instantiate()

    let detailSection = ServiceDetailsSection(rawValue: section) ?? .garage
    switch detailSection {
    case .garage: break
    case .vehicle: header?.title = "VEHICLE:"
    case .workComlpleted: header?.title = "WORK COMPLETED:"
    case .booking: header?.title = "BOOKING DETAIL:"
    }

    return header
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return section == 0 ? 1 : 44
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let detailSection = ServiceDetailsSection(rawValue: indexPath.section) ?? .garage
    switch detailSection {
    case .garage, .vehicle: return 94
    case .workComlpleted, .booking: return 44
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: UITableViewCell!
    
    let detailSection = ServiceDetailsSection(rawValue: indexPath.section) ?? .garage
    switch detailSection {
    case .garage:
      cell = tableView.dequeueReusableCell(withIdentifier: ServiceDetailsGarageCell.identifier, for: indexPath)
      presenter?.configure(cell as! ServiceDetailsGarageCell, for: indexPath.row)
    case .vehicle:
      cell = tableView.dequeueReusableCell(withIdentifier: ServiceDetailsVehicleCell.identifier, for: indexPath)
      presenter?.configure(cell as! ServiceDetailsVehicleCell, for: indexPath.row)
    case .workComlpleted:
      cell = tableView.dequeueReusableCell(withIdentifier: ServiceDetailsWorkCell.identifier, for: indexPath)
      presenter?.configure(cell as! ServiceDetailsWorkCell, for: indexPath.row)
    case .booking:
      cell = tableView.dequeueReusableCell(withIdentifier: ServiceDetailsBookingCell.identifier, for: indexPath)
      cell.selectionStyle = .none
      presenter?.configure(cell as! ServiceDetailsBookingCell, for: indexPath.row)
    }
    
    return cell
  }
}

//MARK: - UITableViewDelegate
extension ServiceDetailsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0, indexPath.row == 0 {
      presenter?.garageSelected()
    }
  }
}












