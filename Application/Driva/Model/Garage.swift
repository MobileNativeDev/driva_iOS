//
//  Garage.swift
//  Driva
//
//  Created by iDeveloper on 14.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct GarageShortInfo {
  let imageContent: UIImage
  let title: String
  let fullAddress: String
  let address: String
  let link: String
}

struct Garage {
  let imageContent: UIImage
  let title: String
  let fullAddress: String
  let link: String
  
  let totalBooked: Int
  let starRating: Double
  let yearsMember: Int
  
  //TODO: open hours?
  
  let profile: String
  
  let images = [#imageLiteral(resourceName: "mech1"), #imageLiteral(resourceName: "mech2"), #imageLiteral(resourceName: "mech3"), #imageLiteral(resourceName: "mech1"), #imageLiteral(resourceName: "mech3"), #imageLiteral(resourceName: "mech2"), #imageLiteral(resourceName: "mech3"), #imageLiteral(resourceName: "mech1")]
  
  static func fake(_ index: Int) -> Garage {
    let mocks = [
      Garage(imageContent: #imageLiteral(resourceName: "garage1"), title: "Hayes Engineer",
             fullAddress: "231 - 235 Empress St, Bromley, BR8 2XS",
             link: "wwww.hayesengineer", totalBooked: 13, starRating: 3.80, yearsMember: 4,
             profile: "Service technicians work on traditional mechanical components, such as engines, transmissions, and drive belts.\nHowever, I am also familiar with a growing number of electronics systems. Braking, transmission, and lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor "),
      Garage(imageContent: #imageLiteral(resourceName: "garage0"), title: "Maypole Motors",
             fullAddress: "211 - 213 Empress St, Bromley, BR8 2XS",
             link: "www.maypolemotors.co.uk", totalBooked: 9, starRating: 4.20, yearsMember: 3,
             profile: "Service technicians work on traditional mechanical components, such as engines, transmissions, and drive belts.\nHowever, I am also familiar with a growing number of electronics systems. Braking, transmission, and lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor "),
      Garage(imageContent: #imageLiteral(resourceName: "garage3"), title: "Renno Services",
             fullAddress: "198 - 200 Empress St, Bromley, BR8 2XS",
             link: "www.rennoservices.co.uk", totalBooked: 11, starRating: 2.40, yearsMember: 5,
             profile: "Service technicians work on traditional mechanical components, such as engines, transmissions, and drive belts.\nHowever, I am also familiar with a growing number of electronics systems. Braking, transmission, and lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor "),
      Garage(imageContent: #imageLiteral(resourceName: "garage3"), title: "Garage Express",
             fullAddress: "111 - 112 Empress St, Bromley, BR8 2XS",
             link: "www.garageexpress.co.uk", totalBooked: 10, starRating: 4.90, yearsMember: 1,
             profile: "Service technicians work on traditional mechanical components, such as engines, transmissions, and drive belts.\nHowever, I am also familiar with a growing number of electronics systems. Braking, transmission, and lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor "),
    ]
    
    return mocks[(mocks.count - 1) % (index <= 0 ? 1 : index)]
  }
}
