//
//  VehiclePresenter.swift
//  Driva
//
//  Created by iDeveloper on 07.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

protocol VehicleView: BaseViewController {
  func showVehicle(with index: Int)
  func showEmptyVehiclesView(_ show: Bool)
  func showEmptyStatisticsView(_ show: Bool)
  func reloadVehicles()
  func showTab(_ tab: VehicleTab)
  func reloadTab(_ tab: VehicleTab)
}

protocol VehiclePresenter {
  var numberOfVehicles: Int { get }
  var vehicle: Vehicle? { get }
  
  func viewDidLoad()
  func viewWillAppear()
  func configure(_ cell: VehicleCell, for index: Int)
  
  func menuAction()
  func addVehicleAction()
  func nextVehicleAction()
  func previousVehicleAction()
  func tabSelected(_ tab: VehicleTab)
  
  func problemSelected(_ problem: VehicleProblem)
  func serviceSelected(_ service: HistoryService)
}

protocol VehicleRouter {
  func showMenu()
  func showSearchVehicle(successfullyAddedCompletion: @escaping ((_ vehicle: Vehicle) -> ()))
  
  func toProblem(_ problem: VehicleProblem)
  func toService(_ service: HistoryService)
  func toUpgrade()
}

class VehiclePresenterImplementation {
  private weak var view: VehicleView?
  private let router: VehicleRouter
  
  var vehicles = [Vehicle]()
  var currentVehicleIndex: Int = 0
  var currentTab: VehicleTab = .statistic
  
  //MARK: -
  
  init(view: VehicleView, router: VehicleRouter) {
    self.view = view
    self.router = router
  }
  
  //MARK: -
  
  private func updateVehicles(with reload: Bool) {
    vehicles = VehiclesHelper.shared.vehicles
    updateEmptyViews()
    
    if reload {
      view?.reloadVehicles()
    }
    
    view?.reloadTab(currentTab)
  }
  
  private func updateEmptyViews(){
    view?.showEmptyVehiclesView(vehicles.isEmpty)
    
    if vehicles.count > currentVehicleIndex {
      view?.showEmptyStatisticsView(vehicles[currentVehicleIndex].vehicleStats == nil)
    } else {
      view?.showEmptyStatisticsView(true)
    }
  }
}


//MARK: - VehiclePresenter
extension VehiclePresenterImplementation: VehiclePresenter {
  
  var numberOfVehicles: Int {
    return vehicles.count
  }
  
  var vehicle: Vehicle? {
    guard vehicles.count > currentVehicleIndex else { return nil }
    return vehicles[currentVehicleIndex]
  }
  
  func viewDidLoad() {
//    updateVehicles(with: false)
  }

  func viewWillAppear() {
    updateVehicles(with: true)
  }

  
  func configure(_ cell: VehicleCell, for index: Int) {
    guard vehicles.count > index else { return }
    let vehicle = vehicles[index]
    
    cell.vehicleImage = vehicle.image
    cell.logo = vehicle.logo
    cell.title = vehicle.title
    cell.info = vehicle.info
  }
  
  func menuAction() {
    router.showMenu()
  }
  
  func addVehicleAction() {
    if VehiclesHelper.shared.vehicles.count > 0 {
      router.toUpgrade()
    } else {
      router.showSearchVehicle(successfullyAddedCompletion: { [weak self] addedVehicle in
        VehiclesHelper.shared.saveVehicle(addedVehicle)
        self?.updateVehicles(with: true)
      })
    }
  }
  
  func nextVehicleAction() {
    let nextIndex = vehicles.count > currentVehicleIndex + 1 ? currentVehicleIndex + 1 : 0
    view?.showVehicle(with: nextIndex)
    currentVehicleIndex = nextIndex
  }
  
  func previousVehicleAction() {
    let prevIndex = currentVehicleIndex > 0 ? currentVehicleIndex - 1 : vehicles.count - 1
    view?.showVehicle(with: prevIndex)
    currentVehicleIndex = prevIndex
  }
  
  func tabSelected(_ tab: VehicleTab){
    currentTab = tab
    view?.showTab(tab)
  }

  func problemSelected(_ problem: VehicleProblem) {
    router.toProblem(problem)
  }
  
  func serviceSelected(_ service: HistoryService) {
    router.toService(service)
  }
}























