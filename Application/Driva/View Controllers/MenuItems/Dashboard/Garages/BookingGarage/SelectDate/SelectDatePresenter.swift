//
//  SelectDatePresenter.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

protocol SelectDateView: BaseViewController {
  func showMonth(_ month: String)
  func reloadDays()
  func selectDate(with index: Int)
}

protocol SelectDatePresenter {
  var numberOfDates: Int { get }
  
  func viewDidLoad()
  func viewDidAppear()
  
  func configure(_ cell: DateCell, for index: Int)
  func dateSelected(with index: Int)
  
  func backAction()
  func previousAction()
  func nextAction()
}

protocol SelectDateRouter {
  func backAction()
}

class SelectDatePresenterImplementation {
  private weak var view: SelectDateView?
  private let router: SelectDateRouter
  
  var dates: [Int] = Array(1...31)
  var selectedDate: Date
  var showingDate: Date
  
  var selectedDateAction: ( (Date) -> () )?
  
  //MARK: -
  
  init(view: SelectDateView, router: SelectDateRouter, with selectedDate: Date, completion: @escaping ( (Date) -> () )) {
    self.view = view
    self.router = router
    self.selectedDate = selectedDate
    self.showingDate = selectedDate
    self.selectedDateAction = completion
    
    //    let calendar = Calendar.current
    //    let components = calendar.dateComponents([.year, .month, .day], from: selectedDate)
    //
    //    let year = components.year
    //    let month = components.month
    //    let day = components.day
  }
  
  //MARK: -
  
  private func showMonth() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM yyyy"
    
    let month = dateFormatter.string(from: showingDate)
    view?.showMonth(month)
  }
  
  private func prepareDaysForMonth() {
    
    let range = Calendar.current.range(of: .day, in: .month, for: showingDate)
    var dates: [Int] = Array(1...(range?.count ?? 28))
    
    let weekday = showingDate.firstDayOfTheMonth.weekday
    var numberOfEmptyDays = 0
    if weekday == 1 {
      numberOfEmptyDays = 6
    } else {
      numberOfEmptyDays = weekday - 2
    }
//    let numberOfEmptyDays = weekday - 2
    for _ in 0..<numberOfEmptyDays {
      dates.insert(0, at: 0)
    }
    self.dates = dates
  }
  
  private func changeMonth() {
    showMonth()
    prepareDaysForMonth()
    view?.reloadDays()
  }
  
  private func showSelectedDate() {
    let selectedComponents = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
    let index = dates.index(where: { $0 == selectedComponents.day })
    view?.selectDate(with: index ?? 0)
  }
}

//MARK: - SelectDatePresenter
extension SelectDatePresenterImplementation: SelectDatePresenter {
  
  var numberOfDates: Int {
    return dates.count
  }
  
  func viewDidLoad() {
    showMonth()
    prepareDaysForMonth()
  }
  
  func viewDidAppear() {
    showSelectedDate()
  }
  
  func configure(_ cell: DateCell, for index: Int) {
    guard dates.count > index else { return }
    let date = dates[index]
    cell.date = date > 0 ? "\(date)" : ""
  
    var isToday = false
    var isSelected = false
    
    let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    let showingComponents = Calendar.current.dateComponents([.year, .month, .day], from: showingDate)
    let selectedComponents = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
    
    if (todayComponents.year ?? 0) == (showingComponents.year ?? 0),
      (todayComponents.month ?? 0) == (showingComponents.month ?? 0) {
      isToday = (todayComponents.day ?? 0) == date
    }
    
    if (showingComponents.year ?? 0) == (selectedComponents.year ?? 0),
      (showingComponents.month ?? 0) == (selectedComponents.month ?? 0) {
      isSelected = selectedComponents.day == date
    }
    
    cell.selection = isSelected
    cell.today = isToday
  }
  
  func dateSelected(with index: Int) {
    guard dates.count > index else { return }
    let date = dates[index]
    
    var components = Calendar.current.dateComponents([.year, .month, .day], from: showingDate)
    components.day = date
    
    if let selectedDate = Calendar.current.date(from: components) {
      self.selectedDate = selectedDate
    }
  }
  
  func backAction() {
    selectedDateAction?(selectedDate)
    router.backAction()
  }
  
  func previousAction() {
    if let date = Calendar.current.date(byAdding: .month, value: -1, to: showingDate) {
      showingDate = date
      changeMonth()
    }
  }
  
  func nextAction() {
    if let date = Calendar.current.date(byAdding: .month, value: 1, to: showingDate) {
      showingDate = date
      changeMonth()
    }
  }
}







