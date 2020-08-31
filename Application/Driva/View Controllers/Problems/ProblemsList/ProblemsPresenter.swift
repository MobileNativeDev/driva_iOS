//
//  ProblemsPresenter.swift
//  Driva
//
//  Created by iDeveloper on 23.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol ProblemsView: BaseViewController {
  func showNumberOfProblems(_ numberOfProblems: Int)
}

protocol ProblemsPresenter {
  var numberOfProblems: Int { get }

  func viewDidLoad()
  func backAction()
  func resetAction()
  func configure(_ cell: ProblemCell, for index: Int)
  func problemSelected(with index: Int)
}

protocol ProblemsRouter {
  func toProblem(_ problem: VehicleProblem)
  func confirmReset()
  func close()
}

class ProblemsPresenterImplementation {
  private weak var view: ProblemsView?
  private let router: ProblemsRouter
  
  var problems = [VehicleProblem]()
  
  //MARK: -
  
  init(view: ProblemsView, router: ProblemsRouter, with problems: [VehicleProblem]) {
    self.view = view
    self.router = router
    self.problems = problems
  }
  
  //MARK: -
  
  
}

//MARK: - ProblemsPresenter
extension ProblemsPresenterImplementation: ProblemsPresenter {
  var numberOfProblems: Int {
    return problems.count
  }
  
  func viewDidLoad() {
    view?.showNumberOfProblems(problems.count)
  }
  
  func backAction() {
    router.close()
  }
  
  func resetAction() {
    router.confirmReset()
  }
  
  func configure(_ cell: ProblemCell, for index: Int) {
    guard problems.count > index else { return }
    let problem = problems[index]
    
    cell.icon = problem.icon
    cell.category = problem.title
    cell.info = problem.description
  }
  
  func problemSelected(with index: Int) {
    guard problems.count > index else { return }
    let problem = problems[index]
    
    router.toProblem(problem)
  }
}





