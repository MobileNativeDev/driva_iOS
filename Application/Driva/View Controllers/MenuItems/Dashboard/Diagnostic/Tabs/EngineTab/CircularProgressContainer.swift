//
//  CircularProgressContainer.swift
//  Driva
//
//  Created by iDeveloper on 10.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class CircularProgressContainer: UIView {
  
  @IBOutlet private weak var progressView: CircularProgress!
  @IBOutlet private weak var lblValue: UILabel!
  
  var progressColor: UIColor? {
    get { return progressView.progressColor }
    set {
      if let color = newValue {
        progressView.progressColor = color
      }
    }
  }
  
  func setPercent(_ percent: Int, animated: Bool) {
    let angle = 360 * (Double(percent) / 100.0)
    if animated {
      progressView.animate(fromAngle: 0, toAngle: angle, duration: 0.6, relativeDuration: false, completion: nil)
    } else {
      progressView.angle = angle
    }
    lblValue.text = "\(percent)%"
  }
}
