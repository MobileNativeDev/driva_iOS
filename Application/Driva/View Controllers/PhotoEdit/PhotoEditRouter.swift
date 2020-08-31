//
//  PhotoEditRouter.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class PhotoEditRouterImplementation {
  private weak var view: PhotoEditViewController?
  
  init(view: PhotoEditViewController) {
    self.view = view
  }
}

//MARK: - PhotoEditRouter
extension PhotoEditRouterImplementation: PhotoEditRouter {
  func close() {
    view?.navigationController?.popViewController(animated: true)
  }
}
