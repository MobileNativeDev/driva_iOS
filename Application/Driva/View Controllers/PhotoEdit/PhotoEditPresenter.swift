//
//  PhotoEditPresenter.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol PhotoEditView: BaseViewController {
  func showImage(_ image: UIImage)
}

protocol PhotoEditPresenter {
  func viewDidLoad()
  
  func pictureAction()
  func cropAction()
  func resetAction()
  func pencilAction()
  func shareAction()
  
  func backAction()
  func confirmAction(with image: UIImage?)
}

protocol PhotoEditRouter {
  func close()
}

class PhotoEditPresenterImplementation {
  private weak var view: PhotoEditView?
  private let router: PhotoEditRouter
  
  var image: UIImage
  var comfirmImageAction: ( (UIImage?) -> () )?
  
  //MARK: -
  
  init(view: PhotoEditView, router: PhotoEditRouter, image: UIImage, confirmAction: @escaping (UIImage?) -> ()) {
    self.view = view
    self.router = router
    self.image = image
    self.comfirmImageAction = confirmAction
  }
}

//MARK: - PhotoEditPresenter
extension PhotoEditPresenterImplementation: PhotoEditPresenter {
  func viewDidLoad() {
    view?.showImage(image)
  }
  
  func pictureAction() {
    //TODO: pictureAction
  }
  
  func cropAction() {
    //TODO: cropAction
  }
  
  func resetAction() {
    //TODO: resetAction
  }
  
  func pencilAction() {
    //TODO: pencilAction
  }
  
  func shareAction() {
    //TODO: share action
  }
  
  func backAction() {
    router.close()
  }
  
  func confirmAction(with image: UIImage?) {
    comfirmImageAction?(image)
    router.close()
  }
}










