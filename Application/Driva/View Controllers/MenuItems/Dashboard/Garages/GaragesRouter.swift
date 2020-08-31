//
//  GaragesRouter.swift
//  Driva
//
//  Created by iDeveloper on 10.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIApplication

class GaragesRouterImplementation {
  private weak var view: GaragesViewController?
  
  init(view: GaragesViewController) {
    self.view = view
  }
}

//MARK: - GaragesRouter
extension GaragesRouterImplementation: GaragesRouter {
  func toGarage(_ garage: GarageShortInfo) {
    guard let garageController = GarageViewController.instantiate() else { return }
    GarageConfigurator.configure(garageController, garage: garage)
    view?.navigationController?.show(garageController, sender: nil)
  }
  
  func showMenu() {
    view?.showSideMenu()
  }
  
  func openBookings() {
    view?.openBookings()
  }
  
  func sort() {
    guard let sortController = SortViewController.instantiate() else { return }
    UIApplication.shared.keyWindow?.rootViewController?.present(sortController, animated: true, completion: nil)
  }
  
  func filter() {
    guard let filterController = FilterViewController.instantiate() else { return }
    view?.navigationController?.show(filterController, sender: self)
  }
}
