//
//  PhotoEditViewController.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class PhotoEditViewController: UIViewController {
  var presenter: PhotoEditPresenter?
  
  private var image: UIImage?
  private var croppingStyle = CropViewCroppingStyle.default
  
  private var croppedRect = CGRect.zero
  private var croppedAngle = 0
  
  private lazy var cropController = CropViewController(croppingStyle: .circular, image: image!)
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var cropContainer: UIView!
//  @IBOutlet private weak var imgPhoto: UIImageView!
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
  }
  
  //MARK: - Actions
  
  @IBAction private func btnPicturePressed(_ sender: UIButton) {
    presenter?.pictureAction()
  }
  
  @IBAction private func btnCropPressed(_ sender: UIButton) {
    presenter?.cropAction()
  }
  
  @IBAction private func btnResetPressed(_ sender: UIButton) {
    presenter?.resetAction()
  }
  
  @IBAction private func btnPencilPressed(_ sender: UIButton) {
    presenter?.pencilAction()
  }
  
  @IBAction private func btnSharePressed(_ sender: UIButton) {
    presenter?.shareAction()
  }
  
  @IBAction private func btnConfirmPressed(_ sender: UIBarButtonItem) {
    cropController.doneButtonTap()
  }
}

//MARK: - PhotoEditView
extension PhotoEditViewController: PhotoEditView {
  static func instantiate() -> PhotoEditViewController? {
    return UIStoryboard(name: "PhotoEdit", bundle: nil).instantiateViewController(withIdentifier: "PhotoEditViewController") as? PhotoEditViewController
  }
  
  func showImage(_ image: UIImage) {
    self.image = image
    
    cropController.delegate = self
    
    addChildViewController(cropController)
    cropController.willMove(toParentViewController: self)
    cropContainer.addSubview(cropController.view)
    cropController.view.fillParentWithContraints()
    cropController.didMove(toParentViewController: self)
    
    
    
  }
}

//MARK: - CropViewControllerDelegate
extension PhotoEditViewController: CropViewControllerDelegate {
  public func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
    self.croppedRect = cropRect
    self.croppedAngle = angle
    self.image = image
    
    presenter?.confirmAction(with: image)
  }
}









