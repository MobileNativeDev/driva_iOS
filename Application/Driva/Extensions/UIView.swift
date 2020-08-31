//
//  UIView.swift
//  Driva
//
//  Created by iDeveloper on 07.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

extension UIView {
  
  //MARK: - IBInspectables
  
  @IBInspectable
  var cornerRadius: CGFloat {
    get { return self.cornerRadius }
    set { layer.cornerRadius = newValue }
  }
  
  @IBInspectable
  var borderWidth: CGFloat {
    get { return self.borderWidth }
    set { layer.borderWidth = newValue }
  }
  
  @IBInspectable
  var borderColor: UIColor {
    get { return self.borderColor }
    set { layer.borderColor = newValue.cgColor }
  }
  
  //MARK: -
  
  func fillParentWithContraints(with leftInset: String = "0") {
    guard let parent = superview else { return }
    
    translatesAutoresizingMaskIntoConstraints = false
    parent.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|",
                                                         options: NSLayoutFormatOptions.directionLeftToRight,
                                                         metrics: nil,
                                                         views: ["view": self]))
    parent.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(leftInset)-[view]-0-|",
                                                         options: NSLayoutFormatOptions.directionLeftToRight,
                                                         metrics: nil,
                                                         views: ["view": self]))
  }
  
  func addLayoutRatio(_ ratio: CGFloat) {
    addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal,
                                     toItem: self, attribute: .width, multiplier: ratio, constant: 0))
  }
}
