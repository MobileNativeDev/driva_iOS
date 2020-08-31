//
//  TabsCollectionBar.swift
//  Driva
//
//  Created by iDeveloper on 10.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class TabsCollectionBar: UIView {
  
  //FIXME: mock tabs
  var tabs = [DiagnosticTab]()
  
  var selectTabAction: ((_ tab: DiagnosticTab) -> ())?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var clvTabs: UICollectionView!
  
  //MARK: -
  
  private func configure(_ cell: DiagnosticTabCell, for index: Int) {
    guard tabs.count > index else { return }
    let tab = tabs[index]
    
    
    cell.icon = tab.icon
    cell.title = tab.name
    
    //FIXME: change this
    cell.badgeNeeded = (index == 0 || index == 1)
  }
  
  //MARK: - Public
  
  func selectTab(_ tab: DiagnosticTab) {
    clvTabs.selectItem(at: IndexPath(item: tab.rawValue, section: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.left)
  }
  
}

//MARK: - UICollectionViewDataSource
extension TabsCollectionBar: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tabs.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiagnosticTabCell.identifier, for: indexPath) as! DiagnosticTabCell
    configure(cell, for: indexPath.item)
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension TabsCollectionBar: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard tabs.count > indexPath.item else { return }
    let tab = tabs[indexPath.item]
    selectTabAction?(tab)
  }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension TabsCollectionBar: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    let contentInsets = collectionView.contentInset
    let sectionInsets = layout.sectionInset
    
    let ratio: CGFloat = 1.2
    let height = (collectionView.bounds.height -
      contentInsets.top - contentInsets.bottom -
      sectionInsets.top - sectionInsets.bottom) * 0.95
    
    let width = height * ratio
    return CGSize(width: width, height: height)
  }
}







