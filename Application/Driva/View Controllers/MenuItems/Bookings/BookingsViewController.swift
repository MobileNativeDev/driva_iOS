//
//  BookingsViewController.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class BookingsViewController: UIViewController, SideMenuItemContent {
  var presenter: BookingsPresenter?
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    BookingsConfigurator.configure(self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter?.viewWillAppear()
  }
  
  //MARK: -
  
  @IBAction private func btnMenuPressed(_ sender: UIBarButtonItem) {
    presenter?.menuAction()
  }
  
  @IBAction private func btnAddPressed(_ sender: UIBarButtonItem) {
    presenter?.addAction()
  }
}

//MARK: - BookingsView
extension BookingsViewController: BookingsView {
  static func instantiate() -> BookingsViewController? {
    return UIStoryboard(name: "Bookings", bundle: nil).instantiateViewController(withIdentifier: "BookingsViewController") as? BookingsViewController
  }
}

//MARK: - UITableViewDataSource
extension BookingsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.numberOfBookings ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: BookingCell.identifier, for: indexPath) as! BookingCell
    presenter?.configure(cell, for: indexPath.row)
    return cell
  }
}

//MARK: - UITableViewDelegate
extension BookingsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer { tableView.deselectRow(at: indexPath, animated: true) }
  }
}
