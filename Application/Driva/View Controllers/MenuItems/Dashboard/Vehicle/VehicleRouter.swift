//
//  VehicleRouter.swift
//  Driva
//
//  Created by iDeveloper on 07.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class VehicleRouterImplementation {
  private weak var view: VehicleViewController?
  
  init(view: VehicleViewController) {
    self.view = view
  }
}

//MARK: - VehicleRouter
extension VehicleRouterImplementation: VehicleRouter {
  func showMenu() {
    view?.showSideMenu()
  }
  
  func showSearchVehicle(successfullyAddedCompletion: @escaping ((_ vehicle: Vehicle) -> ())) {
    guard let controller = AddVehicleNavigationController.instantiate() else { return }
    controller.successfullyCompletion = successfullyAddedCompletion
    view?.present(controller, animated: true, completion: nil)
  }
  
  func toProblem(_ problem: VehicleProblem) {
    guard let details = ProblemDetailsViewController.instantiate() else { return }
    ProblemDetailsConfigurator.configure(details, with: problem)
    view?.navigationController?.show(details, sender: self)
  }
  
  func toService(_ service: HistoryService) {
    guard let detailsNavigation = ServiceDetailsNavigationController.instantiate() else { return }
    guard let details = detailsNavigation.viewControllers.first as? ServiceDetailsViewController else { return }
    ServiceDetailsConfigurator.configure(details, with: service)
    view?.present(detailsNavigation, animated: true, completion: nil)
  }
  
  func toUpgrade() {
    guard let upgradeNavigation = UpgradeNavigationController.instantiate(),
      let upgradeController = upgradeNavigation.viewControllers.first as? UpgradeViewController else { return }
    upgradeController.navigationMode = .stackItem
    UIApplication.shared.keyWindow?.rootViewController?.present(upgradeNavigation, animated: true, completion: nil)
  }
}
