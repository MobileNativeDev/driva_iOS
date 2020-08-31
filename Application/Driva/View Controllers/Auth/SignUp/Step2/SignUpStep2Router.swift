//
//  SignUpStep2Router.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

class SignUpStep2RouterImplementation {
  private weak var view: SignUpStep2ViewController?
  
  init(view: SignUpStep2ViewController) {
    self.view = view
  }
}

//MARK: - SignUpStep2Router
extension SignUpStep2RouterImplementation: SignUpStep2Router {
  func toDashboard() {
    guard var viewControllers = view?.navigationController?.viewControllers else { return }
    let hostMenuController = HostMenuViewController.instantiate()
    
    viewControllers.removeLast()
    viewControllers.append(hostMenuController)
    
    view?.navigationController?.setNavigationBarHidden(true, animated: false)
    view?.navigationController?.setViewControllers(viewControllers, animated: true)
  }
  
  func toEditPhoto(_ photo: UIImage, with confirmAction: @escaping (UIImage?) -> ()) {
    guard let photoEditController = PhotoEditViewController.instantiate() else { return }
    PhotoEditConfigurator.configure(photoEditController, with: photo, and: confirmAction)
    view?.navigationController?.show(photoEditController, sender: self)
  }
}
