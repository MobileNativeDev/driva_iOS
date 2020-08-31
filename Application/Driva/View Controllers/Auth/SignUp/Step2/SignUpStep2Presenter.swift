//
//  SignUpStep2Presenter.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol SignUpStep2View: BaseViewController {
  func showImagePicker()
  func showImage(_ resultImage: UIImage?)
}

protocol SignUpStep2Presenter {
  func signUpAction()
  func skipAction()
  func uploadAction()
  func photoPicked(_ photo: UIImage)
}

protocol SignUpStep2Router {
  func toDashboard()
  func toEditPhoto(_ photo: UIImage, with confirmAction: @escaping (UIImage?) -> ())
}

class SignUpStep2PresenterImplementation {
  private weak var view: SignUpStep2View?
  private let router: SignUpStep2Router
  
  //MARK: -
  
  init(view: SignUpStep2View, router: SignUpStep2Router) {
    self.view = view
    self.router = router
  }
}

//MARK: - SignUpStep2Presenter
extension SignUpStep2PresenterImplementation: SignUpStep2Presenter {
  func signUpAction() {
    router.toDashboard()
  }
  
  func skipAction() {
    router.toDashboard()
  }
  
  func uploadAction() {
    view?.showImagePicker()
  }
  
  func photoPicked(_ photo: UIImage) {
    router.toEditPhoto(photo) { [weak self] resultImage in
      self?.view?.showImage(resultImage)
    }
  }
}
