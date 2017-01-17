//
//  ViewController.swift
//  FoodTracker
//
//  Created by Charlie Hebert on 12/20/16.
//  Copyright © 2016 Charlie Hebert. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  //MARK: Properties
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  @IBOutlet weak var saveButton: UIBarButtonItem!

  /*
   This value is either passed by `MealTableViewController` in 
   `prepare(for:sender:)`
   or constructed as part of adding a new meal.
   */
  var meal: Meal?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nameTextField.delegate = self
    if let meal = meal {
      navigationItem.title = meal.name
      nameTextField.text = meal.name
      photoImageView.image = meal.photo
      ratingControl.rating = meal.rating
    }
    updateSaveButtonState()
  }

  //MARK: UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  func textFieldDidBeginEditing(_ textField: UITextField) {
    saveButton.isEnabled = false
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    updateSaveButtonState()
    navigationItem.title = textField.text
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

  //MARK: Navigation
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    let isPresentingInAddMealMode = presentingViewController is
    UINavigationController
    if isPresentingInAddMealMode {
      dismiss(animated: true, completion: nil)
    } else if let owningNavigationController = navigationController {
      owningNavigationController.popViewController(animated: true)
    } else {
      fatalError("The MealViewController is not inside a navigation" +
        "controller.")
    }
  }

  // This method lets you configure a view controller before it's presented.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    guard let button = sender as? UIBarButtonItem, button === saveButton else {
      os_log("The save button was not pressed, canceling",
             log: OSLog.default,
             type: .debug)
      return
    }
    let name = nameTextField.text ?? ""
    let photo = photoImageView.image
    let rating = ratingControl.rating
    meal = Meal(name: name, photo: photo, rating: rating)
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

  private func updateSaveButtonState() {
    let text = nameTextField.text ?? ""
    saveButton.isEnabled = !text.isEmpty
  }
}

