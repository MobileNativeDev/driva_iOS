//
//  StatisticTab.swift
//  Driva
//
//  Created by iDeveloper on 07.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class StatisticTab: UIView {
  
  private var mileage: String? {
    get { return lblMileage.text }
    set { lblMileage.text = newValue }
  }
  
  private var periodName: String? {
    get { return lblPeriodName.text }
    set { lblPeriodName.text = newValue }
  }
  
  private var periodValue: String? {
    get { return lblPeriodValue.text }
    set { lblPeriodValue.text = newValue }
  }
  
  private var nextService: String? {
    get { return lblNextService.text }
    set { lblNextService.text = newValue }
  }
  
  var stats: VehicleStats? {
    didSet {
      mileage = "\(stats?.mileage ?? 0) M"
      periodValue = "\(stats?.allWeek ?? 0) M"
      nextService = "\(stats?.nextService ?? 0) M"
    }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var lblMileage: UILabel!
  @IBOutlet private weak var lblPeriodValue: UILabel!
  @IBOutlet private weak var lblPeriodName: UILabel!
  @IBOutlet private weak var lblNextService: UILabel!
  
  //MARK: -
  
  static func instantiate() -> StatisticTab? {
    return UINib(nibName: "StatisticTab", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StatisticTab
  }
  
}
