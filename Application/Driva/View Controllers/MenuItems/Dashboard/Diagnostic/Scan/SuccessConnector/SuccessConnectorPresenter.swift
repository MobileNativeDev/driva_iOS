//
//  SuccessConnectPresenter.swift
//  Driva
//
//  Created by iDeveloper on 21.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation

enum ScanMode {
  case successfull
  case scan
}

protocol SuccessConnectView: BaseViewController {
  func showMode(_ mode: ScanMode)
  func showTitle(_ title: String)
  func showProgress(_ progress: Float)
}

protocol SuccessConnectPresenter {
  func viewDidLoad()
  
  func backAction()
  func scanAction()
  func cancelAction()
}

protocol SuccessConnectRouter {
  func closeConnect(_ temperatures: [TemperaturePoint])
  func close()
}

class SuccessConnectPresenterImplementation {
  private weak var view: SuccessConnectView?
  private let router: SuccessConnectRouter
  
  let adapter: Adapter
  
  var progressTimer: Timer?
  var progress: Float = 0.0 {
    didSet {
      view?.showProgress(progress)
    }
  }
  
  var mode: ScanMode = .successfull {
    didSet {
      view?.showMode(mode)
    }
  }
  
  //MARK: -
  
  init(view: SuccessConnectView, router: SuccessConnectRouter, adapter: Adapter, mode: ScanMode) {
    self.view = view
    self.router = router
    self.adapter = adapter
    self.mode = mode
  }
  
  //MARK: -
  
  private func startScan() {
    progressTimer?.invalidate()
    progressTimer = nil
    
    progress = 0.0
    progressTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [weak self] timer in
      if let strongSelf = self {
        strongSelf.progress += 0.05
        
        if strongSelf.progress >= 1.0 {
          
          //FIXME: mock
          let temperatures =  [
            TemperaturePoint(title: "AIR TEMPERATURE", temperature: 55),
            TemperaturePoint(title: "ENGINE COOLENT", temperature: 113),
            TemperaturePoint(title: "ENGINE COOLENT", temperature: 113)
          ]
          
          strongSelf.router.closeConnect(temperatures)
          timer.invalidate()
          strongSelf.progressTimer = nil
        }
      }
    })
  }
  
}

//MARK: - SuccessConnectPresenter
extension SuccessConnectPresenterImplementation: SuccessConnectPresenter {
  func viewDidLoad() {
    view?.showTitle("\(adapter.title) Successfully Connected")
    
    view?.showMode(mode)
    switch mode {
    case .successfull: break
    case .scan: startScan()
    }
  }
  
  func backAction() {
    router.close()
  }
  
  func scanAction() {
    mode = .scan
    startScan()
  }
  
  func cancelAction() {
    progressTimer?.invalidate()
    progressTimer = nil
    
    mode = .successfull
  }
}










