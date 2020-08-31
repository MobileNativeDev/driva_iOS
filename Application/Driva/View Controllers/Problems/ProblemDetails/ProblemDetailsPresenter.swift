//
//  ProblemDetailsPresenter.swift
//  Driva
//
//  Created by iDeveloper on 23.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol ProblemDetailsView: BaseViewController {
  func showTitle(_ title: String)
  func showCode(_ code: String)
  func showProblemName(_ name: String)
  func showProblemValue(_ value: String)
  func showNormalValue(_ value: String)
  func showInfo(_ info: String)
}

protocol ProblemDetailsPresenter {
  func viewDidLoad()
  
  func backAction()
  func callAction()
}

protocol ProblemDetailsRouter {
  func back()
}

class ProblemDetailsPresenterImplementation {
  private weak var view: ProblemDetailsView?
  private let router: ProblemDetailsRouter
  
  let problem: VehicleProblem
  
  //MARK: -
  
  init(view: ProblemDetailsView, router: ProblemDetailsRouter, with problem: VehicleProblem) {
    self.view = view
    self.router = router
    self.problem = problem
  }
  
  //MARK: -
  
  
}

//MARK: - ProblemDetailsPresenter
extension ProblemDetailsPresenterImplementation: ProblemDetailsPresenter {
  func viewDidLoad() {
    view?.showTitle(problem.title)
    view?.showCode("Trouble code: \(problem.code)")
    view?.showProblemName(problem.problemName)
    view?.showProblemValue("\(problem.problemValue)")
    view?.showNormalValue("\(problem.normalValue)")
    view?.showInfo(problem.fullInfo)
  }
  
  func backAction() {
    router.back()
  }
  
  func callAction() {
    //TODO: call to garage
  }
}





