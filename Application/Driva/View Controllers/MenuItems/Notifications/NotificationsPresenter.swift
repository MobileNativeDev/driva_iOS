//
//  NotificationsPresenter.swift
//  Driva
//
//  Created by iDeveloper on 30.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct DrivaNotification {
  let icon: UIImage
  let title: String
  let description: String
}

protocol NotificationsView: BaseViewController {
  
}

protocol NotificationsPresenter {
  var numberOfNotifications: Int { get }
  
  func configure(_ cell: NotificationCell, for index: Int)
  func notificationSelected(with index: Int)
  func menuAction()
}

protocol NotificationsRouter {
  func showMenu()
  func toProblem(_ problem: VehicleProblem)
}

class NotificationsPresenterImplementation {
  private weak var view: NotificationsView?
  private let router: NotificationsRouter
  
  var notifications = [
    DrivaNotification(icon: #imageLiteral(resourceName: "problem_icon_freeze"), title: "Freeze Frame", description: "The front frame temperature is abnormal"),
    DrivaNotification(icon: #imageLiteral(resourceName: "problem_icon_engine"), title: "Live Sendor Data", description: "Live sensor data engine is off")
  ]
  
  //MARK: -
  
  init(view: NotificationsView, router: NotificationsRouter) {
    self.view = view
    self.router = router
  }
}

//MARK: - NotificationsPresenter
extension NotificationsPresenterImplementation: NotificationsPresenter {
  var numberOfNotifications: Int {
    return notifications.count
  }
  
  func configure(_ cell: NotificationCell, for index: Int) {
    guard notifications.count > index else { return }
    let notification = notifications[index]
    
    cell.icon = notification.icon
    cell.title = notification.title
    cell._description = notification.description
  }
  
  func notificationSelected(with index: Int) {
    //FIXME: mock
    let mockProblems = VehicleProblem.fakeProblems(index: 0)
    router.toProblem(mockProblems.first!)
  }
  
  func menuAction() {
    router.showMenu()
  }
}



