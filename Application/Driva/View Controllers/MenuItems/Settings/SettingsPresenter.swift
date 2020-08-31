//
//  SettingsPresenter.swift
//  Driva
//
//  Created by iDeveloper on 16.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol SettingsView: BaseViewController {
  func showMenuButton()
}

protocol SettingsPresenter {
  func viewDidLoad()
  func leftNavigationAction()
  
  func upgradeAction()
}

protocol SettingsRouter {
  func showMenu()
  func back()
  func upgrade()
}

class SettingsPresenterImplementation {
  private weak var view: SettingsView?
  private let router: SettingsRouter
  
  private var navigationMode: NavigationMode = .menuItem
  
  //MARK: -
  
  init(view: SettingsView, router: SettingsRouter, navigationMode: NavigationMode = .menuItem) {
    self.view = view
    self.router = router
    self.navigationMode = navigationMode
  }
}

//MARK: - SettingsPresenter
extension SettingsPresenterImplementation: SettingsPresenter {
  
  func viewDidLoad() {
    if case .menuItem = navigationMode {
      view?.showMenuButton()
    }
  }
  
  func leftNavigationAction() {
    switch navigationMode {
    case .menuItem: router.showMenu()
    case .stackItem: router.back()
    }
  }
  
  func upgradeAction() {
    router.upgrade()
  }
}






