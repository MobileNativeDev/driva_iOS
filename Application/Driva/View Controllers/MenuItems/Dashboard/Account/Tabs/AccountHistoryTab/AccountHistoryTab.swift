//
//  AccountHistoryTab.swift
//  Driva
//
//  Created by iDeveloper on 14.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

struct GarageHistoryInfo {
  let garage: Garage
  let finishedOn: String
}

class AccountHistoryTab: UIView {

  var history = [GarageHistoryInfo]()
  var leaveReviewAction: ( (Int) -> () )?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var tblHistory: UITableView! {
    didSet {
      tblHistory.register(UINib(nibName: GarageHistoryCell.identifier, bundle: nil), forCellReuseIdentifier: GarageHistoryCell.identifier)
    }
  }
  
  //MARK: -
  
  static func instantiate() -> AccountHistoryTab? {
    return UINib(nibName: "AccountHistoryTab", bundle: nil).instantiate(withOwner: nil, options: nil).first as? AccountHistoryTab
  }
  
  //MARK: -
  
  private func configure(_ cell: GarageHistoryCell, for index: Int) {
    guard history.count > index else { return }
    let garage = history[index]
    
    cell.logo = garage.garage.imageContent
    cell.title = garage.garage.title
    cell.address = garage.garage.fullAddress
    cell.finishedDate = garage.finishedOn
    
    cell.leaveReviewAction = { [weak self] in
      self?.leaveReviewAction?(index)
    }
  }
}

//MARK: - UITableViewDataSource
extension AccountHistoryTab: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return history.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GarageHistoryCell.identifier, for: indexPath) as! GarageHistoryCell
    configure(cell, for: indexPath.row)
    return cell
  }
}

//MARK: - UITableViewDelegate
extension AccountHistoryTab: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer { tableView.deselectRow(at: indexPath, animated: true) }
  }
}







