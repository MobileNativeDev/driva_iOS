//
//  RoundedView.swift
//  Driva
//
//  Created by iDeveloper on 10.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = min(frame.width, frame.height) * 0.5
  }
}

@IBDesignable
class RoundedImageView: UIImageView {
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = min(frame.width, frame.height) * 0.5
  }
}

@IBDesignable
class RoundedButton: UIButton {
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = min(frame.width, frame.height) * 0.5
  }
}
