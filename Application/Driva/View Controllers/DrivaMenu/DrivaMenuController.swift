//
//  DrivaMenuController.swift
//  Driva
//
//  Created by iDeveloper on 15.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

enum MenuItem: Int {
  case vehicle
  case bookings
  case tranfer
  case membership
  case settings
  
  case notifications
}

struct MenuItemInfo {
  let icon: UIImage?
  let title: String
  let item: MenuItem
  let inList: Bool
}

class DrivaMenuController: MenuViewController {
  
  let items = [
    MenuItemInfo(icon: #imageLiteral(resourceName: "menu_icon_vehicle"), title: "Vehicle", item: .vehicle, inList: true),
    MenuItemInfo(icon: #imageLiteral(resourceName: "menu_icon_bookings"), title: "Bookings", item: .bookings, inList: true),
    MenuItemInfo(icon: #imageLiteral(resourceName: "menu_icon_transfer"), title: "Transfer", item: .tranfer, inList: true),
    MenuItemInfo(icon: #imageLiteral(resourceName: "menu_icon_membership"), title: "Membership", item: .membership, inList: true),
    MenuItemInfo(icon: #imageLiteral(resourceName: "menu_icon_settings"), title: "Settings", item: .settings, inList: true),
    MenuItemInfo(icon: nil, title: "Notifications", item: .notifications, inList: false)
  ]
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var tblMenu: UITableView!
  
  
  //MARK: -
  
  static func instantiate() -> DrivaMenuController {
    return UIStoryboard(name: "DrivaMenu", bundle: nil).instantiateViewController(withIdentifier: "DrivaMenuController") as! DrivaMenuController
  }
  
  //MARK: -
  
  @IBAction private func btnNotificationPressed(_ sender: UIButton) {
    menuItemSelected(with: MenuItem.notifications.rawValue)
  }
  
  @IBAction private func btnLogoutPressed(_ sender: UIButton) {
    guard let loginController = LoginViewController.instantiate() else { return }
    
    dismiss(animated: false, completion: { [weak self] in
      self?.menuContainerViewController?.navigationController?.setViewControllers([loginController], animated: true)
    })
  }
  
  //MARK: -
  
  private func configure(_ cell: MenuCell, for index: Int) {
    guard items.count > index else { return }
    let item = items[index]
    
    cell.icon = item.icon
    cell.title = item.title
  }
  
  private func menuItemSelected(with index: Int) {
    guard items.count > index else { return }
    let item = items[index]
    
    guard let menuContainerViewController = self.menuContainerViewController else {
      return
    }
    
    var index = 0
    switch item.item {
    case .vehicle: index = 0
    case .bookings: index = 1
    case .tranfer: return
    case .membership: index = 2
    case .settings: index = 3
    case .notifications: index = 4
    }
    
    menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[index])
    menuContainerViewController.hideSideMenu()
  }
}

//MARK: - UITableViewDataSource
extension DrivaMenuController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var result = 0
    items.forEach({ if $0.inList { result += 1 } })
    return result
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell
    configure(cell, for: indexPath.row)
    return cell
  }
}

//MARK: - UITableViewDelegate
extension DrivaMenuController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer { tableView.deselectRow(at: indexPath, animated: true) }
    menuItemSelected(with: indexPath.row)
  }
}

















