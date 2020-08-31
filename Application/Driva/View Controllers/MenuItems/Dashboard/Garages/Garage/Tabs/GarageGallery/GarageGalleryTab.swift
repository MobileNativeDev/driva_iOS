//
//  GarageGalleryTab.swift
//  Driva
//
//  Created by iDeveloper on 14.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class GarageGalleryTab: UIView {
  
  var images = [UIImage]() {
    didSet { clvPhotos?.reloadData() }
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var clvPhotos: UICollectionView? {
    didSet {
      clvPhotos?.register(UINib(nibName: GarageGalleryCell.identifier, bundle: nil), forCellWithReuseIdentifier: GarageGalleryCell.identifier)
    }
  }
  
  //MARK: -
  
  static func instantiate() -> GarageGalleryTab? {
    return UINib(nibName: "GarageGalleryTab", bundle: nil).instantiate(withOwner: nil, options: nil).first as? GarageGalleryTab
  }
  
  //MARK: -
  
  private func configure(_ cell: GarageGalleryCell, for index: Int) {
    guard images.count > index else { return }
    cell.photo = images[index]
  }
}

//MARK: - UICollectionViewDataSource
extension GarageGalleryTab: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GarageGalleryCell.identifier, for: indexPath) as! GarageGalleryCell
    configure(cell, for: indexPath.item)
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension GarageGalleryTab: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard images.count > indexPath.item else { return }
    let image = images[indexPath.item]
    
    if let pictureController = PictureViewController.instantiate() {
      pictureController.image = image
      UIApplication.shared.keyWindow?.rootViewController?.present(pictureController, animated: true, completion: nil)
    }
  }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension GarageGalleryTab: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    
    let numberOfCellsInColumn: CGFloat = 3.0
    let space = collectionView.bounds.width -
      collectionView.contentInset.left - collectionView.contentInset.right -
      layout.sectionInset.left - layout.sectionInset.right - (layout.minimumLineSpacing * (numberOfCellsInColumn - 1))
    
    let width = space / numberOfCellsInColumn
    
    return CGSize(width: width, height: width)
  }
}














