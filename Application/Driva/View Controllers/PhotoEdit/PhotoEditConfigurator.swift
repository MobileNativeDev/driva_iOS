//
//  PhotoEditConfigurator.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import Foundation
import UIKit.UIImage

class PhotoEditConfigurator {
  static func configure(_ view: PhotoEditViewController, with image: UIImage, and confirmAction: @escaping (UIImage?) -> ()) {
    let router = PhotoEditRouterImplementation(view: view)
    let presenter = PhotoEditPresenterImplementation(view: view, router: router, image: image, confirmAction: confirmAction)
    
    view.presenter = presenter
  }
}
