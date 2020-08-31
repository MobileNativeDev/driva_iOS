//
//  LeaveReviewPresenter.swift
//  Driva
//
//  Created by iDeveloper on 27.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol LeaveReviewView: BaseViewController {
  func showLogo(_ logo: UIImage)
  func showTitle(_ title: String)
  func showAddress(_ address: String)
  func showRating(_ rating: Int)
  func showLevel(_ level: String)
}

protocol LeaveReviewPresenter {
  func viewDidLoad()
  func backAction()
  func submitAction()
}

protocol LeaveReviewRouter {
  func back()
  func reviewSubmition()
}

class LeaveReviewPresenterImplementation {
  private weak var view: LeaveReviewView?
  private let router: LeaveReviewRouter
  
  let garage: Garage
  
  //MARK: -
  
  init(view: LeaveReviewView, router: LeaveReviewRouter, garage: Garage) {
    self.view = view
    self.router = router
    self.garage = garage
  }
  
  //MARK: -
}

//MARK: - LeaveReviewPresenter
extension LeaveReviewPresenterImplementation: LeaveReviewPresenter {
  func viewDidLoad() {
    view?.showLogo(garage.imageContent)
    view?.showTitle(garage.title)
    view?.showAddress(garage.fullAddress)
    view?.showRating(Int(garage.starRating))
    view?.showLevel("")
  }
  
  func backAction() {
    router.back()
  }
  
  func submitAction() {
    router.reviewSubmition()
  }
}
