//
//  SuccessConnectViewController.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class SuccessConnectViewController: UIViewController {
  var presenter: SuccessConnectPresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var successfullConnectContainer: UIView!
  @IBOutlet private weak var lblTitle: UILabel!
  
  @IBOutlet private weak var scanProgressContainer: UIView!
  @IBOutlet private weak var progressScan: UIProgressView!
  
  //MARK: -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
  }
  
  //MARK: - Actions
  
  @IBAction private func btnBackPressed(_ sender: UIBarButtonItem) {
    presenter?.backAction()
  }
  
  @IBAction private func btnScanPressed(_ sender: UIButton) {
    presenter?.scanAction()
  }
  
  @IBAction private func btnCancelPressed(_ sender: UIButton) {
    presenter?.cancelAction()
  }
}

//MARK: -
extension SuccessConnectViewController: SuccessConnectView {
  static func instantiate() -> SuccessConnectViewController? {
    return UIStoryboard(name: "Scan", bundle: nil).instantiateViewController(withIdentifier: "SuccessConnectViewController") as? SuccessConnectViewController
  }
  
  func showMode(_ mode: ScanMode) {
    successfullConnectContainer.isHidden = mode == .scan
    scanProgressContainer.isHidden = mode == .successfull
  }
  
  func showTitle(_ title: String) {
    lblTitle.text = title
  }
  
  func showProgress(_ progress: Float) {
    progressScan.progress = progress
  }
}


