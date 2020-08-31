//
//  SelectProblemRouter.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class SelectProblemRouterImplementation {
  private weak var view: SelectProblemViewController?
  
  //MARK: -
  
  init(view: SelectProblemViewController) {
    self.view = view
  }
}

//MARK: - SelectProblemRouter
extension SelectProblemRouterImplementation: SelectProblemRouter {
  func back() {
    view?.navigationController?.popViewController(animated: true)
  }
}
