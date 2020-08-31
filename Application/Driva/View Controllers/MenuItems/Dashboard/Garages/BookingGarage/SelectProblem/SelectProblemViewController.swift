//
//  SelectProblemViewController.swift
//  Driva
//
//  Created by iDeveloper on 28.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class SelectProblemViewController: UIViewController {
  var presenter: SelectProblemPresenter?
  
  //MARK: - IBOutlets

  @IBOutlet private weak var clvCategories: UICollectionView!
  @IBOutlet private weak var tblProblems: UITableView! {
    didSet { tblProblems.register(UINib(nibName: ProblemCell.identifier, bundle: nil), forCellReuseIdentifier: ProblemCell.identifier) }
  }
  @IBOutlet private weak var txtMessage: UITextView!
  
  //MARK: -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    SelectProblemConfigurator.configure(self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter?.viewWillAppear()
  }
  
  //MARK: - Actions

  @IBAction private func btnBackPressed(_ sender: UIBarButtonItem) {
    presenter?.backAction()
  }
  
  @IBAction private func btnSelectAll(_ sender: UIButton) {
    presenter?.selectAllAction()
  }
}

//MARK: - SelectProblemView
extension SelectProblemViewController: SelectProblemView {
  static func instantiate() -> SelectProblemViewController? {
    let storyboard = UIStoryboard(name: "BookingGarage", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "SelectProblemViewController") as? SelectProblemViewController
  }
  
  func showCategoryTitle(_ title: String) {
    self.title = title
  }
  
  func showSelection(with index: Int) {
    clvCategories.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: .left)
  }
  
  func reloadProblems() {
    tblProblems.reloadData()
  }
}

//MARK: - UICollectionViewDataSource
extension SelectProblemViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter?.numberOfCategories ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProblemCategoryCell.identifier, for: indexPath) as! ProblemCategoryCell
    presenter?.configure(cell, for: indexPath.item)
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension SelectProblemViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    presenter?.categorySelected(with: indexPath.item)
  }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SelectProblemViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    let cellSize = collectionView.bounds.height  -
      collectionView.contentInset.top - collectionView.contentInset.bottom -
      layout.sectionInset.top - layout.sectionInset.bottom
    
    return CGSize(width: cellSize, height: cellSize)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    let numberOfCategories: CGFloat = 5
    
    let cellWidth = collectionView.bounds.height  -
      collectionView.contentInset.top - collectionView.contentInset.bottom -
      layout.sectionInset.top - layout.sectionInset.bottom
    
    let freeSpace = collectionView.bounds.width -
      collectionView.contentInset.left - collectionView.contentInset.right -
      layout.sectionInset.left - layout.sectionInset.right -
      cellWidth * numberOfCategories
    
    let interitemSpace = freeSpace / (numberOfCategories - 1)
    
    return interitemSpace
  }
}

//MARK: - UITableViewDataSource
extension SelectProblemViewController: UITableViewDataSource {
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
extension SelectProblemViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer { tableView.deselectRow(at: indexPath, animated: true) }
  }
}





