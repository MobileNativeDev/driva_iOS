//
//  ReviewsTab.swift
//  Driva
//
//  Created by iDeveloper on 15.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

struct Review {
  let logo: UIImage
  let title: String
  let address: String
  let rating: Int
  let review: String
}

class ReviewsTab: UIView {
  var reviews = [Review]()
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var tblReviews: UITableView! {
    didSet {
      tblReviews.register(UINib(nibName: ReviewCell.identifier, bundle: nil), forCellReuseIdentifier: ReviewCell.identifier)
      tblReviews.rowHeight = UITableViewAutomaticDimension
      tblReviews.estimatedRowHeight = 200
    }
  }
  
  //MARK: -
  
  static func instantiate() -> ReviewsTab? {
    return UINib(nibName: "ReviewsTab", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ReviewsTab
  }
  
  //MARK: -
  
  private func configure(_ cell: ReviewCell, for index: Int) {
    guard reviews.count > index else { return }
    let review = reviews[index]
    cell.logo = review.logo
    cell.title = review.title
    cell.address = review.address
    cell.rating = review.rating
    cell.review = review.review
  }
}

//MARK: - UITableViewDataSource
extension ReviewsTab: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reviews.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as! ReviewCell
    configure(cell, for: indexPath.row)
    return cell
  }
}

//MARK: - UITableViewDelegate
extension ReviewsTab: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer { tableView.deselectRow(at: indexPath, animated: true) }
  }
}

