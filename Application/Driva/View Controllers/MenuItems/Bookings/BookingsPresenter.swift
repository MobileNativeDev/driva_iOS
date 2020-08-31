//
//  BookingsPresenter.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct Booking {
  let avatar: UIImage?
  let title: String?
  let status: String?
}

protocol BookingsView: BaseViewController {
  
}

protocol BookingsPresenter {
  var numberOfBookings: Int { get }
  
  func viewWillAppear()
  func configure(_ cell: BookingCell, for index: Int)
  
  func menuAction()
  func addAction()
}

protocol BookingsRouter {
  func showMenu()
}

class BookingsPresenterImplementation {
  private weak var view: BookingsView?
  private let router: BookingsRouter
  
  //FIXME:
  var bookings = [
    Booking(avatar: nil, title: "Hayes Engineer", status: "Waiting approval"),
    Booking(avatar: nil, title: "Maypole Motors", status: "In Progress"),
    Booking(avatar: nil, title: "Renno Services", status: "Done"),
  ]
  
  //MARK: -
  
  init(view: BookingsView, router: BookingsRouter) {
    self.view = view
    self.router = router
  }
  
  
}

//MARK: - BookingsPresenter
extension BookingsPresenterImplementation: BookingsPresenter {
  var numberOfBookings: Int {
    return bookings.count
  }

  func viewWillAppear() {
    //TODO: reload actual data?
  }
  
  func configure(_ cell: BookingCell, for index: Int) {
    guard bookings.count > index else { return }
    let booking = bookings[index]
    
    cell.avatar = booking.avatar
    cell.title = booking.title
    cell.status = booking.status
  }
  
  func menuAction() {
    router.showMenu()
  }
  
  func addAction() {
    //TODO: add action
  }
}
























