//
//  LeaveReviewViewController.swift
//  Driva
//
//  Created by iDeveloper on 27.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class LeaveReviewViewController: UIViewController {
  var presenter: LeaveReviewPresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgLogo: UIImageView!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblAddress: UILabel!
  @IBOutlet private weak var stckRating: UIStackView!
  @IBOutlet private weak var lblLevel: UILabel!
  @IBOutlet private weak var txtMessage: UITextView!
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
  }
  
  //MARK: - Actions
  
  @IBAction private func btnBackPressed(_ sender: UIBarButtonItem) {
    presenter?.backAction()
  }
  
  @IBAction private func btnSubmitPressed(_ sender: UIButton) {
    presenter?.submitAction()
  }
}

extension LeaveReviewViewController: LeaveReviewView {
  static func instantiate() -> LeaveReviewViewController? {
    return UIStoryboard(name: "Review", bundle: nil).instantiateViewController(withIdentifier: "LeaveReviewViewController") as? LeaveReviewViewController
  }
  
  func showLogo(_ logo: UIImage) {
    imgLogo.image = logo
  }
  
  func showTitle(_ title: String) {
    lblTitle.text = title
  }
  
  func showAddress(_ address: String) {
    lblAddress.text = address
  }
  
  func showRating(_ rating: Int) {
    stckRating.arrangedSubviews.enumerated().forEach({
      $0.element.tintColor = ($0.offset + 1) > rating ? UI.Color.lightGray : UI.Color.darkYellow
    })
  }
  
  func showLevel(_ level: String) {
    lblLevel.text = level
  }
}
