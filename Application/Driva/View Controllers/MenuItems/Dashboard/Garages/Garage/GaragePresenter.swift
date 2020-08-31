//
//  GaragePresenter.swift
//  Driva
//
//  Created by iDeveloper on 14.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol GarageView: BaseViewController {
  func showImage(_ image: UIImage)
  func showTitle(_ title: String)
  func showAddress(_ address: String)
  func showLink(_ link: String)
  func show(totalBooked: String, starRating: String, yearsMember: String)
  
  func showTab(_ tab: GarageTab)
}

protocol GaragePresenter {
  func viewDidLoad()
  
  func backAction()
  func favoriteAction()
  func linkAction(_ link: URL)
  
  func getGarageInfo() -> Garage?
  func bookAction()
  func callAction()
}

protocol GarageRouter {
  func back()
  func book(with garage: GarageShortInfo, and vehicle: Vehicle)
}

class GaragePresenterImplementation {
  private weak var view: GarageView?
  private let router: GarageRouter
  
  let garage: GarageShortInfo
  var garageInfo: Garage?
  
  //MARK: -
  
  init(view: GarageView, router: GarageRouter, garage: GarageShortInfo) {
    self.view = view
    self.router = router
    self.garage = garage
  }
  
  //MARK: -
  
  private func getGarageInfo(completionHandler: (_ garage: Garage) -> ()) {
    let garage = Garage.fake(1)
    completionHandler(garage)
  }
}

//MARK: - GaragePresenter
extension GaragePresenterImplementation: GaragePresenter {
  func getGarageInfo() -> Garage? {
    return garageInfo
  }
  
  func viewDidLoad() {
    view?.showImage(garage.imageContent)
    view?.showTitle(garage.title)
    view?.showAddress(garage.fullAddress)
    view?.showLink(garage.link)
    
    getGarageInfo { [weak self] garage in
      self?.view?.showImage(garage.imageContent)
      self?.view?.showTitle(garage.title)
      self?.view?.showAddress(garage.fullAddress)
      self?.view?.showLink(garage.link)
      self?.view?.show(totalBooked: "\(garage.totalBooked)",
                       starRating: "\(garage.starRating)",
                       yearsMember: "\(garage.yearsMember)")
      
      self?.garageInfo = garage
      view?.showTab(.profile)
    }
  }
  
  func backAction() {
    router.back()
  }
  
  func favoriteAction() {
    //TODO: add to favorite
  }
  
  func linkAction(_ link: URL) {
    UIApplication.shared.open(link, options: [:], completionHandler: nil)
  }
  
  func bookAction() {
    //FIXME: mocks
    let vehicle = VehiclesHelper.shared.vehicles.first
    router.book(with: garage, and: vehicle ?? Vehicle.mock())
  }
  
  func callAction() {
    //TODO: call action
  }
}






