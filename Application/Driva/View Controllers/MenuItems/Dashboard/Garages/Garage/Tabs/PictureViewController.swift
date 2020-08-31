//
//  PictureViewController.swift
//  Driva
//
//  Created by iDeveloper on 29.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {
  
  var image: UIImage?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var cnstrImageWidth: NSLayoutConstraint!
  @IBOutlet private weak var cnstrImageHeight: NSLayoutConstraint!
  @IBOutlet private weak var imgContent: UIImageView!
  
  //MARK: -
  
  static func instantiate() -> PictureViewController? {
    return UIStoryboard(name: "PictureController", bundle: nil).instantiateViewController(withIdentifier: "PictureViewController") as? PictureViewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imgContent.image = image
  }
  
  override func viewDidLayoutSubviews() {
    if let image = image {
      let inset: CGFloat = 20.0
      
      let ratio = image.size.width / image.size.height
      if ratio > 1 {
        let width = view.bounds.width - 2 * inset
        cnstrImageWidth.constant = width
        cnstrImageHeight.constant = width / ratio
      } else {
        let height = view.bounds.height - 2 * inset
        cnstrImageHeight.constant = height
        cnstrImageWidth.constant = height * ratio
      }
    }
    
    super.viewDidLayoutSubviews()
  }
  
  @IBAction private func tapAction(_ sender: UITapGestureRecognizer) {
    dismiss(animated: true, completion: nil)
  }
}
