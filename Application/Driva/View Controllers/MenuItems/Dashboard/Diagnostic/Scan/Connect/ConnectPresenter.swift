//
//  ConnectPresenter.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct Adapter {
  let logo: UIImage
  let title: String
  let status: String
}

enum SearchMode {
  case progress
  case result
}

protocol ConnectView: BaseViewController {
  func showProgress(_ progress: Float)
  func showSearch(_ mode: SearchMode)
}

protocol ConnectPresenter {
  var numberOfAdapters: Int { get }
  
  func viewDidAppear()
  func configureAdapter(_ adapterView: AdapterView, for index: Int)
  
  func backAction()
  func cancelAction()
  func scanAgainAction()
}

protocol ConnectRouter {
  func toSuccess(with adapter: Adapter)
  func close()
}

class ConnectPresenterImplementation {
  private weak var view: ConnectView?
  private let router: ConnectRouter

  var progressTimer: Timer?
  var progress: Float = 0.0
  
  var mode: SearchMode = .progress {
    didSet {
      view?.showSearch(mode)
    }
  }
  var adapters = [Adapter]()
  
  //MARK: -
  
  init(view: ConnectView, router: ConnectRouter) {
    self.view = view
    self.router = router
  }
  
  deinit {
    progressTimer?.invalidate()
    progressTimer = nil
  }
  
  //MARK: -
  
  private func close() {
    progressTimer?.invalidate()
    progressTimer = nil
    router.close()
  }
  
  private func startSearch() {
    progressTimer?.invalidate()
    progressTimer = nil
    
    progress = 0.0
    view?.showProgress(progress)
    progressTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [weak self] timer in
      if let strongSelf = self {
        strongSelf.progress += 0.05
        strongSelf.view?.showProgress(strongSelf.progress)
        
        if strongSelf.progress >= 1.0 {
          //FIXME: mock
          self?.adapters.append(Adapter(logo: #imageLiteral(resourceName: "Car logo"), title: "BMW 8 Concept", status: "8 Concept"))
          
          strongSelf.mode = .result
          timer.invalidate()
          strongSelf.progressTimer = nil
        }
      }
    })
  }
  
  private func connect(with index: Int) {
    guard adapters.count > index else { return }
    let adapter = adapters[index]
    
    router.toSuccess(with: adapter)
  }
}

//MARK: - ConnectPresenter
extension ConnectPresenterImplementation: ConnectPresenter {
  
  var numberOfAdapters: Int {
    return adapters.count
  }
  
  func viewDidAppear() {
    if mode == .progress {
      startSearch()
    }
  }
  
  func configureAdapter(_ adapterView: AdapterView, for index: Int) {
    guard adapters.count > index else { return }
    let adapter = adapters[index]
    
    adapterView.tag = index
    adapterView.logo = adapter.logo
    adapterView.title = adapter.title
    adapterView.status = adapter.status
    adapterView.connectAction = { [weak self] in
      self?.connect(with: index)
    }
  }
  
  func backAction() {
    close()
  }
  
  func cancelAction() {
    close()
  }
  
  func scanAgainAction() {
    adapters.removeAll()
    mode = .progress
    startSearch()
  }
}





