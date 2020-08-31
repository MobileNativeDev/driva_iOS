//
//  OnBoardingViewController.swift
//  Driva
//
//  Created by iDeveloper on 16.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class OnBoardingViewController: UIViewController {
  var presenter: OnBoardingPresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var pageControl: UIPageControl!
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    OnBoardingConfigurator.configure(self)
    pageControl.numberOfPages = presenter?.numberOfPages ?? 0
  }
  
}

//MARK: - OnBoardingView
extension OnBoardingViewController: OnBoardingView {
  static func instantiate() -> OnBoardingViewController? {
    return UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "OnBoardingViewController") as? OnBoardingViewController
  }
}

//MARK: - UICollectionViewDataSource
extension OnBoardingViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter?.numberOfPages ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.identifier, for: indexPath) as! OnBoardingCell
    presenter?.configure(cell, for: indexPath.row)
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension OnBoardingViewController: UICollectionViewDelegate {
  
}

//MARK: - UICollectionViewDelegateFlowLayout
extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    let width = collectionView.bounds.width -
      collectionView.contentInset.left - collectionView.contentInset.right -
      layout.sectionInset.left - layout.sectionInset.right
    
    let height = collectionView.bounds.height -
      collectionView.contentInset.top - collectionView.contentInset.bottom -
      layout.sectionInset.top - layout.sectionInset.bottom
    
    return CGSize(width: width, height: height)
  }
}

//MARK: - UIScrollViewDelegate
extension OnBoardingViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    let scrollOffset = scrollView.contentOffset.x
    let scrollWidth = scrollView.bounds.width
    
    pageControl.isHidden = scrollOffset > scrollWidth * 1.5
    pageControl.alpha = 1 - ((scrollOffset > scrollWidth) ? ((scrollOffset - scrollWidth) / (scrollWidth * 0.5)) : 0)
    
    let page = Int((scrollView.contentOffset.x + scrollView.bounds.width * 0.5) / scrollView.bounds.width)
    pageControl.currentPage = page
  }
}













