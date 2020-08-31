//
//  MenuViewController.swift
//  Driva
//
//  Created by iDeveloper on 15.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

open class MenuViewController: UIViewController {

    public weak var menuContainerViewController: MenuContainerViewController?
    var navigationMenuTransitionDelegate: MenuTransitioningDelegate?

    @objc func handleTap(recognizer: UIGestureRecognizer){
        menuContainerViewController?.hideSideMenu()
    }
}
