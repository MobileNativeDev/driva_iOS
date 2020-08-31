//
//  BaseViewController.swift
//  Driva
//
//  Created by iDeveloper on 07.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

protocol BaseViewController: class where Self: UIViewController {
  static func instantiate() -> Self?
}
