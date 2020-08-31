//
//  ConnectViewController.swift
//  Driva
//
//  Created by iDeveloper on 20.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class ConnectViewController: UIViewController {
  var presenter: ConnectPresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var searchProgressView: UIView!
  @IBOutlet private weak var progressView: UIProgressView!
  
  
  @IBOutlet private weak var searchResultView: UIView!
  @IBOutlet private weak var lblFound: UILabel!
  @IBOutlet private weak var stckAdapters: UIStackView!
  
  //MARK: -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ConnectConfigurator.configure(self)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presenter?.viewDidAppear()
  }
  
  //MARK: - Actions
  
  @IBAction private func btnBackPressed(_ sender: UIBarButtonItem) {
    presenter?.backAction()
  }
  
  @IBAction private func btnCancelPressed(_ sender: UIButton) {
    presenter?.cancelAction()
  }
  
  @IBAction private func btnScanAgainPressed(_ sender: UIButton) {
    presenter?.scanAgainAction()
  }
}

//MARK: -
extension ConnectViewController: ConnectView {
  static func instantiate() -> ConnectViewController? {
    return UIStoryboard(name: "Scan", bundle: nil).instantiateViewController(withIdentifier: "ConnectViewController") as? ConnectViewController
  }
  
  func showProgress(_ progress: Float) {
    progressView.progress = progress
  }
  
  func showSearch(_ mode: SearchMode) {
    searchResultView.isHidden = mode == .progress
    searchProgressView.isHidden = mode == .result
    
    lblFound.text = "\(presenter?.numberOfAdapters ?? 0) Adapter(s) Found"
    
    if mode == .result {
      let ratio: CGFloat = 5.0
      let width = stckAdapters.bounds.width
      let height = width / ratio
      
      stckAdapters.arrangedSubviews.forEach({ $0.removeFromSuperview() })
      
      for i in 0..<(presenter?.numberOfAdapters ?? 0) {
        if let connectView = AdapterView.instantiate() {
          presenter?.configureAdapter(connectView, for: i)
          connectView.addConstraint(NSLayoutConstraint(item: connectView, attribute: .height, relatedBy: .equal,
                                                         toItem: nil, attribute: .height, multiplier: 1.0, constant: height))
          stckAdapters.addArrangedSubview(connectView)
        }
      }
    }
  }
}


