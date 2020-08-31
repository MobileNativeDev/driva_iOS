//
//  SelectProblemPresenter.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct ProblemIndex: Hashable {
  let category: Int
  let problem: Int
}

struct ProblemCategory {
  let name: String
  let icon: UIImage
  
  let problems: [VehicleProblem]
}

protocol SelectProblemView: BaseViewController {
  func showCategoryTitle(_ title: String)
  func showSelection(with index: Int)
  func reloadProblems()
}

protocol SelectProblemPresenter {
  var numberOfCategories: Int { get }
  var numberOfProblems:Int { get }
  
  func viewWillAppear()
  
  func backAction()
  func selectAllAction()
  
  func configure(_ cell: ProblemCategoryCell, for index: Int)
  func configure(_ cell: ProblemCell, for index: Int)
  func categorySelected(with index: Int)
}

protocol SelectProblemRouter {
  func back()
}

class SelectProblemPresenterImplementation {
  private weak var view: SelectProblemView?
  private let router: SelectProblemRouter
  
  var categories = [
    ProblemCategory(name: "Electrical Fault", icon: #imageLiteral(resourceName: "problem_icon_battery"), problems: VehicleProblem.fakeProblems(index: 0)),
    ProblemCategory(name: "Door Fault", icon: #imageLiteral(resourceName: "problem_icon_door"), problems: VehicleProblem.fakeProblems(index: 1)),
    ProblemCategory(name: "Engine Fault", icon: #imageLiteral(resourceName: "problem_icon_repair"), problems: VehicleProblem.fakeProblems(index: 2)),
    ProblemCategory(name: "Toolbox Fault", icon: #imageLiteral(resourceName: "problem_icon_toolbox"), problems: VehicleProblem.fakeProblems(index: 3)),
    ProblemCategory(name: "Wheel Fault", icon: #imageLiteral(resourceName: "problem_icon_wheel"), problems: VehicleProblem.fakeProblems(index: 4))
  ]
  var selectedCategoryIndex: Int = 0
  var selectedProblemsIndexes = Set<ProblemIndex>()
  
  //MARK: -
  
  init(view: SelectProblemView, router: SelectProblemRouter) {
    self.view = view
    self.router = router
  }
  
  //MARK: -
  
  
}

//MARK: - SelectProblemPresenter
extension SelectProblemPresenterImplementation: SelectProblemPresenter {
  var numberOfCategories: Int {
    return categories.count
  }
  
  var numberOfProblems: Int {
    guard categories.count > selectedCategoryIndex else { return 0 }
    let category = categories[selectedCategoryIndex]
    return category.problems.count
  }
  
  func viewWillAppear() {
    view?.showSelection(with: selectedCategoryIndex)
  }
  
  func backAction() {
    router.back()
  }
  
  func selectAllAction() {
    guard categories.count > selectedCategoryIndex else { return }
    let category = categories[selectedCategoryIndex]
    
    category.problems.enumerated().forEach({  [weak self] in
      self?.selectedProblemsIndexes.insert(ProblemIndex(category: self?.selectedCategoryIndex ?? 0, problem: $0.offset))
    })
    view?.reloadProblems()
  }
  
  func configure(_ cell: ProblemCategoryCell, for index: Int) {
    guard categories.count > index else { return }
    let category = categories[index]
    cell.categoryImage = category.icon
  }
  
  func configure(_ cell: ProblemCell, for index: Int) {
    guard categories.count > selectedCategoryIndex else { return }
    let category = categories[selectedCategoryIndex]
    
    guard category.problems.count > index else { return }
    let problem = category.problems[index]
    
    cell.isSelectionAvailable = true
    cell.icon = problem.icon
    cell.category = problem.title
    cell.info = problem.description
    
    let problemIndex = ProblemIndex(category: selectedCategoryIndex, problem: index)
    cell.selectionStatus = selectedProblemsIndexes.contains(problemIndex)
    cell.selectProblemAction = { [weak self] resultSelectionStatus in
      if resultSelectionStatus {
        self?.selectedProblemsIndexes.insert(problemIndex)
      } else {
        self?.selectedProblemsIndexes.remove(problemIndex)
      }
    }
  }
  
  func categorySelected(with index: Int) {
    guard categories.count > index else { return }
    let category = categories[index]
    
    selectedCategoryIndex = index
    view?.showCategoryTitle(category.name)
    view?.reloadProblems()
  }
}







