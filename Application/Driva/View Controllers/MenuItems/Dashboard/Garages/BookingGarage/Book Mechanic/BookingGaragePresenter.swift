//
//  BookingGaragePresenter.swift
//  Driva
//
//  Created by iDeveloper on 27.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

enum BookingGarageSection: Int {
  case garage
  case vehicle
  case info
  
  static var numberOfSections = 3
  
  var title: String? {
    switch self {
    case .garage: return nil
    case .vehicle: return "VEHICLE:"
    case .info: return "BOOKING DETAIL:"
    }
  }
  
  var headerHeight: Float {
    switch self {
    case .garage: return 1
    case .vehicle, .info: return 44
    }
  }
  
  var cellHeight: Float {
    switch self {
    case .garage, .vehicle: return 94
    case .info: return 44
    }
  }
  
  var numberOfRows: Int {
    switch self {
    case .garage, .vehicle: return 1
    case .info: return 2
    }
  }
}

protocol BookingGarageView: BaseViewController {
  func reloadDate()
}

protocol BookingGaragePresenter {
  func viewDidLoad()
  func backAction()
  func nextAction()
  
  func configure(_ cell: ServiceDetailsGarageCell, for index: Int)
  func configure(_ cell: ServiceDetailsVehicleCell, for index: Int)
  func configure(_ cell: ServiceDetailsBookingCell, for index: Int)
  
  func select(with section: Int, and index: Int)
}

protocol BookingGarageRouter {
  func back()
  func next()
  func toCalender(with date: Date, completion: @escaping ( (Date) -> () ))
  func toProblems()
}

class BookingGaragePresenterImplementation {
  private weak var view: BookingGarageView?
  private let router: BookingGarageRouter
  
  private let garage: GarageShortInfo
  private let vehicle: Vehicle
  
  private var selectedDate = Date()
  
  //MARK: -
  
  init(view: BookingGarageView, router: BookingGarageRouter, garage: GarageShortInfo, vehicle: Vehicle) {
    self.view = view
    self.router = router
    self.vehicle = vehicle
    self.garage = garage
  }
  
  //MARK: -
  
}

//MARK: - BookingGaragePresenter
extension BookingGaragePresenterImplementation: BookingGaragePresenter {
  func viewDidLoad() {

  }
  
  func backAction() {
    router.back()
  }
  
  func nextAction() {
    router.next()
  }
  
  func configure(_ cell: ServiceDetailsGarageCell, for index: Int) {
    cell.logo = garage.imageContent
    cell.title = garage.title
    cell.address = garage.fullAddress
  }
  
  func configure(_ cell: ServiceDetailsVehicleCell, for index: Int) {
    cell.picture = vehicle.image
    cell.title = "\(vehicle.profile?.make ?? "") \(vehicle.profile?.model ?? "")"
    cell.number = vehicle.profile?.plateNumber ?? ""
  }
  
  func configure(_ cell: ServiceDetailsBookingCell, for index: Int) {
    //FIXME: mocks
    switch index {
    case 0:
      cell.icon =  #imageLiteral(resourceName: "menu_icon_bookings")
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
      cell.title = dateFormatter.string(from: selectedDate)
    case 1:
      cell.icon = #imageLiteral(resourceName: "note")
      cell.title = "Select Problem"
    default: break
    }
  }
  
  func select(with section: Int, and index: Int) {
    let section = BookingGarageSection(rawValue: section) ?? .garage
    switch section {
    case .garage: break
    case .vehicle: break
    case .info:
      switch index {
        //mock date!
      case 0: router.toCalender(with: selectedDate, completion: { [weak self] selectedDate in
        self?.selectedDate = selectedDate
        self?.view?.reloadDate()
      })
      case 1: router.toProblems()
      default: break
      }
    }
  }
}







