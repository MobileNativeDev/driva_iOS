//
//  ProblemDetailsViewController.swift
//  Driva
//
//  Created by iDeveloper on 23.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class ProblemDetailsViewController: UIViewController {
  var presenter: ProblemDetailsPresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblCode: UILabel!
  
  @IBOutlet private weak var lblProblemName: UILabel!
  @IBOutlet private weak var lblProblemValue: UILabel!
  @IBOutlet private weak var lblNormalValue: UILabel!
  
  @IBOutlet private weak var txtInfo: UITextView!
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
  }
  
  //MARK: - Actions
  
  @IBAction private func btnBackPressed(_ sender: UIBarButtonItem) {
    presenter?.backAction()
  }
  
  @IBAction private func btnCallPressed(_ sender: UIButton) {
    presenter?.callAction()
  }
}

//MARK: - ProblemDetailsView
extension ProblemDetailsViewController: ProblemDetailsView {
  static func instantiate() -> ProblemDetailsViewController? {
    return UIStoryboard(name: "Problems", bundle: nil).instantiateViewController(withIdentifier: "ProblemDetailsViewController") as? ProblemDetailsViewController
  }
  
  func showTitle(_ title: String) {
    lblTitle.text = title
  }
  
  func showCode(_ code: String) {
    lblCode.text = code
  }
  
  func showProblemName(_ name: String) {
    lblProblemName.text = name
  }
  
  func showProblemValue(_ value: String) {
    lblProblemValue.text = value
  }
  
  func showNormalValue(_ value: String) {
    lblNormalValue.text = value
  }
  
  func showInfo(_ info: String) {
    txtInfo.text = info
  }
}
