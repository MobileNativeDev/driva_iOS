//
//  BookingGarageRouter.swift
//  Driva
//
//  Created by iDeveloper on 27.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

class BookingGarageRouterImplementation {
  private weak var view: BookingGarageViewController?
  
  //MARK: -
  
  init(view: BookingGarageViewController) {
    self.view = view
  }
}

//MARK: - BookingGarageRouter
extension BookingGarageRouterImplementation: BookingGarageRouter {
  func back() {
    view?.navigationController?.dismiss(animated: true, completion: nil)
  }
  
  func next() {
    guard let approvalController = BookingApprovalViewController.instantiate() else { return }
    view?.navigationController?.setViewControllers([approvalController], animated: true)
  }
  
  func toCalender(with date: Date, completion: @escaping ( (Date) -> () )) {
    guard let calenderController = SelectDateViewController.instantiate() else { return }
    SelectDateConfigurator.configure(calenderController, date: date, completion: completion)
    view?.navigationController?.show(calenderController, sender: self)
  }
  
  func toProblems() {
    guard let problemController = SelectProblemViewController.instantiate() else { return }
    
    view?.navigationController?.show(problemController, sender: self)
  }
}
