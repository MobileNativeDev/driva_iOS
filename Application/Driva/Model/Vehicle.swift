//
//  Vehicle.swift
//  Driva
//
//  Created by iDeveloper on 07.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct Vehicle {
  var image: UIImage?
  var logo: UIImage?
  var title: String {
    return (profile?.make ?? "") + " " + (profile?.model ?? "")
  }
  var info: String {
    return (profile?.engineSize ?? "") + " " + (profile?.transmission ?? "")
  }
  
  var vehicleStats: VehicleStats?
  var problems: [VehicleProblem]?
  var history: [HistoryService]?
  var profile: VehicleProfile?
  
  var temperatures: [TemperaturePoint]?
}

struct VehicleStats {
  var mileage: Int
  var allWeek: Int
  var nextService: Int
}

struct VehicleProblem {
  let icon: UIImage
  let title: String
  let description: String
  
  let code: String
  let problemName: String
  let problemValue: Int
  let normalValue: Int
  let fullInfo: String
  
  static func fakeProblems(index: Int) -> [VehicleProblem] {
    
    let problems = [
      VehicleProblem(icon: #imageLiteral(resourceName: "problem_icon_freeze"), title: "Freeze Frame", description: "The front frame temperature is abnormal",
                 code: "P0100", problemName: "FREEZE", problemValue: 20, normalValue: 50, fullInfo: "When your OBDII vehicle encounters a problem with a sensor or the engine is not returning values lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
      VehicleProblem(icon: #imageLiteral(resourceName: "problem_icon_engine"), title: "Live Sensor Data", description: "Live sensor data engine is off",
                 code: "P0101", problemName: "SENSOR", problemValue: 19, normalValue: 55, fullInfo: "ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
      VehicleProblem(icon: #imageLiteral(resourceName: "problem_icon_freeze"), title: "Air Filter Disabled", description: "Machine air filter is temporarily disabled",
                 code: "P0102", problemName: "AIR", problemValue: 21, normalValue: 45, fullInfo: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
      VehicleProblem(icon: #imageLiteral(resourceName: "problem_icon_freeze"), title: "Freeze Frame", description: "The front frame temperature is abnormal",
                 code: "P0103", problemName: "FREEZE", problemValue: 22, normalValue: 50, fullInfo: "When your OBDII vehicle encounters a problem with a sensor or the engine is not returning values lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
      VehicleProblem(icon: #imageLiteral(resourceName: "problem_icon_engine"), title: "Live Sensor Data", description: "Live sensor data engine is off",
                 code: "P0104", problemName: "SENSOR", problemValue: 18, normalValue: 55, fullInfo: "ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
      VehicleProblem(icon: #imageLiteral(resourceName: "problem_icon_freeze"), title: "Air Filter Disabled", description: "Machine air filter is temporarily disabled",
                 code: "P0105", problemName: "AIR", problemValue: 23, normalValue: 45, fullInfo: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
      VehicleProblem(icon: #imageLiteral(resourceName: "problem_icon_freeze"), title: "Freeze Frame", description: "The front frame temperature is abnormal",
                 code: "P0106", problemName: "FREEZE", problemValue: 17, normalValue: 50, fullInfo: "When your OBDII vehicle encounters a problem with a sensor or the engine is not returning values lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
      VehicleProblem(icon: #imageLiteral(resourceName: "problem_icon_engine"), title: "Live Sensor Data", description: "Live sensor data engine is off",
                 code: "P0107", problemName: "SENSOR", problemValue: 24, normalValue: 55, fullInfo: "ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum")
    ]
    let k = index > problems.count ? 0 : index
    
    var result = [VehicleProblem]()
    for i in k...(k + 3 < problems.count ? k + 3 : k) {
      result.append(problems[i])
    }
    return result
  }
}

struct HistoryService {
  struct Fix {
    let icon: UIImage
    let title: String
  }
  
  let garage: Garage
  
  let vehicleImage: UIImage
  let vehicleTitle: String
  let vehicleNumber: String
  
  let date: Date
  let fixes: [Fix]
  let bookingCode: String
  let status: BookingStatus
}

enum BookingStatus: String {
  case waitingAproval = "Waiting Aproval"
  case done = "Done"
}

extension Vehicle {
  static func mock() -> Vehicle {
    //FIXME: mock
    let vehicleStats = VehicleStats(mileage: 7250, allWeek: 122, nextService: 2183)
    let problems = VehicleProblem.fakeProblems(index: 0)
    
    let history = [
      HistoryService(garage: Garage.fake(1),
                     vehicleImage: #imageLiteral(resourceName: "Photo_Car_Big"), vehicleTitle: "BMW Concept 8", vehicleNumber: "P703 WRU",
                     date: Date().addingTimeInterval(-Time.dayInSeconds),
                     fixes: [HistoryService.Fix(icon: #imageLiteral(resourceName: "problem_icon_battery"), title: "Close Injector Circuit"),
                             HistoryService.Fix(icon: #imageLiteral(resourceName: "problem_icon_door"), title: "Replace Head Gasket"),
                             HistoryService.Fix(icon: #imageLiteral(resourceName: "problem_icon_toolbox"), title: "Replace some")],
                     bookingCode: "#BF5663", status: .waitingAproval),
      HistoryService(garage: Garage.fake(2),
                     vehicleImage: #imageLiteral(resourceName: "Photo_Car_Big"), vehicleTitle: "BMW Concept 8", vehicleNumber: "P703 WRU",
                     date: Date().addingTimeInterval(-(Time.dayInSeconds * 20)),
                     fixes: [HistoryService.Fix(icon: #imageLiteral(resourceName: "problem_icon_battery"), title: "Close Injector Circuit"),
                             HistoryService.Fix(icon: #imageLiteral(resourceName: "problem_icon_wheel"), title: "Replace Head Gasket"),
                             HistoryService.Fix(icon: #imageLiteral(resourceName: "problem_icon_repair"), title: "Replace Head Gasket")],
                     bookingCode: "#232323", status: .waitingAproval),
      HistoryService(garage: Garage.fake(3),
                     vehicleImage: #imageLiteral(resourceName: "Photo_Car_Big"), vehicleTitle: "BMW Concept 8", vehicleNumber: "P703 WRU",
                     date: Date().addingTimeInterval(-(Time.dayInSeconds * 40)),
                     fixes: [HistoryService.Fix(icon: #imageLiteral(resourceName: "problem_icon_repair"), title: "Replace Head Gasket"),
                             HistoryService.Fix(icon: #imageLiteral(resourceName: "problem_icon_toolbox"), title: "Replace Head Gasket")],
                     bookingCode: "#AAA111", status: .done)
    ]
    
    let profile = VehicleProfile(plateNumber: "012345",
                                 make: "BMW",
                                 model: "Concept 8",
                                 engineSize: "L4 - 2.0L",
                                 bodyType: "Sedan",
                                 transmission: "Automatic",
                                 colour: "White",
                                 year: "2018",
                                 vin: "3211231")
    
    let temperatures =  [
      TemperaturePoint(title: "AIR TEMPERATURE", temperature: 55),
      TemperaturePoint(title: "ENGINE COOLENT", temperature: 113),
      TemperaturePoint(title: "ENGINE COOLENT", temperature: 113)
    ]
    
    //FIXME: mock
    let vehicle = Vehicle(image: #imageLiteral(resourceName: "Photo_Car_Big"),
                          logo: #imageLiteral(resourceName: "Car logo"),
                          vehicleStats: vehicleStats,
                          problems: problems,
                          history: history,
                          profile: profile,
                          temperatures: temperatures)
    return vehicle
  }
}





