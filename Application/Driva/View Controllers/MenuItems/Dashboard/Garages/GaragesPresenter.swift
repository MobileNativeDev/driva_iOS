//
//  GaragesPresenter.swift
//  Driva
//
//  Created by iDeveloper on 10.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol GaragesView: BaseViewController {
  
}

protocol GaragesPresenter {
  var numberOfGarages: Int { get }
  
  func viewDidLoad()
  func configure(_ cell: GarageCell, for index: Int)
  
  func menuAction()
  func filterAction()
  func sortAction()
  func garageSelected(with index: Int)
}

protocol GaragesRouter {
  func toGarage(_ garage: GarageShortInfo)
  func showMenu()
  func openBookings()
  
  func sort()
  func filter()
}

class GaragesPresenterImplementation {
  private weak var view: GaragesView?
  private let router: GaragesRouter
  
  let garages = [
    GarageShortInfo(imageContent: #imageLiteral(resourceName: "garage0"), title: "Maypole Motors", fullAddress: "231 - 235 Empress St., Bromley, BR8 2XS", address: "BROMLEY, BR1 2AR", link: "www.maypolemotors.co.uk"),
    GarageShortInfo(imageContent: #imageLiteral(resourceName: "garage1"), title: "Hayes Engineer", fullAddress: "235 - 239 Empress St., Bromley, BR8 2XS", address: "BROMLEY, BR8 2XS", link: "www.hayesengineer.co.uk"),
    GarageShortInfo(imageContent: #imageLiteral(resourceName: "garage3"), title: "Renno Services", fullAddress: "239 - 243 Empress St., Bromley, BR8 2XS", address: "BROMLEY, BR5 2AQ", link: "www.rennoservices.co.uk"),
    GarageShortInfo(imageContent: #imageLiteral(resourceName: "garage3"), title: "Garage Express", fullAddress: "243 - 247 Empress St., Bromley, BR8 2XS", address: "BROMLEY, BR1 2AN", link: "www.garageexpress.co.uk"),
    GarageShortInfo(imageContent: #imageLiteral(resourceName: "garage0"), title: "Maypole Motors", fullAddress: "247 - 251 Empress St., Bromley, BR8 2XS", address: "BROMLEY, BR1 2AR", link: "www.maypolemotors.co.uk"),
    GarageShortInfo(imageContent: #imageLiteral(resourceName: "garage1"), title: "Hayes Engineer", fullAddress: "251 - 255 Empress St., Bromley, BR8 2XS", address: "BROMLEY, BR8 2XS", link: "www.hayesengineer.co.uk"),
    GarageShortInfo(imageContent: #imageLiteral(resourceName: "garage3"), title: "Renno Services", fullAddress: "255 - 259 Empress St., Bromley, BR8 2XS", address: "BROMLEY, BR5 2AQ", link: "www.rennoservices.co.uk"),
    GarageShortInfo(imageContent: #imageLiteral(resourceName: "garage3"), title: "Garage Express", fullAddress: "259 - 263 Empress St., Bromley, BR8 2XS", address: "BROMLEY, BR1 2AN", link: "www.garageexpress.co.uk")
  ]
  
  //MARK: -
  
  init(view: GaragesView, router: GaragesRouter) {
    self.view = view
    self.router = router
  }
  
}

//MARK: - GaragesPresenter
extension GaragesPresenterImplementation: GaragesPresenter {
  var numberOfGarages: Int {
    return garages.count
  }
  
  func viewDidLoad() {
    
  }
  
  func configure(_ cell: GarageCell, for index: Int) {
    guard garages.count > index else { return }
    let garage = garages[index]
    
    cell.imageContent = garage.imageContent
    cell.title = garage.title
    cell.address = garage.address
    cell.state = .normal
  }
  
  func menuAction() {
    router.showMenu()
  }
  
  func filterAction() {
    router.filter()
  }
  
  func sortAction() {
    router.sort()
  }
  
  func garageSelected(with index: Int) {
    guard garages.count > index else { return }
    let garage = garages[index]
    router.toGarage(garage)
  }
}




















