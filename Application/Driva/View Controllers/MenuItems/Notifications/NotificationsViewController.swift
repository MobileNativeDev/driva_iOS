//
//  NotificationsViewController.swift
//  Driva
//
//  Created by iDeveloper on 30.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class NotificationsViewController: UIViewController, SideMenuItemContent {
  var presenter: NotificationsPresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var tblNotifications: UITableView!
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationsConfigurator.configure(self)
  }
  
  //MARK: - Actions
  
  @IBAction private func btnMenuPressed() {
    presenter?.menuAction()
  }
  
  @IBAction private func btnClearPressed(_ sender: UIButton) {
    //TODO: clear action
  }
  
}

//MARK: - BaseViewController
extension NotificationsViewController: NotificationsView {
  static func instantiate() -> NotificationsViewController? {
    return UIStoryboard(name: "Notifications", bundle: nil).instantiateViewController(withIdentifier: "NotificationsViewController") as? NotificationsViewController
  }
}

//MARK: - UITableViewDataSource
extension NotificationsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.numberOfNotifications ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.identifier, for: indexPath) as! NotificationCell
    presenter?.configure(cell, for: indexPath.row)
    return cell
  }
}

//MARK: - UITableViewDelegate
extension NotificationsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer { tableView.deselectRow(at: indexPath, animated: true) }
    presenter?.notificationSelected(with: indexPath.row)
  }
}
