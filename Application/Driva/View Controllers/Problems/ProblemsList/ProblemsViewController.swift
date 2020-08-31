//
//  ProblemsViewController.swift
//  Driva
//
//  Created by iDeveloper on 23.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class ProblemsViewController: UIViewController {
  var presenter: ProblemsPresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var tblProblems: UITableView! {
    didSet {
      tblProblems.register(UINib(nibName: "ProblemCell", bundle: nil), forCellReuseIdentifier: ProblemCell.identifier)
    }
  }
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
  }
  
  //MARK: - Actions
  
  @IBAction private func btnBackPressed(_ sender: UIBarButtonItem) {
    presenter?.backAction()
  }
  
  @IBAction private func btnResetPressed(_ sender: UIButton) {
    presenter?.resetAction()
  }
  
}

//MARK: - ProblemsView
extension ProblemsViewController: ProblemsView {
  static func instantiate() -> ProblemsViewController? {
    return UIStoryboard(name: "Problems", bundle: nil).instantiateViewController(withIdentifier: "ProblemsViewController") as? ProblemsViewController
  }
  
  func showNumberOfProblems(_ numberOfProblems: Int) {
    lblTitle.text = "\(numberOfProblems) Problems Found"
  }
}

//MARK: - UITableViewDataSource
extension ProblemsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.numberOfProblems ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ProblemCell.identifier, for: indexPath) as! ProblemCell
    presenter?.configure(cell, for: indexPath.row)
    return cell
  }
}

//MARK: - UITableViewDelegate
extension ProblemsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter?.problemSelected(with: indexPath.row)
  }
}






