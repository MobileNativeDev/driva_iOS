//
//  OnBoardingPresenter.swift
//  Driva
//
//  Created by iDeveloper on 16.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct OnBoardingInfo {
  let image: UIImage?
  let title: String
  let _description: String
  let isStarted: Bool
}

protocol OnBoardingView: BaseViewController {

}

protocol OnBoardingPresenter {
  var numberOfPages: Int { get }
  
  func configure(_ cell: OnBoardingCell, for index: Int)
}

protocol OnBoardingRouter {
  func toLogin()
}

class OnBoardingPresenterImplementation {
  private weak var view: OnBoardingView?
  private let router: OnBoardingRouter
  
  private let data: [OnBoardingInfo] = [
    OnBoardingInfo(image: nil, title: "Easily monitor your car anytime & anywhere", _description: "Driva makes it easy for you to manage your cars and monitor them anywhere you go", isStarted: false),
    OnBoardingInfo(image: nil, title: "Automatic car diagnosis and notifications", _description: "Your car is as smart as you are. Driva will notify you when your car is getting emergency trouble", isStarted: false),
    OnBoardingInfo(image: nil, title: "Book mechanics at your fingertips", _description: "Communicate your car diagnosis with professional mechanics and car services around you", isStarted: true)
  ]
  
  //MARK: -
  
  init(view: OnBoardingView, router: OnBoardingRouter) {
    self.view = view
    self.router = router
  }
}

//MARK: - OnBoardingPresenter
extension OnBoardingPresenterImplementation: OnBoardingPresenter {
  var numberOfPages: Int {
    return data.count
  }
  
  func configure(_ cell: OnBoardingCell, for index: Int) {
    guard data.count > index else { return }
    let page = data[index]
    
    if let image = page.image {
      cell.image = image
    }
    cell.title = page.title
    cell._description = page._description
    cell.isStarted = page.isStarted
    
    cell.startedAction = { [weak self] in
      self?.router.toLogin()
    }
  }
}











