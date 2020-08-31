//
//  SelectDateRouter.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class SelectDateRouterImplementation {
  private weak var view: SelectDateViewController?
  
  //MARK: -
  
  init(view: SelectDateViewController) {
    self.view = view
  }
}

//MARK: - SelectDateRouter
extension SelectDateRouterImplementation: SelectDateRouter {
  func backAction() {
    view?.navigationController?.popViewController(animated: true)
  }
}
