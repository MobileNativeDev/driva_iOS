//
//  SecondViewController.swift
//  Driva
//
//  Created by Charlyn Keating on 8/6/18.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class GaragesViewController: UIViewController, SideMenuItemContent {
  var presenter: GaragesPresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var clvGarages: UICollectionView! {
    didSet {
      clvGarages.register(UINib(nibName: GarageCell.identifier, bundle: nil), forCellWithReuseIdentifier: GarageCell.identifier)
    }
  }
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    GaragesConfigurator.configure(self)
    presenter?.viewDidLoad()
  }
  
  //MARK: - Actions
  
  @IBAction private func btnMenuPressed(_ sender: UIBarButtonItem) {
    presenter?.menuAction()
  }
  
  @IBAction private func btnFilterPressed(_ sender: UIBarButtonItem) {
    presenter?.filterAction()
  }
  
  @IBAction private func btnSortPressed(_ sender: UIButton) {
    presenter?.sortAction()
  }
  
}

//MARK: - GaragesView
extension GaragesViewController: GaragesView {
  static func instantiate() -> GaragesViewController? {
    let storyboard = UIStoryboard(name: "Garages", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "GaragesViewController") as? GaragesViewController
  }
}

//MARK: - UICollectionViewDataSource
extension GaragesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter?.numberOfGarages ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GarageCell.identifier, for: indexPath) as! GarageCell
    presenter?.configure(cell, for: indexPath.item)
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension GaragesViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    presenter?.garageSelected(with: indexPath.item)
  }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension GaragesViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    
    let numberOFCellInColumn: CGFloat = 2.0
    let spaceForCells = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right -
      layout.sectionInset.left - layout.sectionInset.right - layout.minimumLineSpacing
    
    let width = spaceForCells / numberOFCellInColumn
    
    return CGSize(width: width, height: width * 1.25)
    
  }
}








