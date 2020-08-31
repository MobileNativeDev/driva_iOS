//
//  BookingGarageViewController.swift
//  Driva
//
//  Created by iDeveloper on 27.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class BookingGarageViewController: UIViewController {
  var presenter: BookingGaragePresenter?

  //MARK: - IBOutlets

  @IBOutlet private weak var txtMessage: UITextView!
  
  @IBOutlet private weak var tblInfo: UITableView! {
    didSet {
      tblInfo.register(UINib(nibName: ServiceDetailsBookingCell.identifier, bundle: nil),
                          forCellReuseIdentifier: ServiceDetailsBookingCell.identifier)
    }
  }
  
  //MARK: -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
  }
  
  //MARK: - Actions
  
  @IBAction private func btnBackPressed(_ sender: UIBarButtonItem) {
    presenter?.backAction()
  }
  
  @IBAction private func btnNextPressed(_ sender: UIButton) {
    presenter?.nextAction()
  }
}

//MARK: - BookingGarageView
extension BookingGarageViewController: BookingGarageView {
  static func instantiate() -> BookingGarageViewController? {
    let storyboard = UIStoryboard(name: "BookingGarage", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "BookingGarageViewController") as? BookingGarageViewController
  }
  
  func reloadDate() {
    tblInfo.reloadData()
  }
}

//MARK: - UITableViewDataSource
extension BookingGarageViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return BookingGarageSection.numberOfSections
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat((BookingGarageSection(rawValue: indexPath.section) ?? .vehicle).cellHeight)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (BookingGarageSection(rawValue: section) ?? .vehicle).numberOfRows
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return (BookingGarageSection(rawValue: section) ?? .vehicle).title
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat((BookingGarageSection(rawValue: section) ?? .vehicle).headerHeight)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: UITableViewCell!
    let bookingSection = BookingGarageSection(rawValue: indexPath.section) ?? .vehicle
    switch bookingSection {
    case .garage:
      cell = tableView.dequeueReusableCell(withIdentifier: ServiceDetailsGarageCell.identifier, for: indexPath)
      presenter?.configure(cell as! ServiceDetailsGarageCell, for: indexPath.row)
    case .vehicle:
      cell = tableView.dequeueReusableCell(withIdentifier: ServiceDetailsVehicleCell.identifier, for: indexPath)
      presenter?.configure(cell as! ServiceDetailsVehicleCell, for: indexPath.row)
    case .info:
      cell = tableView.dequeueReusableCell(withIdentifier: ServiceDetailsBookingCell.identifier, for: indexPath)
      cell.accessoryType = .disclosureIndicator
      presenter?.configure(cell as! ServiceDetailsBookingCell, for: indexPath.row)
    }
    
    return cell
  }
}

//MARK: - UITableViewDelegate
extension BookingGarageViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer { tableView.deselectRow(at: indexPath, animated: true) }
    presenter?.select(with: indexPath.section, and: indexPath.row)
  }
}





