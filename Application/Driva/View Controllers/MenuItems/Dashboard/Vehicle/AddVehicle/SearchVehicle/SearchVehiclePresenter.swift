//
//  SearchVehiclePresenter.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

protocol SearchVehicleView: BaseViewController {
  
}

protocol SearchVehiclePresenter {
  func backAction()
  func goAction(with number: String?)
}

protocol SearchVehicleRouter {
  func close()
  func go(with vehicle: Vehicle)
}

class SearchVehiclePresenterImplementation {
  private weak var view: SearchVehicleView?
  private let router: SearchVehicleRouter
  
  //MARK: -
  
  init(view: SearchVehicleView, router: SearchVehicleRouter) {
    self.view = view
    self.router = router
  }
}

//MARK: - SearchVehiclePresenter
extension SearchVehiclePresenterImplementation: SearchVehiclePresenter {
  
  func backAction() {
    router.close()
  }
  
  func goAction(with number: String?) {
    
    let profile = VehicleProfile(plateNumber: "012345",
                                 make: "BMW",
                                 model: "Concept 8",
                                 engineSize: "L4 - 2.0L",
                                 bodyType: "Sedan",
                                 transmission: "Automatic",
                                 colour: "White",
                                 year: "2018",
                                 vin: "321123")
    
    //FIXME: mock
    let vehicle = Vehicle(image: #imageLiteral(resourceName: "Photo_Car_Big"),
                          logo: #imageLiteral(resourceName: "Car logo"),
                          vehicleStats: nil,
                          problems: nil,
                          history: nil,
                          profile: profile,
                          temperatures: nil)
    router.go(with: vehicle)
  }
}




