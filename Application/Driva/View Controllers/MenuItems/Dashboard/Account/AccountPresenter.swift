//
//  AccountPresenter.swift
//  Driva
//
//  Created by iDeveloper on 13.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct Account {
  let photo: UIImage
  let name: String
  let nickname: String
}

protocol AccountView: BaseViewController {
  func showPhoto(_ photo: UIImage)
  func showName(_ name: String)
  func showNick(_ nick: String)
  func showTab(_ tab: AccountTab)
}

protocol AccountPresenter {
  var garages: [GarageShortInfo] { get }
  var history: [GarageHistoryInfo] { get }
  var reviews: [Review] { get }
  
  func viewDidLoad()
  func menuAction()
  func settingsAction()
  func garageSelected(with index: Int)
  func review(for index: Int)
}

protocol AccountRouter {
  func toGarage(with garage: GarageShortInfo)
  func showMenu()
  func showSettings()
  func toReview(with garage: Garage)
}

class AccountPresenterImplementation {
  private weak var view: AccountView?
  private let router: AccountRouter
  
  //FIXME: mocks
  let favoriteGarages = [
    GarageShortInfo(imageContent: #imageLiteral(resourceName: "garage0"), title: "Maypole Motors", fullAddress: "247 - 251 Empress St., Bromley, BR8 2XS", address: "BROMLEY, BR1 2AR", link: "www.maypolemotors.co.uk"),
    GarageShortInfo(imageContent: #imageLiteral(resourceName: "garage1"), title: "Hayes Engineer", fullAddress: "251 - 255 Empress St., Bromley, BR8 2XS", address: "BROMLEY, BR8 2XS", link: "www.hayesengineer.co.uk"),
    GarageShortInfo(imageContent: #imageLiteral(resourceName: "garage3"), title: "Renno Services", fullAddress: "255 - 259 Empress St., Bromley, BR8 2XS", address: "BROMLEY, BR5 2AQ", link: "www.rennoservices.co.uk"),
    GarageShortInfo(imageContent: #imageLiteral(resourceName: "garage3"), title: "Garage Express", fullAddress: "259 - 263 Empress St., Bromley, BR8 2XS", address: "BROMLEY, BR1 2AN", link: "www.garageexpress.co.uk")
  ]
  let mechanicHistory = [
    GarageHistoryInfo(garage: Garage.fake(1), finishedOn: "January 02, 2018"),
    GarageHistoryInfo(garage: Garage.fake(2), finishedOn: "January 27, 2018"),
    GarageHistoryInfo(garage: Garage.fake(3), finishedOn: "May 23, 2018"),
    GarageHistoryInfo(garage: Garage.fake(4), finishedOn: "June 02, 2018"),
    GarageHistoryInfo(garage: Garage.fake(5), finishedOn: "July 14, 2018")
  ]
  let reviewsData =  [
    Review(logo: #imageLiteral(resourceName: "garage1"), title: "Maypole Motors", address: "BROMLEY, BR1 2AR", rating: 1, review: "lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor"),
    Review(logo: #imageLiteral(resourceName: "garage0"), title: "Hayes Engineer", address: "BROMLEY, BR2 2AR", rating: 2, review: "lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor "),
    Review(logo: #imageLiteral(resourceName: "garage3"), title: "Renno Services", address: "BROMLEY, BR3 2AR", rating: 3, review: "lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor "),
    Review(logo: #imageLiteral(resourceName: "garage1"), title: "Maypole Motors2", address: "BROMLEY, BR4 2AR", rating: 4, review: "lorem ipsum dolor lorem")
  ]
  
  //FIXME: mock
  var account = Account(photo: #imageLiteral(resourceName: "Profile Photo"), name: "Jonathan Gourdoff", nickname: "@Jongourdoff")
  
  //MARK: -
  
  init(view: AccountView, router: AccountRouter) {
    self.view = view
    self.router = router
    
    
  }
}

//MARK: - AccountPresenter
extension AccountPresenterImplementation: AccountPresenter {
  var garages: [GarageShortInfo] {
    return favoriteGarages
  }
  
  var history: [GarageHistoryInfo] {
    return mechanicHistory
  }
  
  var reviews: [Review] {
    return reviewsData
  }
  
  func viewDidLoad() {
    view?.showPhoto(account.photo)
    view?.showName(account.name)
    view?.showNick(account.nickname)
    view?.showTab(.favorites)
  }
  
  func menuAction() {
    router.showMenu()
  }
  
  func settingsAction() {
    router.showSettings()
  }
  
  func garageSelected(with index: Int) {
    guard favoriteGarages.count > index else { return }
    let garage = favoriteGarages[index]
    router.toGarage(with: garage)
  }
  
  func review(for index: Int) {
    guard history.count > index else { return }
    let garage = history[index]
    router.toReview(with: garage.garage)
  }
}






