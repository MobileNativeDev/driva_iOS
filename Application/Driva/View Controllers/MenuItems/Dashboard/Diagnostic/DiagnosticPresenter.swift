//
//  DiagnosticPresenter.swift
//  Driva
//
//  Created by iDeveloper on 09.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

enum DiagnosticTab: Int {
  case engine
  case airCooler
  case fuel
  case suspension
  case battery
  case door
  
  var name: String {
    switch self {
    case .engine: return "ENGINE"
    case .airCooler: return "AIR COOLER"
    case .fuel: return "FUEL"
    case .suspension: return "SUSPENSION"
    case .battery: return "BATTERY"
    case .door: return "DOOR"
    }
  }
  
  var icon: UIImage {
    switch self {
    case .engine: return #imageLiteral(resourceName: "problem_icon_engine")
    case .airCooler: return #imageLiteral(resourceName: "problem_icon_freeze")
    case .fuel: return #imageLiteral(resourceName: "problem_icon_fuel")
    case .suspension: return #imageLiteral(resourceName: "problem_icon_suspension")
    case .battery: return #imageLiteral(resourceName: "problem_icon_battery")
    case .door: return #imageLiteral(resourceName: "problem_icon_wheel")
    }
  }
 
//FIXME: do some
//  let problemsExist: Bool
}

protocol DiagnosticView: BaseViewController {
  func showTabs(_ tabs: [DiagnosticTab])
  func showEmptyView(_ show: Bool)
}

protocol DiagnosticPresenter {
  func viewDidLoad()
  func viewWillAppear()
  
  func menuAction()
  func scanAction()
  func connectAction()
  
  func problemDetailsAction()
}

protocol DiagnosticRouter {
  func showMenu()
  func toConnect(with mode: ConnectMode, scanCompletion: @escaping (_ temperatures: [TemperaturePoint]) -> ())
  func toProblems(_ problems: [VehicleProblem])
}

class DiagnosticPresenterImplementation {
  private weak var view: DiagnosticView?
  private let router: DiagnosticRouter

  var vehicle: Vehicle?
  
  var tabs: [DiagnosticTab] = [.engine, .airCooler, .fuel, .suspension, .battery, .door]
  
  //MARK: -
  
  init(view: DiagnosticView, router: DiagnosticRouter) {
    self.view = view
    self.router = router
  }
  
  //MARK: -
  
  private func updateEmptyView() {
    if let vehicle = vehicle, let temperatures = vehicle.temperatures {
      view?.showEmptyView(temperatures.count <= 0)
    } else {
      view?.showEmptyView(true)
    }
  }
}

//MARK: - DiagnosticPresenter
extension DiagnosticPresenterImplementation: DiagnosticPresenter {
  func viewDidLoad() {
    //TODO: first != current
    vehicle = VehiclesHelper.shared.vehicles.first
    view?.showTabs(tabs)
  }
  
  func viewWillAppear() {
    updateEmptyView()
  }
  
  func menuAction() {
    router.showMenu()
  }
  
  func scanAction() {
    //FIXME: mock
    router.toConnect(with: .scan(Adapter(logo: #imageLiteral(resourceName: "Car logo"), title: "BMW 8", status: "On"))) { [weak self] temperatures in
      //TODO: 
    }
  }
  
  func problemDetailsAction() {
    guard let problems = vehicle?.problems else { return }
    router.toProblems(problems)
  }
  
  func connectAction() {
    router.toConnect(with: .connect, scanCompletion: { [weak self] temperatures in
      
      //FIXME: mock
      let vehicle = Vehicle.mock()
      VehiclesHelper.shared.saveVehicle(vehicle)
      
      self?.vehicle = vehicle
      self?.view?.showEmptyView(vehicle.temperatures?.count ?? 0 <= 0)
    })
  }
}





