//
//  VehicleHistoryTab.swift
//  Driva
//
//  Created by iDeveloper on 07.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class VehicleHistoryTab: UIView {
  
  var history = [HistoryService]() {
    didSet {
      lblTitle?.text = "SERVICE HISTORY (\(history.count))"
    }
  }
  
  var serviceSelection: ((HistoryService) -> ())?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var lblTitle: UILabel?
  
  @IBOutlet private weak var tblHistory: UITableView! {
    didSet {
      tblHistory.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: HistoryCell.identifier)
    }
  }
  
  //MARK: -
  
  static func instantiate() -> VehicleHistoryTab? {
    return UINib(nibName: "VehicleHistoryTab", bundle: nil).instantiate(withOwner: nil, options: nil).first as? VehicleHistoryTab
  }
  
  private func configure(_ cell: HistoryCell, for index: Int) {
    guard history.count > index else { return }
    let service = history[index]

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM dd, yyyy"
    
    cell.date = dateFormatter.string(from: service.date)
    cell.title = service.garage.title
    cell.fixes = service.fixes.map({ return $0.icon })
  }
  
  //MARK: - Actions
  
  @IBAction private func btnTransferPressed(_ sender: UIButton) {
    //TODO: transfer action
  }
}

//MARK: - UITableViewDataSource
extension VehicleHistoryTab: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return history.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier, for: indexPath) as! HistoryCell
    configure(cell, for: indexPath.row)
    return cell
  }
}

//MARK: - UITableViewDelegate
extension VehicleHistoryTab: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer { tableView.deselectRow(at: indexPath, animated: true) }
    if history.count > indexPath.row {
      let service = history[indexPath.row]
      serviceSelection?(service)
    }
  }
}
