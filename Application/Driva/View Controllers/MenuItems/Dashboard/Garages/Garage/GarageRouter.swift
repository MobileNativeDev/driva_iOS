//
//  GarageRouter.swift
//  Driva
//
//  Created by iDeveloper on 14.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class GarageRouterImplementation {
  private weak var view: GarageViewController?
  
  init(view: GarageViewController) {
    self.view = view
  }
}

//MARK: - GarageRouter
extension GarageRouterImplementation: GarageRouter {
  func back() {
    view?.navigationController?.popViewController(animated: true)
  }
  
  func book(with garage: GarageShortInfo, and vehicle: Vehicle) {
    
    guard let bookNavigation = BookingGarageNavigationController.instantiate() else { return }
    guard let bookingGarageController = bookNavigation.viewControllers.first as? BookingGarageViewController else { return }
    
    bookNavigation.bookingCompletion = { [weak self] in
      if let garagesController = self?.view?.navigationController?.viewControllers.first(where: { $0 is GaragesViewController }) as? GaragesViewController {
        garagesController.openBookings()
      }
    }
    
    BookingGarageConfigurator.configure(bookingGarageController, garage: garage, and: vehicle)
    view?.present(bookNavigation, animated: true, completion: nil)
  }
}










