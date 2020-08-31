//
//  AdapterView.swift
//  Driva
//
//  Created by iDeveloper on 21.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class AdapterView: UIView {
  
  var logo: UIImage? {
    set { imgLogo.image = newValue }
    get { return imgLogo.image }
  }
  
  var title: String? {
    set { lblTitle.text = newValue }
    get { return lblTitle.text }
  }
  
  var status: String? {
    set { lblStatus.text = newValue }
    get { return lblStatus.text }
  }
  
  var connectAction: (() -> ())?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgLogo: UIImageView!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblStatus: UILabel!
  
  //MARK: - Static
  
  static func instantiate() -> AdapterView? {
    guard let adapterView = UINib(nibName: "AdapterView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? AdapterView else { return nil }
    
    return adapterView
  }
  
  //MARK: - Actions
  
  @IBAction private func btnConnectPressed(_ sender: UIButton) {
    connectAction?()
  }
}
