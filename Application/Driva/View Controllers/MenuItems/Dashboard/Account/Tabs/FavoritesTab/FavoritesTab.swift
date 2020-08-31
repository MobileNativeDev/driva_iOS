//
//  FavoritesTab.swift
//  Driva
//
//  Created by iDeveloper on 13.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class FavoritesTab: UIView {
  
  var favGarages = [GarageShortInfo]()
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var clvFavorites: UICollectionView! {
    didSet {
      clvFavorites.register(UINib(nibName: GarageCell.identifier, bundle: nil), forCellWithReuseIdentifier: GarageCell.identifier)
    }
  }
  
  var garageSelectedAction: ((_ index: Int)->())?
  
  //MARK: -
  
  static func instantiate() -> FavoritesTab? {
    return UINib(nibName: "FavoritesTab", bundle: nil).instantiate(withOwner: nil, options: nil).first as? FavoritesTab
  }
  
  //MARK: - 

  private func configure(_ cell: GarageCell, for index: Int) {
    guard favGarages.count > index else { return }
    let garage = favGarages[index]
    
    cell.imageContent = garage.imageContent
    cell.title = garage.title
    cell.address = garage.address
    cell.state = .favorite
  }
}

//MARK: - UICollectionViewDataSource
extension FavoritesTab: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return favGarages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GarageCell.identifier, for: indexPath) as! GarageCell
    configure(cell, for: indexPath.item)
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension FavoritesTab: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    garageSelectedAction?(indexPath.item)
  }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesTab: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    
    let numberOFCellInColumn: CGFloat = 2.0
    let spaceForCells = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right -
      layout.sectionInset.left - layout.sectionInset.right - layout.minimumLineSpacing
    
    let width = spaceForCells / numberOFCellInColumn
    
    return CGSize(width: width, height: width * 1.25)
  }
}
