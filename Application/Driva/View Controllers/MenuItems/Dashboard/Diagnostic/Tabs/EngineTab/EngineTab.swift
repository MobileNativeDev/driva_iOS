//
//  EngineTab.swift
//  Driva
//
//  Created by iDeveloper on 10.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

struct TemperaturePoint {
  let title: String
  let temperature: Int
}

class EngineTab: UIView {
  
  var numberOfProblems: Int = 0 {
    didSet {
      lblProblems?.text = "\(numberOfProblems)"
    }
  }
  var data = [TemperaturePoint]()
  
  var detailsAction: (() -> ())?
  
  //MARK: - IBOutlets
  
  @IBOutlet weak var lblProblems: UILabel? {
    didSet {
      lblProblems?.text = "\(numberOfProblems)"
    }
  }
  @IBOutlet weak var clvTemperatures: UICollectionView! {
    didSet {
      clvTemperatures.register(UINib(nibName: VehicleTemperatureCell.identifier, bundle: nil), forCellWithReuseIdentifier: VehicleTemperatureCell.identifier)
    }
  }
  
  //MARK: -
  
  static func instantiate() -> EngineTab? {
    return UINib(nibName: "EngineTab", bundle: nil).instantiate(withOwner: nil, options: nil).first as? EngineTab
  }
  
  //MARK: -
  
  private func configure(_ cell: VehicleTemperatureCell, for index: Int) {
    guard data.count > index else { return }
    let cellData = data[index]
    
    cell.title = cellData.title
    cell.temperature = "\(cellData.temperature)"
  }
  
  //MARK: - Actions
  
  @IBAction private func btnDetailsPressed(_ sender: UIButton) {
    detailsAction?()
  }
}

//MARK: - UICollectionViewDataSource
extension EngineTab: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VehicleTemperatureCell.identifier, for: indexPath) as! VehicleTemperatureCell
    configure(cell, for: indexPath.item)
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension EngineTab: UICollectionViewDelegate {
  
}

//MARK: - UICollectionViewDelegateFlowLayout
extension EngineTab: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    
    let height = collectionView.bounds.height -
      collectionView.contentInset.top - collectionView.contentInset.bottom -
      layout.sectionInset.top - layout.sectionInset.bottom
    
    return CGSize(width: height * 2, height: height)
  }
}










