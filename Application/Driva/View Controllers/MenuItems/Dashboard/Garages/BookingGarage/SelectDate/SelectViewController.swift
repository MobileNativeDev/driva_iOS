//
//  SelectDateViewController.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class SelectDateViewController: UIViewController {
  var presenter: SelectDatePresenter?
  
  let headerHeight: CGFloat = 50
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var lblMonth: UILabel!
  @IBOutlet private weak var clvDates: UICollectionView!
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presenter?.viewDidAppear()
  }
  
  //MARK: - Actions
  
  @IBAction private func btnBackPressed(_ sender: UIBarButtonItem) {
    presenter?.backAction()
  }
  
  @IBAction private func btnPreviousMonth(_ sender: UIButton) {
    presenter?.previousAction()
  }
  
  @IBAction private func btnNextMonth(_ sender: UIButton) {
    presenter?.nextAction()
  }
}

//MARK: - SelectDateView
extension SelectDateViewController: SelectDateView {
  static func instantiate() -> SelectDateViewController? {
    return UIStoryboard(name: "SelectDate", bundle: nil).instantiateViewController(withIdentifier: "SelectDateViewController") as? SelectDateViewController
  }
  
  func showMonth(_ month: String) {
    lblMonth.text = month
  }
  
  func reloadDays() {
    clvDates.reloadData()
  }
  
  func selectDate(with index: Int) {
    clvDates.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredVertically)
  }
}

//MARK: - UICollectionViewDataSource
extension SelectDateViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter?.numberOfDates ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.identifier, for: indexPath) as! DateCell
    presenter?.configure(cell, for: indexPath.item)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WeekdaysView", for: indexPath)
    
    return view
  }
}

//MARK: - UICollectionViewDelegate
extension SelectDateViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    presenter?.dateSelected(with: indexPath.item)
  }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SelectDateViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    
    let daysInWeek: CGFloat = 7
    let weeksInMonth: CGFloat = 5
    
    let width = (collectionView.bounds.width -
      collectionView.contentInset.left - collectionView.contentInset.right -
      layout.sectionInset.left - layout.sectionInset.right -
      layout.minimumInteritemSpacing * (daysInWeek - 1)) / daysInWeek
    
    let height = (collectionView.bounds.height -
      collectionView.contentInset.top - collectionView.contentInset.bottom -
      layout.sectionInset.top - layout.sectionInset.bottom -
      layout.minimumLineSpacing * (weeksInMonth - 1) -
      headerHeight) / weeksInMonth
    
    return CGSize(width: width, height: height)
  }
}











