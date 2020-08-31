//
//  SignUpStep2ViewController.swift
//  Driva
//
//  Created by iDeveloper on 17.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

final class SignUpStep2ViewController: UIViewController {
  var presenter: SignUpStep2Presenter?
  
  //MARK: - IBOutlets
  
  @IBOutlet private weak var imgPhoto: UIImageView!
  @IBOutlet private weak var btnUpload: UIButton!
  
  //MARK: - UIViewController overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    SignUpStep2Configurator.configure(self)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  //MARK: - IBActions
  
  @IBAction private func btnSignUpPressed(_ sender: UIButton) {
    presenter?.signUpAction()
  }
  
  @IBAction private func btnSkipPressed(_ sender: UIBarButtonItem) {
    presenter?.skipAction()
  }
  
  @IBAction private func btnUploadPressed(_ sender: UIButton) {
    presenter?.uploadAction()
  }
}

//MAKE: - SignUpStep2View
extension SignUpStep2ViewController: SignUpStep2View {
  static func instantiate() -> SignUpStep2ViewController? {
    return UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SignUpStep2ViewController") as? SignUpStep2ViewController
  }
  
  func showImagePicker() {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = false
    picker.sourceType = .photoLibrary

    present(picker, animated: true) { }
  }
  
  func showImage(_ resultImage: UIImage?) {
    imgPhoto.image = resultImage
    if resultImage != nil {
      btnUpload.setImage(nil, for: .normal)
      imgPhoto.backgroundColor = .clear
    }
  }
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension SignUpStep2ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      picker.dismiss(animated: true) { [weak self] in
        self?.presenter?.photoPicked(pickedImage)
      }
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}







