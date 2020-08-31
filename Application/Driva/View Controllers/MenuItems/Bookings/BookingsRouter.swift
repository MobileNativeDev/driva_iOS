//
//  BookingsRouter.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class BookingsRouterImplementation {
  private weak var view: BookingsViewController?
  
  init(view: BookingsViewController) {
    self.view = view
  }
}

//MARK: - BookingsRouter
extension BookingsRouterImplementation: BookingsRouter {
  func showMenu() {
    view?.showSideMenu()
  }
}
