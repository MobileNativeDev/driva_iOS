//
//  ProblemTab.swift
//  Driva
//
//  Created by iDeveloper on 07.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class ProblemTab: UIView {
  
  var problems = [VehicleProblem]()
  
  var problemSelection: ((VehicleProblem) -> ())?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var tblProblems: UITableView! {
    didSet {
      tblProblems.register(UINib(nibName: "ProblemCell", bundle: nil), forCellReuseIdentifier: ProblemCell.identifier)
    }
  }
  
  //MARK: -
  
  static func instantiate() -> ProblemTab? {
    return UINib(nibName: "ProblemTab", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ProblemTab
  }

  private  func configure(_ cell: ProblemCell, for index: Int) {
    guard problems.count > index else { return }
    let problem = problems[index]
    
    cell.icon = problem.icon
    cell.category = problem.title
    cell.info = problem.description
  }
  
  //MARK: - Actions
  
  @IBAction private func btnResetPressed(_ sender: UIButton) {
    //TODO: reset action
  }
}

//MARK: - UITableViewDataSource
extension ProblemTab: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return problems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ProblemCell.identifier, for: indexPath) as! ProblemCell
    configure(cell, for: indexPath.row)
    return cell
  }
}

//MARK: - UITableViewDelegate
extension ProblemTab: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if problems.count > indexPath.row {
      let problem = problems[indexPath.row]
      problemSelection?(problem)
    }
  }
}







