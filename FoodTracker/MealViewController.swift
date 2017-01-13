//
//  ViewController.swift
//  FoodTracker
//
//  Created by Charlie Hebert on 12/20/16.
//  Copyright © 2016 Charlie Hebert. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  //MARK: Properties
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nameTextField.delegate = self
  }

  //MARK: UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
  }

  //MARK: UIImagePickerControllerDelegate
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }

  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [String : Any]) {

    func getOriginalImage(info: [String: Any]) -> UIImage {
      guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
        UIImage else {
        fatalError("Expected a dictionary containing an image, but was " +
          "provided the following: \(info)")
      }
      return selectedImage
    }
    let selectedImage = getOriginalImage(info: info)
    photoImageView.image = selectedImage
    dismiss(animated: true, completion: nil)
  }

  //MARK: Actions
  @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
    func onlyAllowPhotosToBePicked(imagePickerController:
      UIImagePickerController) {
      imagePickerController.sourceType = .photoLibrary
    }
    func haveViewControllerBeNotifiedWhenUserPicksAnImage(
      imagePickerController: UIImagePickerController,
      viewController:
      UINavigationControllerDelegate & UIImagePickerControllerDelegate) {
      imagePickerController.delegate = viewController
    }

    nameTextField.resignFirstResponder()
    let imagePickerController = UIImagePickerController()
    onlyAllowPhotosToBePicked(imagePickerController: imagePickerController)
    haveViewControllerBeNotifiedWhenUserPicksAnImage(
      imagePickerController: imagePickerController,
      viewController: self)
    present(imagePickerController, animated: true, completion: nil)
  }
}

