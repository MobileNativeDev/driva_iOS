//
//  AccountRouter.swift
//  Driva
//
//  Created by iDeveloper on 13.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class AccountRouterImplementation {
  private weak var view: AccountViewController?
  
  init(view: AccountViewController) {
    self.view = view
  }
}

//MARK: - AccountRouter
extension AccountRouterImplementation: AccountRouter {
  func toGarage(with garage: GarageShortInfo) {
    guard let garageController = GarageViewController.instantiate() else { return }
    GarageConfigurator.configure(garageController, garage: garage)
    view?.navigationController?.show(garageController, sender: nil)
  }
  
  func showMenu() {
    view?.showSideMenu()
  }
  
  func showSettings() {
    guard let settings = SettingsViewController.instantiate() else { return }
    SettingsConfigurator.configure(settings, navigationMode: .stackItem)
    view?.navigationController?.show(settings, sender: self)
  }
  
  func toReview(with garage: Garage) {
    guard let reviewController = LeaveReviewViewController.instantiate() else { return }
    LeaveReviewConfigurator.configure(reviewController, with: garage)
    view?.show(reviewController, sender: self)
  }
}
