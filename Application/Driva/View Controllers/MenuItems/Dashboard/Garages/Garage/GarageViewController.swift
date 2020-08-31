//
//  GarageViewController.swift
//  Driva
//
//  Created by iDeveloper on 14.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class GarageViewController: UIViewController {
  var presenter: GaragePresenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgAvatar: UIImageView!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblAddress: UILabel!
  @IBOutlet private weak var btnLink: UIButton!
  
  @IBOutlet private weak var lblTotalBooked: UILabel!
  @IBOutlet private weak var lblRating: UILabel!
  @IBOutlet private weak var lblYears: UILabel!
  
  @IBOutlet private weak var garageTabbar: GarageTabBar! {
    didSet {
      garageTabbar.tabSelectedAction = { [weak self] tab in
        self?.openTab(tab)
      }
    }
  }
  @IBOutlet private weak var tabsContainer: UIView!
  
  //MARK: -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
  }
  
  //MARK: -
  
  private func openTab(_ tab: GarageTab) {
    var _tabView: UIView?

    switch tab {
    case .profile:
      _tabView = GarageProfileTab.instantiate()
      if let garageProfileTab = _tabView as? GarageProfileTab, let garage = presenter?.getGarageInfo() {
        garageProfileTab._description = garage.profile
      }
    case .gallery:
      _tabView = GarageGalleryTab.instantiate()
      if let garageGalleryTab = _tabView as? GarageGalleryTab, let garage = presenter?.getGarageInfo() {
        garageGalleryTab.images = garage.images
      }
    }

    tabsContainer.subviews.forEach({ $0.removeFromSuperview() })

    guard let tabView = _tabView else { return }
    tabsContainer.addSubview(tabView)
    tabView.fillParentWithContraints()
    tabsContainer.layoutIfNeeded()
  }
  
  //MARK: - Actions
  
  @IBAction private func btnBackPressed(_ sender: UIButton) {
    presenter?.backAction()
  }
  
  @IBAction private func btnBookPressed(_ sender: UIButton) {
    presenter?.bookAction()
  }
  
  @IBAction private func btnCallPressed(_ sender: UIButton) {
    presenter?.callAction()
  }
  
  @IBAction private func btnFavoritePressed(_ sender: UIBarButtonItem) {
    presenter?.favoriteAction()
  }
  
  @IBAction private func btnLinkPressed(_ sender: UIButton) {
    guard let title = sender.title(for: .normal), let link = URL(string: title) else { return }
    presenter?.linkAction(link)//UIApplication.shared.open(link, options: [:], completionHandler: nil)
  }
}

//MARK: - GarageView
extension GarageViewController: GarageView {
  static func instantiate() -> GarageViewController? {
    let storyboard = UIStoryboard(name: "Garages", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "GarageViewController") as? GarageViewController
  }
  
  func showImage(_ image: UIImage) {
    imgAvatar.image = image
  }
  
  func showTitle(_ title: String) {
    lblTitle.text = title
  }
  
  func showAddress(_ address: String) {
    lblAddress.text = address
  }
  
  func showLink(_ link: String) {
    btnLink.setTitle(link, for: .normal)
  }
  
  func show(totalBooked: String, starRating: String, yearsMember: String) {
    lblTotalBooked.text = totalBooked
    lblRating.text = starRating
    lblYears.text = yearsMember
  }
  
  func showTab(_ tab: GarageTab) {
    garageTabbar.activeTab = tab
    openTab(tab)
  }
}
