//
//  ServiceDetailsPresenter.swift
//  Driva
//
//  Created by iDeveloper on 24.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

enum ServiceDetailsSection: Int {
  case garage
  case vehicle
  case workComlpleted
  case booking
}

protocol ServiceDetailsView: BaseViewController {
}

protocol ServiceDetailsPresenter {
  var numberOfFixes: Int { get }
  
  func viewDidLoad()
  func backAction()
  
  func configure(_ garageCell: ServiceDetailsGarageCell, for index: Int)
  func configure(_ vehicleCell: ServiceDetailsVehicleCell, for index: Int)
  func configure(_ workCell: ServiceDetailsWorkCell, for index: Int)
  func configure(_ bookingCell: ServiceDetailsBookingCell, for index: Int)

  func garageSelected()
  func reviewAction()
}

protocol ServiceDetailsRouter {
  func back()
  func toReview(with garage: Garage)
}

class ServiceDetailsPresenterImplementation {
  private weak var view: ServiceDetailsView?
  private let router: ServiceDetailsRouter
  
  let service: HistoryService
  
  //MARK: -
  
  init(view: ServiceDetailsView, router: ServiceDetailsRouter, with service: HistoryService) {
    self.view = view
    self.router = router
    self.service = service
  }
  
  //MARK: -
  
  
}

//MARK: - ServiceDetailsPresenter
extension ServiceDetailsPresenterImplementation: ServiceDetailsPresenter {
  var numberOfFixes: Int {
    return service.fixes.count
  }
  
  func viewDidLoad() {

  }
  
  func backAction() {
    router.back()
  }
  
  func configure(_ garageCell: ServiceDetailsGarageCell, for index: Int) {
    garageCell.logo = service.garage.imageContent
    garageCell.title = service.garage.title
    garageCell.address = service.garage.fullAddress
  }
  
  func configure(_ vehicleCell: ServiceDetailsVehicleCell, for index: Int) {
    vehicleCell.picture = service.vehicleImage
    vehicleCell.title = service.vehicleTitle
    vehicleCell.number = service.vehicleNumber
  }
  
  func configure(_ workCell: ServiceDetailsWorkCell, for index: Int) {
    guard service.fixes.count > index else { return }
    let fix = service.fixes[index]
    workCell.icon = fix.icon
    workCell.title = fix.title
  }
  
  func configure(_ bookingCell: ServiceDetailsBookingCell, for index: Int) {
    switch index {
    case 0:
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
      bookingCell.icon = #imageLiteral(resourceName: "menu_icon_bookings")
      bookingCell.title = dateFormatter.string(from: service.date)
    case 1:
      bookingCell.icon = #imageLiteral(resourceName: "note")
      bookingCell.title = "Booking Code: " + service.bookingCode
    case 2:
      bookingCell.icon = #imageLiteral(resourceName: "Confirmation Icon")
      bookingCell.title = "Status: " + service.status.rawValue
    default:
      bookingCell.icon = nil
      bookingCell.title = ""
    }
  }
  
  func garageSelected() {
    //TODO: open garage?
  }
  
  func reviewAction() {
    router.toReview(with: service.garage)
  }
}





