//
//  AddVehiclePresenter.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

protocol AddVehicleView: BaseViewController {
  func showPlateNumber(_ number: String)
  func showMake(_ make: String)
  func showModel(_ model: String)
  func showEngineSize(_ size: String)
  func showBodyType(_ type: String)
  func showTransmission(_ transmission: String)
  func showColour(_ colour: String)
  func showYear(_ year: String)
  func showVIN(_ vin: String)
}

protocol AddVehiclePresenter {
  func viewDidLoad()
  func addAction()
}

protocol AddVehicleRouter {
  func success(with vehicle: Vehicle)
}

class AddVehiclePresenterImplementation {
  private weak var view: AddVehicleView?
  private let router: AddVehicleRouter
  
  var vehicle: Vehicle
  
  //MARK: -
  
  init(view: AddVehicleView, router: AddVehicleRouter, with vehicle: Vehicle) {
    self.view = view
    self.router = router
    self.vehicle = vehicle
  }
  
  //MARK: -
  
  private func showProfile() {
    guard let profile = vehicle.profile else { return }
    
    view?.showPlateNumber(profile.plateNumber ?? "")
    view?.showMake(profile.make ?? "")
    view?.showModel(profile.model ?? "")
    view?.showEngineSize(profile.engineSize ?? "")
    view?.showBodyType(profile.bodyType ?? "")
    view?.showTransmission(profile.transmission ?? "")
    view?.showColour(profile.colour ?? "")
    view?.showYear(profile.year ?? "")
    view?.showVIN(profile.vin ?? "")
  }
}

//MARK: - AddVehiclePresenter
extension AddVehiclePresenterImplementation: AddVehiclePresenter {
  func viewDidLoad() {
    showProfile()
  }
  
  func addAction() {
    router.success(with: vehicle)
  }
}




